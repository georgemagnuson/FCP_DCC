<?php
/**
 * FcpParserFunctions — display FCP API data in wiki pages.
 *
 * Usage:
 *   {{#fcp_query: endpoint=temperature/today | equipment_id=<uuid> | format=table}}
 *   {{#fcp_query: endpoint=temperature/summary/<uuid> | days=7 | format=summary}}
 *   {{#fcp_query: endpoint=cooling/active | location_id=<uuid> | format=table}}
 *   {{#fcp_query: endpoint=incidents/open | location_id=<uuid> | format=table}}
 *   {{#fcp_dashboard: business_id=<uuid> | location_id=<uuid>}}
 *   {{#fcp_equipment_table: location_id=<uuid>}}
 *
 * Supported formats:
 *   table   — HTML table of results
 *   summary — key/value pairs (for single-object responses)
 *   count   — just the number of rows returned
 *   raw     — JSON (for debugging)
 */
class FcpParserFunctions {

	public static function onParserFirstCallInit( \Parser $parser ): void {
		$parser->setFunctionHook( 'fcp_query',           [ self::class, 'fcpQuery' ] );
		$parser->setFunctionHook( 'fcp_employee',        [ self::class, 'fcpEmployee' ] );
		$parser->setFunctionHook( 'fcp_employee_list',   [ self::class, 'fcpEmployeeList' ] );
		$parser->setFunctionHook( 'fcp_training_record', [ self::class, 'fcpTrainingRecord' ] );
		$parser->setFunctionHook( 'fcp_dashboard',       [ self::class, 'fcpDashboard' ] );
		$parser->setFunctionHook( 'fcp_equipment_table',   [ self::class, 'fcpEquipmentTable' ] );
		$parser->setFunctionHook( 'fcp_temperature_form',  [ self::class, 'fcpTemperatureForm' ] );
		$parser->setFunctionHook( 'fcp_incident_form',     [ self::class, 'fcpIncidentForm' ] );
	}

	/**
	 * {{#fcp_employee_list:}} — render the employee directory table from PostgreSQL.
	 * Displays all active employees with name (linked to their wiki page) and role.
	 */
	public static function fcpEmployeeList( \Parser $parser, ...$rawArgs ): array {
		$user = $parser->getUserIdentity();
		$mwUser = \MediaWiki\MediaWikiServices::getInstance()
			->getUserFactory()
			->newFromUserIdentity( $user );

		try {
			$client = new FcpApiClient();
			$data   = $client->get( 'employees', [], $mwUser );
		} catch ( \RuntimeException $e ) {
			return [
				'<span class="error">FCP employee list error: ' . htmlspecialchars( $e->getMessage() ) . '</span>',
				'noparse' => true,
				'isHTML'  => true,
			];
		}

		if ( empty( $data ) ) {
			return [ '<p><em>No employees found.</em></p>', 'noparse' => true, 'isHTML' => true ];
		}

		$html = '<table class="wikitable" style="width:100%">'
			. '<tr>'
			. '<th style="width:50%;color:#000;">Name</th>'
			. '<th style="color:#000;">Role</th>'
			. '</tr>';

		$specialBase = \SpecialPage::getTitleFor( 'FcpEmployee' )->getLocalURL();
		foreach ( $data as $emp ) {
			$name     = htmlspecialchars( $emp['full_name'] ?? '' );
			$role     = htmlspecialchars( $emp['role']      ?? '' );
			$username = $emp['mediawiki_username'] ?? $emp['full_name'] ?? '';
			$usernameForUrl = str_replace( ' ', '_', $username );
			$href     = htmlspecialchars( $specialBase . '?employee=' . urlencode( $usernameForUrl ) );
			$html .= "<tr><td><a href=\"{$href}\">{$name}</a></td><td>{$role}</td></tr>";
		}

		$html .= '</table>';
		return [ $html, 'noparse' => true, 'isHTML' => true ];
	}

	/**
	 * {{#fcp_employee:}} — render employee info card from PostgreSQL.
	 *
	 * Derives the mediawiki_username from the current page's subpage title.
	 * The page JITSU_EMPLOYEES:TheJitsu/Carlos_Chef → subpage "Carlos_Chef".
	 * Underscores are converted to spaces to match stored usernames.
	 *
	 * Optional override: {{#fcp_employee: username=Carlos Chef}}
	 */
	public static function fcpEmployee( \Parser $parser, ...$rawArgs ): array {
		// Parse optional named args
		$args = [];
		foreach ( $rawArgs as $arg ) {
			if ( str_contains( $arg, '=' ) ) {
				[ $k, $v ] = explode( '=', $arg, 2 );
				$args[ trim( $k ) ] = trim( $v );
			}
		}

		// Derive username: explicit override, or subpage of current title
		if ( isset( $args['username'] ) && $args['username'] !== '' ) {
			$username = $args['username'];
		} else {
			$title    = $parser->getTitle();
			$text     = $title->getText(); // e.g. "TheJitsu/Carlos_Chef"
			$parts    = explode( '/', $text );
			$subpage  = end( $parts );
			$username = str_replace( '_', ' ', $subpage );
		}

		$user = $parser->getUserIdentity();
		$mwUser = \MediaWiki\MediaWikiServices::getInstance()
			->getUserFactory()
			->newFromUserIdentity( $user );

		try {
			$client = new FcpApiClient();
			// Use underscores — URL-safe, no percent-encoding needed.
		// Python side normalises underscores→spaces before querying.
		$usernameForUrl = str_replace( ' ', '_', $username );
		$data   = $client->get( 'employees/by-username/' . $usernameForUrl, [], $mwUser );
		} catch ( \RuntimeException $e ) {
			return [
				'<span class="error">FCP employee error: ' . htmlspecialchars( $e->getMessage() ) . '</span>',
				'noparse' => true,
				'isHTML'  => true,
			];
		}

		$html = self::renderEmployeeCard( $data, $parser->getTitle() );
		return [ $html, 'noparse' => true, 'isHTML' => true ];
	}

	/**
	 * Render the employee info card HTML.
	 */
	private static function renderEmployeeCard( array $e, \Title $title ): string {
		$name     = htmlspecialchars( $e['full_name']                ?? '—' );
		$role     = htmlspecialchars( $e['role']                     ?? '—' );
		$username = htmlspecialchars( $e['mediawiki_username']       ?? '—' );
		$cert     = htmlspecialchars( $e['food_handler_cert_number'] ?? '—' );
		$expiry   = htmlspecialchars( $e['cert_expiry']              ?? '—' );
		$active   = ( $e['is_active'] ?? true ) ? 'Active' : 'Inactive';

		// Training subpage link
		$trainingTitle = \Title::newFromText( 'JITSU_EMPLOYEES:' . $title->getText() . '/Training' );
		if ( $trainingTitle && $trainingTitle->exists() ) {
			$trainingHref = htmlspecialchars( $trainingTitle->getLocalURL() );
			$trainingLink = "<div style=\"margin:10px 0;\"><strong><a href=\"{$trainingHref}\">&#128203; View Training Record</a></strong></div>";
		} else {
			$trainingLink = '<div style="margin:10px 0;padding:10px;background:#fff3cd;border:1px solid #ffc107;border-radius:4px;">Training record not yet set up.</div>';
		}

		return <<<HTML
<h2>Employee Information</h2>
<table class="wikitable" style="width:60%">
<tr><th style="width:30%;color:#000;">Full Name</th><td>{$name}</td></tr>
<tr><th style="color:#000;">Position</th><td>{$role}</td></tr>
<tr><th style="color:#000;">Status</th><td>{$active}</td></tr>
<tr><th style="color:#000;">MediaWiki Username</th><td>{$username}</td></tr>
<tr><th style="color:#000;">Food Handler Cert</th><td>{$cert}</td></tr>
<tr><th style="color:#000;">Cert Expiry</th><td>{$expiry}</td></tr>
</table>
<hr>
{$trainingLink}
HTML;
	}

	/**
	 * {{#fcp_training_record:}} — render the full training record table for an employee.
	 *
	 * Derives the employee username from the page title.
	 * Page: JITSU_EMPLOYEES:TheJitsu/Carlos_Chef/Training
	 *   → parts: [TheJitsu, Carlos_Chef, Training]
	 *   → employee subpage: Carlos_Chef → "Carlos Chef"
	 */
	public static function fcpTrainingRecord( \Parser $parser, ...$rawArgs ): array {
		$title  = $parser->getTitle();
		$parts  = explode( '/', $title->getText() );
		// Second-to-last part is the employee subpage (last part is "Training")
		$empSubpage     = count( $parts ) >= 2 ? $parts[ count( $parts ) - 2 ] : $parts[0];
		$usernameForUrl = $empSubpage; // underscores are URL-safe; Python normalises them

		$user = $parser->getUserIdentity();
		$mwUser = \MediaWiki\MediaWikiServices::getInstance()
			->getUserFactory()
			->newFromUserIdentity( $user );

		try {
			$client = new FcpApiClient();
			$data   = $client->get( 'training/employee/' . $usernameForUrl, [], $mwUser );
		} catch ( \RuntimeException $e ) {
			return [
				'<span class="error">FCP training error: ' . htmlspecialchars( $e->getMessage() ) . '</span>',
				'noparse' => true,
				'isHTML'  => true,
			];
		}

		$userGroupManager = \MediaWiki\MediaWikiServices::getInstance()->getUserGroupManager();
		$groups = $userGroupManager->getUserGroups( $mwUser );
		$isManager    = in_array( 'training_manager',    $groups );
		$isSupervisor = in_array( 'training_supervisor', $groups );
		$isEmployee   = in_array( 'training_employee',   $groups );
		// sysop can do everything
		if ( in_array( 'sysop', $groups ) ) {
			$isManager = $isSupervisor = $isEmployee = true;
		}

		$modules  = $data['modules'] ?? [];

		if ( empty( $modules ) ) {
			return [ '<p><em>No training modules found for this employee.</em></p>', 'noparse' => true, 'isHTML' => true ];
		}

		$html = '<table class="wikitable sortable" style="width:100%">'
			. '<tr>'
			. '<th style="color:#000;">Status</th>'
			. '<th style="color:#000;">Category</th>'
			. '<th style="color:#000;">Module Name</th>'
			. '<th style="color:#000;">Assigned</th>'
			. '<th style="color:#000;">Completed</th>'
			. '<th style="color:#000;">Verified</th>'
			. '</tr>';

		$statusLabels = [
			'verified'     => '<span style="color:#155724;font-weight:bold;">&#10003; Verified</span>',
			'completed'    => '<span style="color:#0c5460;font-weight:bold;">&#10003; Completed</span>',
			'na'           => '<span style="color:#856404;">N/A</span>',
			'assigned'     => '<span style="color:#383d41;">Assigned</span>',
			'not_assigned' => '<span style="color:#999;">Not Assigned</span>',
		];

		$specialBase = \SpecialPage::getTitleFor( 'FcpTrainingAction' )->getLocalURL();
		$returnPage  = $title->getPrefixedText();

		foreach ( $modules as $m ) {
			$moduleCode = $m['module_code'];
			$moduleName = htmlspecialchars( $m['module_name'] );
			$category   = htmlspecialchars( ucfirst( $m['category'] ) );
			$status     = $m['status'] ?? 'not_assigned';
			$statusHtml = $statusLabels[ $status ] ?? htmlspecialchars( $status );

			// --- Assigned cell ---
			$assignedDate = $m['assigned_date'] ? htmlspecialchars( $m['assigned_date'] ) : '';
			if ( $isManager && ( $status === 'not_assigned' || $status === 'assigned' ) ) {
				$url = $specialBase . '?' . http_build_query( [
					'employee' => $usernameForUrl, 'module' => $moduleCode,
					'action' => 'assign', 'return' => $returnPage,
				] );
				$assignedCell = $assignedDate
					? $assignedDate . ' <small>[<a href="' . htmlspecialchars( $url ) . '">Re-assign</a>]</small>'
					: '<a href="' . htmlspecialchars( $url ) . '">Assign</a>';
				if ( $status === 'not_assigned' ) {
					$naUrl = $specialBase . '?' . http_build_query( [
						'employee' => $usernameForUrl, 'module' => $moduleCode,
						'action' => 'na', 'return' => $returnPage,
					] );
					$assignedCell .= ' <small>[<a href="' . htmlspecialchars( $naUrl ) . '">N/A</a>]</small>';
				}
			} else {
				$assignedCell = $assignedDate ?: '&mdash;';
			}

			// --- Completed cell ---
			$completedDate = $m['completed_date'] ? htmlspecialchars( $m['completed_date'] ) : '';
			if ( ( $isEmployee || $isSupervisor ) && $status === 'assigned' ) {
				$url = $specialBase . '?' . http_build_query( [
					'employee' => $usernameForUrl, 'module' => $moduleCode,
					'action' => 'complete', 'return' => $returnPage,
				] );
				$completedCell = '<a href="' . htmlspecialchars( $url ) . '">Mark Complete</a>';
			} else {
				$completedCell = $completedDate ?: '&mdash;';
			}

			// --- Verified cell ---
			$verifiedDate = $m['verified_date'] ? htmlspecialchars( $m['verified_date'] ) : '';
			if ( $isSupervisor && $status === 'completed' ) {
				$url = $specialBase . '?' . http_build_query( [
					'employee' => $usernameForUrl, 'module' => $moduleCode,
					'action' => 'verify', 'return' => $returnPage,
				] );
				$verifiedCell = '<a href="' . htmlspecialchars( $url ) . '">Verify</a>';
			} else {
				$verifiedCell = $verifiedDate ?: '&mdash;';
			}

			$html .= "<tr><td>{$statusHtml}</td><td>{$category}</td><td>{$moduleName}</td>"
				. "<td>{$assignedCell}</td><td>{$completedCell}</td><td>{$verifiedCell}</td></tr>";
		}

		$html .= '</table>';
		return [ $html, 'noparse' => true, 'isHTML' => true ];
	}

	/**
	 * {{#fcp_dashboard: business_id=<uuid> | location_id=<uuid>}}
	 *
	 * Renders the daily compliance dashboard: opening/closing check status,
	 * temperature reading count, and active cooling events.
	 */
	public static function fcpDashboard( \Parser $parser, ...$rawArgs ): array {
		$args = [];
		foreach ( $rawArgs as $arg ) {
			if ( str_contains( $arg, '=' ) ) {
				[ $k, $v ] = explode( '=', $arg, 2 );
				$args[ trim( $k ) ] = trim( $v );
			}
		}

		$businessId = $args['business_id'] ?? '';
		$locationId = $args['location_id'] ?? '';

		if ( !$businessId || !$locationId ) {
			return [
				'<span class="error">fcp_dashboard: business_id and location_id are required</span>',
				'noparse' => true, 'isHTML' => true,
			];
		}

		$user = $parser->getUserIdentity();
		$mwUser = \MediaWiki\MediaWikiServices::getInstance()
			->getUserFactory()
			->newFromUserIdentity( $user );

		try {
			$client = new FcpApiClient();
			$data   = $client->get( 'diary/dashboard/today', [
				'business_id' => $businessId,
				'location_id' => $locationId,
			], $mwUser );
		} catch ( \RuntimeException $e ) {
			return [
				'<span class="error">FCP dashboard error: ' . htmlspecialchars( $e->getMessage() ) . '</span>',
				'noparse' => true, 'isHTML' => true,
			];
		}

		$html = self::renderDashboard( $data );
		return [ $html, 'noparse' => true, 'isHTML' => true ];
	}

	private static function renderDashboard( array $data ): string {
		$date = htmlspecialchars( $data['date'] ?? '' );

		// Helper: render one daily check status card
		$card = static function ( string $label, array $check, string $formPage ): string {
			$done  = $check['done']       ?? false;
			$allOk = $check['all_ok']     ?? null;
			$by    = htmlspecialchars( $check['checked_by'] ?? '' );
			$time  = htmlspecialchars( $check['time']       ?? '' );

			if ( $done ) {
				$colour = $allOk !== false ? '#d4edda' : '#f8d7da';
				$border = $allOk !== false ? '#c3e6cb' : '#f5c6cb';
				$status = $allOk !== false ? '&#10003; Done' : '&#10003; Done (issues noted)';
				$detail = $time ? " by {$by} at {$time}" : " by {$by}";
			} else {
				$colour = '#fff3cd';
				$border = '#ffeeba';
				$status = '&#9711; Not yet recorded';
				$detail = '';
			}

			$link = "/mediawiki/index.php/" . rawurlencode( str_replace( ' ', '_', $formPage ) );
			return "<div style=\"background:{$colour};border:1px solid {$border};border-radius:6px;"
				. "padding:12px 16px;margin:8px 0;\">"
				. "<strong>{$label}</strong> &mdash; {$status}{$detail}"
				. " <small>[<a href=\"{$link}\">Record</a>]</small>"
				. "</div>";
		};

		$opening = $card( 'Opening Check', $data['opening_check'] ?? [], 'FCP_MAIN:Opening_Check' );
		$closing = $card( 'Closing Check', $data['closing_check'] ?? [], 'FCP_MAIN:Closing_Check' );

		// Temperature count section
		$tempCount  = (int)( $data['temperature_readings_today'] ?? 0 );
		$tempColour = $tempCount > 0 ? '#d4edda' : '#fff3cd';
		$tempBorder = $tempCount > 0 ? '#c3e6cb' : '#ffeeba';
		$tempStatus = $tempCount > 0
			? "&#10003; {$tempCount} reading(s) recorded today"
			: "&#9711; No readings yet";
		$tempSection = "<div style=\"background:{$tempColour};border:1px solid {$tempBorder};border-radius:6px;"
			. "padding:12px 16px;margin:8px 0;\">"
			. "<strong>Temperature Log</strong> &mdash; {$tempStatus}"
			. " <small>[<a href=\"/mediawiki/index.php/FCP_MAIN:Temperature_Log\">Record</a>]</small>"
			. "</div>";

		// Active cooling events section
		$coolingEvents = $data['active_cooling_events'] ?? [];
		if ( empty( $coolingEvents ) ) {
			$coolingSection = "<div style=\"background:#e2e3e5;border:1px solid #d6d8db;border-radius:6px;"
				. "padding:12px 16px;margin:8px 0;\">"
				. "<strong>Cooling Records</strong> &mdash; No active cooling events"
				. " <small>[<a href=\"/mediawiki/index.php/Special:FcpCoolingRecord?action=start\">Start new</a>]</small>"
				. "</div>";
		} else {
			$coolingRows = '';
			foreach ( $coolingEvents as $ev ) {
				$food  = htmlspecialchars( $ev['food_description'] ?? '' );
				$stage = $ev['stage'] === 'stage_1' ? 'Stage 1 (60&#8594;21&#176;C)' : 'Stage 2 (21&#8594;5&#176;C)';
				$dlKey = $ev['stage'] === 'stage_1' ? 'stage1_deadline' : 'stage2_deadline';
				$dl    = htmlspecialchars( substr( $ev[ $dlKey ] ?? '', 11, 5 ) );
				$evId  = htmlspecialchars( $ev['event_id'] ?? '' );
				$viewUrl = "/mediawiki/index.php/Special:FcpCoolingRecord?action=view&event={$evId}";
				$coolingRows .= "<tr>"
					. "<td>{$food}</td><td>{$stage}</td><td>By {$dl}</td>"
					. "<td><a href=\"{$viewUrl}\">View</a></td>"
					. "</tr>";
			}
			$startUrl = "/mediawiki/index.php/Special:FcpCoolingRecord?action=start";
			$coolingSection = "<div style=\"background:#cce5ff;border:1px solid #b8daff;border-radius:6px;"
				. "padding:12px 16px;margin:8px 0;\">"
				. "<strong>Cooling Records</strong> &mdash; " . count( $coolingEvents ) . " active event(s)"
				. " <small>[<a href=\"{$startUrl}\">Start new</a>]</small>"
				. "<table class=\"wikitable\" style=\"margin:8px 0 0;width:100%;\">"
				. "<tr><th style=\"color:#000;\">Food</th><th style=\"color:#000;\">Stage</th>"
				. "<th style=\"color:#000;\">Deadline</th><th></th></tr>"
				. $coolingRows
				. "</table></div>";
		}

		// Quick links bar
		$quickLinks = "<div style=\"margin-top:16px;padding:10px;background:#f8f9fa;"
			. "border:1px solid #dee2e6;border-radius:6px;\">"
			. "<strong>Quick Links:</strong> "
			. "<a href=\"/mediawiki/index.php/FCP_MAIN:Delivery_Check\">Delivery Check</a> &bull; "
			. "<a href=\"/mediawiki/index.php/FCP_MAIN:Cleaning_Log\">Cleaning Log</a> &bull; "
			. "<a href=\"/mediawiki/index.php/FCP_MAIN:Cooking_Verification\">Cooking Verification</a> &bull; "
			. "<a href=\"/mediawiki/index.php/FCP_MAIN:Incident_Response_Report\">Incident &amp; Response Report</a> &bull; "
			. "<a href=\"/mediawiki/index.php/FCP_MAIN:Weekly_Check\">Weekly Check</a>"
			. "</div>";

		return "<h2>Daily Dashboard &mdash; {$date}</h2>"
			. $opening
			. $closing
			. $tempSection
			. $coolingSection
			. $quickLinks;
	}

	public static function fcpQuery( \Parser $parser, ...$rawArgs ): array {
		// Parse named arguments: endpoint=x | key=value | ...
		$args = [];
		foreach ( $rawArgs as $arg ) {
			if ( str_contains( $arg, '=' ) ) {
				[ $k, $v ] = explode( '=', $arg, 2 );
				$args[ trim( $k ) ] = trim( $v );
			}
		}

		$endpoint = $args['endpoint'] ?? '';
		$format   = $args['format']   ?? 'table';
		unset( $args['endpoint'], $args['format'] );

		if ( !$endpoint ) {
			return [ '<span class="error">fcp_query: endpoint is required</span>', 'noparse' => true, 'isHTML' => true ];
		}

		$user = $parser->getUserIdentity();
		$mwUser = \MediaWiki\MediaWikiServices::getInstance()
			->getUserFactory()
			->newFromUserIdentity( $user );

		try {
			$client = new FcpApiClient();
			$data   = $client->get( $endpoint, $args, $mwUser );
		} catch ( \RuntimeException $e ) {
			return [
				'<span class="error">FCP API error: ' . htmlspecialchars( $e->getMessage() ) . '</span>',
				'noparse' => true,
				'isHTML'  => true,
			];
		}

		$html = self::render( $data, $format );
		return [ $html, 'noparse' => true, 'isHTML' => true ];
	}

	private static function render( mixed $data, string $format ): string {
		if ( empty( $data ) ) {
			return '<p><em>No records found.</em></p>';
		}

		switch ( $format ) {
			case 'count':
				$count = is_array( $data ) && isset( $data[0] ) ? count( $data ) : 1;
				return (string) $count;

			case 'raw':
				return '<pre>' . htmlspecialchars( json_encode( $data, JSON_PRETTY_PRINT ) ) . '</pre>';

			case 'summary':
				// Single object — key/value table
				if ( isset( $data[0] ) ) {
					$data = $data[0];
				}
				return self::renderSummary( $data );

			case 'gallery':
			if ( !isset( $data[0] ) ) {
				$data = [ $data ];
			}
			return self::renderGallery( $data );

		case 'table':
		default:
			// Array of objects — HTML table
			if ( !isset( $data[0] ) ) {
				// Single object, wrap it
				$data = [ $data ];
			}
			return self::renderTable( $data );
		}
	}

	// =========================================================
	// TEMPERATURE FORM — live equipment dropdown + today's readings
	// =========================================================

	/**
	 * {{#fcp_temperature_form: location_id=<uuid> | redirect=FCP_MAIN:Temperature_Log}}
	 *
	 * Renders the temperature recording form with equipment dropdown populated
	 * from the database, plus today's readings per equipment.
	 * Uses a real PHP-generated CSRF token — no JS injection needed.
	 * Parser cache disabled (token is user-specific).
	 */
	public static function fcpTemperatureForm( \Parser $parser, ...$rawArgs ): array {
		$args = [];
		foreach ( $rawArgs as $arg ) {
			if ( str_contains( $arg, '=' ) ) {
				[ $k, $v ] = explode( '=', $arg, 2 );
				$args[ trim( $k ) ] = trim( $v );
			}
		}

		$locationId  = trim( $args['location_id'] ?? '' );
		$redirectTo  = trim( $args['redirect'] ?? 'FCP_MAIN:Temperature_Log' );

		if ( !$locationId ) {
			return [
				'<span class="error">fcp_temperature_form: location_id is required</span>',
				'noparse' => true, 'isHTML' => true,
			];
		}

		$user   = $parser->getUserIdentity();
		$mwUser = \MediaWiki\MediaWikiServices::getInstance()
			->getUserFactory()
			->newFromUserIdentity( $user );

		// Disable parser cache — token and readings are user/time specific
		$parser->getOutput()->updateCacheExpiry( 0 );

		try {
			$client    = new FcpApiClient();
			$equipment = $client->get( 'equipment', [ 'location_id' => $locationId ], $mwUser );
		} catch ( \RuntimeException $e ) {
			return [
				'<span class="error">Equipment load failed: ' . htmlspecialchars( $e->getMessage() ) . '</span>',
				'noparse' => true, 'isHTML' => true,
			];
		}

		if ( empty( $equipment ) ) {
			return [
				'<p><em>No equipment registered for this location.</em></p>',
				'noparse' => true, 'isHTML' => true,
			];
		}

		$token   = htmlspecialchars( $mwUser->getEditToken() );
		$options = '';
		foreach ( $equipment as $eq ) {
			$id      = htmlspecialchars( $eq['id'] );
			$name    = htmlspecialchars( $eq['name'] );
			$options .= "<option value=\"{$id}\">{$name}</option>\n";
		}

		$html = <<<HTML
<div style="background:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;padding:16px;max-width:500px;margin-bottom:1.5em;">
<form method="POST" action="/mediawiki/index.php/Special:FcpSubmit">
<input type="hidden" name="wpEditToken"  value="{$token}">
<input type="hidden" name="fcp_action"   value="temperature/reading">
<input type="hidden" name="fcp_redirect" value="{$redirectTo}">

<table style="width:100%;border-collapse:collapse;">
<tr>
<th style="text-align:left;padding:4px 8px;width:180px;">Equipment</th>
<td style="padding:4px;">
<select name="equipment_id" style="width:100%;padding:6px;">
{$options}
</select>
</td>
</tr>
<tr>
<th style="text-align:left;padding:4px 8px;">Temperature (&#176;C)</th>
<td style="padding:4px;"><input type="number" name="temp_celsius" step="0.1" style="width:100px;padding:6px;" required></td>
</tr>
<tr>
<th style="text-align:left;padding:4px 8px;">Notes</th>
<td style="padding:4px;"><input type="text" name="notes" style="width:100%;padding:6px;" placeholder="Optional"></td>
</tr>
</table>

<div style="margin-top:12px;">
<input type="submit" value="Record Temperature" style="background:#0070c0;color:white;border:none;padding:8px 20px;border-radius:4px;cursor:pointer;font-size:1em;">
</div>
</form>
</div>
HTML;

		// Today's readings per equipment
		$html .= '<h3>Today\'s Readings</h3>';
		foreach ( $equipment as $eq ) {
			$eqId   = $eq['id'];
			$eqName = htmlspecialchars( $eq['name'] );
			try {
				$readings = $client->get( "temperature/today/{$eqId}", [], $mwUser );
			} catch ( \RuntimeException $e ) {
				$readings = [];
			}
			$html .= "<h4>{$eqName}</h4>";
			$html .= empty( $readings )
				? '<p><em>No readings today.</em></p>'
				: self::renderTable( $readings );
		}

		return [ $html, 'noparse' => true, 'isHTML' => true ];
	}

	// =========================================================
	// EQUIPMENT TABLE with Add / Edit / Delete actions
	// =========================================================

	/**
	 * {{#fcp_equipment_table: location_id=<uuid>}}
	 *
	 * Renders the equipment registry table with Add / Edit / Delete action links.
	 * Edit and Delete links are only shown to users in training_manager or sysop groups.
	 */
	public static function fcpEquipmentTable( \Parser $parser, ...$rawArgs ): array {
		$args = [];
		foreach ( $rawArgs as $arg ) {
			if ( str_contains( $arg, '=' ) ) {
				[ $k, $v ] = explode( '=', $arg, 2 );
				$args[ trim( $k ) ] = trim( $v );
			}
		}

		$locationId = trim( $args['location_id'] ?? '' );

		$user   = $parser->getUserIdentity();
		$mwUser = \MediaWiki\MediaWikiServices::getInstance()
			->getUserFactory()
			->newFromUserIdentity( $user );

		if ( !$locationId ) {
			return [ '<span class="error">fcp_equipment_table: location_id is required</span>',
				'noparse' => true, 'isHTML' => true ];
		}

		try {
			$client    = new FcpApiClient();
			$equipment = $client->get( 'equipment', [ 'location_id' => $locationId ], $mwUser );
		} catch ( \RuntimeException $e ) {
			return [ '<span class="error">Equipment load failed: ' . htmlspecialchars( $e->getMessage() ) . '</span>',
				'noparse' => true, 'isHTML' => true ];
		}

		// Determine if the current user can manage equipment
		$ugm        = \MediaWiki\MediaWikiServices::getInstance()->getUserGroupManager();
		$groups     = $ugm->getUserGroups( $mwUser );
		$canManage  = in_array( 'training_manager', $groups, true )
		           || in_array( 'sysop', $groups, true );

		// Disable parser cache — output varies by user group
		$parser->getOutput()->updateCacheExpiry( 0 );

		$html = self::renderEquipmentTable( $equipment, $canManage );
		return [ $html, 'noparse' => true, 'isHTML' => true ];
	}

	private static function renderEquipmentTable( array $rows, bool $canManage ): string {
		$addUrl = htmlspecialchars(
			\Title::newFromText( 'Special:FcpEquipment' )->getLocalURL( [ 'action' => 'add' ] )
		);

		$addBtn = $canManage
			? "<p><a href=\"{$addUrl}\" style=\"background:#28a745;color:white;padding:6px 16px;"
			  . "border-radius:4px;text-decoration:none;display:inline-block;\">+ Add Equipment</a></p>"
			: '';

		if ( empty( $rows ) ) {
			return $addBtn . '<p><em>No equipment registered.</em></p>';
		}

		// Display columns (skip id and category_id — internal fields)
		$displayCols = [ 'category', 'name', 'make', 'model', 'serial_number',
		                 'min_safe_temp', 'max_safe_temp', 'check_frequency_minutes', 'notes' ];
		$headers     = [ 'Category', 'Equipment', 'Make', 'Model', 'Serial No.',
		                 'Min Temp', 'Max Temp', 'Check (min)', 'Notes' ];

		$html  = $addBtn;
		$html .= '<table class="wikitable sortable fcp-data-table">';
		$html .= '<tr>';
		foreach ( $headers as $h ) {
			$html .= '<th>' . htmlspecialchars( $h ) . '</th>';
		}
		if ( $canManage ) {
			$html .= '<th>Actions</th>';
		}
		$html .= '</tr>';

		foreach ( $rows as $row ) {
			$html .= '<tr>';
			foreach ( $displayCols as $col ) {
				$val  = $row[$col] ?? '';
				$html .= '<td>' . htmlspecialchars( (string)$val ) . '</td>';
			}
			if ( $canManage ) {
				$id      = htmlspecialchars( $row['id'] ?? '' );
				$editUrl = htmlspecialchars(
					\Title::newFromText( 'Special:FcpEquipment' )->getLocalURL(
						[ 'action' => 'edit', 'id' => $row['id'] ]
					)
				);
				$delUrl  = htmlspecialchars(
					\Title::newFromText( 'Special:FcpEquipment' )->getLocalURL(
						[ 'action' => 'delete', 'id' => $row['id'] ]
					)
				);
				$html .= "<td style=\"white-space:nowrap;\">"
				       . "<a href=\"{$editUrl}\" style=\"color:#0070c0;\">Edit</a>"
				       . " &nbsp; "
				       . "<a href=\"{$delUrl}\" style=\"color:#dc3545;\">Delete</a>"
				       . "</td>";
			}
			$html .= '</tr>';
		}

		$html .= '</table>';
		return $html;
	}

	// =========================================================
	// INCIDENT & RESPONSE/RESOLUTION FORM
	// =========================================================

	/**
	 * {{#fcp_incident_form: location_id=<uuid>}}
	 *
	 * Two-section form:
	 *   1. File an Incident — POST to incidents
	 *   2. Open Incidents — Resolution Required — one resolution form per open incident,
	 *      each posting to incidents/{id}/action
	 *
	 * Parser cache disabled — CSRF token is user/session-specific.
	 */
	public static function fcpIncidentForm( \Parser $parser, ...$rawArgs ): array {
		$args = [];
		foreach ( $rawArgs as $arg ) {
			if ( str_contains( $arg, '=' ) ) {
				[ $k, $v ] = explode( '=', $arg, 2 );
				$args[ trim( $k ) ] = trim( $v );
			}
		}

		$locationId = trim( $args['location_id'] ?? '' );
		$redirectTo = trim( $args['redirect'] ?? 'FCP_MAIN:Incident_Response_Report' );

		if ( !$locationId ) {
			return [
				'<span class="error">fcp_incident_form: location_id is required</span>',
				'noparse' => true, 'isHTML' => true,
			];
		}

		$user   = $parser->getUserIdentity();
		$mwUser = \MediaWiki\MediaWikiServices::getInstance()
			->getUserFactory()
			->newFromUserIdentity( $user );

		// Disable parser cache — CSRF token is user/session-specific
		$parser->getOutput()->updateCacheExpiry( 0 );

		$token    = htmlspecialchars( $mwUser->getEditToken() );
		$locId    = htmlspecialchars( $locationId );
		$redir    = htmlspecialchars( $redirectTo );
		$username = htmlspecialchars( $mwUser->getName() );

		// ── Section 1: File an Incident ──────────────────────────────
		$html = <<<HTML
<div style="background:#fff8f0;border:1px solid #ffc107;border-radius:4px;padding:16px;max-width:600px;margin-bottom:2em;">
<h3 style="margin-top:0;">File an Incident Report</h3>
<form method="POST" action="/mediawiki/index.php/Special:FcpSubmit">
<input type="hidden" name="wpEditToken"  value="{$token}">
<input type="hidden" name="fcp_action"   value="incidents">
<input type="hidden" name="fcp_redirect" value="{$redir}">
<input type="hidden" name="location_id"  value="{$locId}">
<table style="width:100%;border-collapse:collapse;">
<tr>
<th style="text-align:left;padding:6px 8px;width:200px;">Incident type</th>
<td style="padding:6px;">
<select name="incident_type" style="width:100%;padding:6px;" required>
<option value="temperature_breach">Temperature breach</option>
<option value="cooling_failure">Cooling failure</option>
<option value="equipment_failure">Equipment failure</option>
<option value="maintenance_issue">Maintenance issue</option>
<option value="delivery_rejection">Delivery rejection</option>
<option value="contamination">Contamination</option>
<option value="pest">Pest activity</option>
<option value="accident">Accident / injury</option>
<option value="other">Other</option>
</select>
</td>
</tr>
<tr>
<th style="text-align:left;padding:6px 8px;">Severity</th>
<td style="padding:6px;">
<select name="severity" style="width:100%;padding:6px;" required>
<option value="low">Low — minor issue, no immediate risk</option>
<option value="medium" selected>Medium — potential risk, action required</option>
<option value="high">High — serious risk, urgent action required</option>
<option value="critical">Critical — immediate food safety threat</option>
</select>
</td>
</tr>
<tr>
<th style="text-align:left;padding:6px 8px;">Description</th>
<td style="padding:6px;"><textarea name="description" rows="4" style="width:100%;padding:6px;" required placeholder="Describe what happened, when, and where"></textarea></td>
</tr>
</table>
<div style="margin-top:12px;padding:8px 10px;background:#f8d7da;border:1px solid #f5c6cb;border-radius:4px;font-size:0.9em;">
Submitting as: <strong>{$username}</strong> &mdash; your name will be recorded on this report.
</div>
<div style="margin-top:10px;">
<input type="submit" value="File Incident Report" style="background:#dc3545;color:white;border:none;padding:8px 20px;border-radius:4px;cursor:pointer;font-size:1em;">
</div>
</form>
</div>
HTML;

		// ── Section 2: Open Incidents — Resolution Required ───────────
		try {
			$client    = new FcpApiClient();
			$incidents = $client->get( 'incidents/open', [ 'location_id' => $locationId ], $mwUser );
		} catch ( \RuntimeException $e ) {
			$html .= '<span class="error">Could not load open incidents: '
				. htmlspecialchars( $e->getMessage() ) . '</span>';
			return [ $html, 'noparse' => true, 'isHTML' => true ];
		}

		if ( empty( $incidents ) ) {
			$html .= '<p style="color:#28a745;font-weight:bold;">&#10003; No open incidents — all incidents have resolutions on file.</p>';
			return [ $html, 'noparse' => true, 'isHTML' => true ];
		}

		$count = count( $incidents );
		$html .= "<h3 style=\"color:#dc3545;\">&#9888; Open Incidents — Resolution Required ({$count})</h3>";
		$html .= "<p style=\"color:#555;\">Each incident requires at least one Resolution report. Add follow-up resolutions as needed until the matter is closed.</p>";

		$severityColors = [
			'low'      => '#28a745',
			'medium'   => '#fd7e14',
			'high'     => '#dc3545',
			'critical' => '#6f1020',
		];
		$typeLabels = [
			'temperature_breach' => 'Temperature breach',
			'cooling_failure'    => 'Cooling failure',
			'equipment_failure'  => 'Equipment failure',
			'maintenance_issue'  => 'Maintenance issue',
			'delivery_rejection' => 'Delivery rejection',
			'contamination'      => 'Contamination',
			'pest'               => 'Pest activity',
			'accident'           => 'Accident / injury',
			'other'              => 'Other',
		];

		foreach ( $incidents as $inc ) {
			$incId      = htmlspecialchars( (string)( $inc['id'] ?? '' ) );
			$type       = htmlspecialchars( $typeLabels[ $inc['incident_type'] ] ?? $inc['incident_type'] );
			$severity   = $inc['severity'] ?? 'medium';
			$sevColor   = $severityColors[ $severity ] ?? '#fd7e14';
			$sevLabel   = htmlspecialchars( ucfirst( $severity ) );
			$desc       = htmlspecialchars( $inc['description'] ?? '' );
			$reportedAt = htmlspecialchars( substr( $inc['reported_at'] ?? '', 0, 16 ) );
			$actionEndpoint = htmlspecialchars( "incidents/{$inc['id']}/action" );

			$html .= <<<HTML
<div style="border:2px solid {$sevColor};border-radius:4px;padding:14px;margin-bottom:1.5em;max-width:680px;">
<div style="margin-bottom:10px;overflow:hidden;">
  <span style="background:{$sevColor};color:white;padding:2px 10px;border-radius:3px;font-weight:bold;font-size:0.9em;">{$sevLabel}</span>
  <strong style="margin-left:8px;">{$type}</strong>
  <span style="float:right;color:#666;font-size:0.85em;">{$reportedAt}</span>
</div>
<p style="margin:0 0 12px;font-style:italic;">&ldquo;{$desc}&rdquo;</p>
HTML;

			// ── Existing resolutions ──────────────────────────────────
			$actions = $inc['actions'] ?? [];
			if ( !empty( $actions ) ) {
				$html .= '<div style="margin-bottom:12px;">';
				$html .= '<strong style="font-size:0.95em;">Filed Resolutions:</strong>';
				foreach ( $actions as $idx => $act ) {
					$actId      = htmlspecialchars( (string)( $act['id'] ?? '' ) );
					$actTaken   = htmlspecialchars( $act['action_taken'] ?? '' );
					$actAt      = htmlspecialchars( substr( $act['actioned_at'] ?? '', 0, 16 ) );
					$actOutcome = $act['outcome'] ? htmlspecialchars( $act['outcome'] ) : '—';
					$actFollowUp = !empty( $act['follow_up_required'] ) ? 'Yes' : 'No';
					$actFollowUpNotes = $act['follow_up_notes'] ? htmlspecialchars( $act['follow_up_notes'] ) : '';
					$num = $idx + 1;
					$followUpBadge = !empty( $act['follow_up_required'] )
						? '<span style="background:#fd7e14;color:white;padding:1px 7px;border-radius:3px;font-size:0.8em;margin-left:6px;">Follow-up required</span>'
						: '';

					$html .= <<<HTML
<div style="background:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;padding:10px;margin-top:8px;">
  <div style="font-size:0.85em;color:#555;margin-bottom:4px;">Resolution #{$num} &mdash; {$actAt}{$followUpBadge}</div>
  <div><strong>Action taken:</strong> {$actTaken}</div>
  <div><strong>Outcome:</strong> {$actOutcome}</div>
HTML;
					if ( $actFollowUpNotes ) {
						$html .= "<div><strong>Follow-up notes:</strong> {$actFollowUpNotes}</div>";
					}

					// Follow-up form for resolutions that require further action
					if ( !empty( $act['follow_up_required'] ) && empty( $act['closed_at'] ) ) {
						$html .= <<<HTML
  <div style="background:#fff3cd;border:1px solid #ffc107;border-radius:4px;padding:10px;margin-top:10px;">
  <strong style="color:#856404;">&#8627; File Follow-up Resolution (references Resolution #{$num}):</strong>
  <form method="POST" action="/mediawiki/index.php/Special:FcpSubmit" style="margin-top:8px;">
  <input type="hidden" name="wpEditToken"     value="{$token}">
  <input type="hidden" name="fcp_action"      value="{$actionEndpoint}">
  <input type="hidden" name="fcp_redirect"    value="{$redir}">
  <input type="hidden" name="parent_action_id" value="{$actId}">
  <table style="width:100%;border-collapse:collapse;">
  <tr>
  <th style="text-align:left;padding:4px 8px;width:180px;">Action taken <span style="color:#dc3545;">*</span></th>
  <td style="padding:4px;"><textarea name="action_taken" rows="2" style="width:100%;padding:6px;" required placeholder="Describe the follow-up action taken"></textarea></td>
  </tr>
  <tr>
  <th style="text-align:left;padding:4px 8px;">Outcome</th>
  <td style="padding:4px;"><input type="text" name="outcome" style="width:100%;padding:6px;" placeholder="Result / outcome (optional)"></td>
  </tr>
  <tr>
  <th style="text-align:left;padding:4px 8px;">Further follow-up?</th>
  <td style="padding:4px;"><label><input type="checkbox" name="follow_up_required" value="true"> Yes — another follow-up needed</label></td>
  </tr>
  <tr>
  <th style="text-align:left;padding:4px 8px;">Follow-up notes</th>
  <td style="padding:4px;"><input type="text" name="follow_up_notes" style="width:100%;padding:6px;" placeholder="Optional"></td>
  </tr>
  </table>
  <div style="margin-top:8px;padding:6px 10px;background:#fff3cd;border:1px solid #ffc107;border-radius:4px;font-size:0.85em;">
  Submitting as: <strong>{$username}</strong>
  </div>
  <div style="margin-top:8px;">
  <input type="submit" value="File Follow-up Resolution" style="background:#856404;color:white;border:none;padding:6px 16px;border-radius:4px;cursor:pointer;font-size:0.9em;">
  </div>
  </form>
  </div>
HTML;
					}

					$html .= '</div>'; // end resolution card
				}
				$html .= '</div>'; // end existing resolutions section
			}

			// ── Add new resolution form (references the incident directly) ────
			$html .= <<<HTML
<div style="background:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;padding:12px;">
<strong style="color:#dc3545;">&#128221; Add Resolution (references this incident):</strong>
<form method="POST" action="/mediawiki/index.php/Special:FcpSubmit" style="margin-top:10px;">
<input type="hidden" name="wpEditToken"  value="{$token}">
<input type="hidden" name="fcp_action"   value="{$actionEndpoint}">
<input type="hidden" name="fcp_redirect" value="{$redir}">
<table style="width:100%;border-collapse:collapse;">
<tr>
<th style="text-align:left;padding:4px 8px;width:180px;">Action taken <span style="color:#dc3545;">*</span></th>
<td style="padding:4px;"><textarea name="action_taken" rows="3" style="width:100%;padding:6px;" required placeholder="Describe the corrective action taken"></textarea></td>
</tr>
<tr>
<th style="text-align:left;padding:4px 8px;">Outcome</th>
<td style="padding:4px;"><input type="text" name="outcome" style="width:100%;padding:6px;" placeholder="Result / outcome (optional)"></td>
</tr>
<tr>
<th style="text-align:left;padding:4px 8px;">Follow-up required?</th>
<td style="padding:4px;"><label><input type="checkbox" name="follow_up_required" value="true"> Yes — further action needed</label></td>
</tr>
<tr>
<th style="text-align:left;padding:4px 8px;">Follow-up notes</th>
<td style="padding:4px;"><input type="text" name="follow_up_notes" style="width:100%;padding:6px;" placeholder="Optional — describe follow-up steps"></td>
</tr>
</table>
<div style="margin-top:10px;padding:6px 10px;background:#d1ecf1;border:1px solid #bee5eb;border-radius:4px;font-size:0.85em;">
Submitting as: <strong>{$username}</strong>
</div>
<div style="margin-top:10px;">
<input type="submit" value="File Resolution" style="background:#0070c0;color:white;border:none;padding:7px 18px;border-radius:4px;cursor:pointer;font-size:0.95em;">
</div>
</form>
</div>
</div>
HTML;
		}

		return [ $html, 'noparse' => true, 'isHTML' => true ];
	}

	private static function renderTable( array $rows ): string {
		if ( empty( $rows ) ) {
			return '<p><em>No records found.</em></p>';
		}

		$headers = array_keys( $rows[0] );
		$html    = '<table class="wikitable sortable fcp-data-table">';

		// Header row
		$html .= '<tr>';
		foreach ( $headers as $h ) {
			$html .= '<th>' . htmlspecialchars( self::formatHeader( $h ) ) . '</th>';
		}
		$html .= '</tr>';

		// Data rows
		foreach ( $rows as $row ) {
			$html .= '<tr>';
			foreach ( $row as $value ) {
				$html .= '<td>' . htmlspecialchars( self::formatValue( $value ) ) . '</td>';
			}
			$html .= '</tr>';
		}

		$html .= '</table>';
		return $html;
	}

	private static function renderGallery( array $items ): string {
		$base = '/mediawiki/index.php/Special:FcpFile';
		$html = '<div class="fcp-media-gallery" style="display:flex;flex-wrap:wrap;gap:16px;margin:1em 0;">';

		foreach ( $items as $item ) {
			$id    = htmlspecialchars( $item['id'] ?? '' );
			$title = htmlspecialchars( $item['title'] ?? '' );
			$mime  = $item['mime_type'] ?? '';
			$file  = "{$base}?id={$id}";
			$thumb = $item['has_thumbnail'] ? "{$base}?id={$id}&thumb=1" : $file;

			$html .= '<div class="fcp-media-item" style="text-align:center;max-width:420px;">';

			if ( str_starts_with( $mime, 'image/' ) ) {
				$html .= "<a href=\"{$file}\" target=\"_blank\">"
					. "<img src=\"{$file}\" alt=\"{$title}\" "
					. "style=\"max-width:400px;max-height:300px;border:1px solid #ccc;\">"
					. "</a>";
			} elseif ( str_starts_with( $mime, 'video/' ) ) {
				$html .= "<a href=\"{$file}\" target=\"_blank\">"
					. "<img src=\"{$thumb}\" alt=\"{$title}\" "
					. "style=\"max-width:400px;max-height:300px;border:1px solid #ccc;\">"
					. "<br><small>&#9654; Video</small>"
					. "</a>";
			} elseif ( str_starts_with( $mime, 'audio/' ) ) {
				$html .= "<a href=\"{$file}\" target=\"_blank\">"
					. "<img src=\"{$thumb}\" alt=\"{$title}\" "
					. "style=\"max-width:400px;max-height:300px;border:1px solid #ccc;\">"
					. "<br><small>&#9834; Audio</small>"
					. "</a>";
			} else {
				$html .= "<a href=\"{$file}\" target=\"_blank\">&#128196; {$title}</a>";
			}

			$html .= "<p style=\"margin:4px 0 0;font-size:0.9em;\">{$title}</p>";
			$html .= '</div>';
		}

		$html .= '</div>';
		return $html;
	}

	private static function renderSummary( array $data ): string {
		$html = '<table class="wikitable fcp-summary-table">';
		foreach ( $data as $key => $value ) {
			$html .= '<tr>'
				. '<th>' . htmlspecialchars( self::formatHeader( $key ) ) . '</th>'
				. '<td>' . htmlspecialchars( self::formatValue( $value ) ) . '</td>'
				. '</tr>';
		}
		$html .= '</table>';
		return $html;
	}

	/**
	 * Convert snake_case keys to Title Case for display.
	 */
	private static function formatHeader( string $key ): string {
		return ucwords( str_replace( '_', ' ', $key ) );
	}

	/**
	 * Format values for display — booleans, nulls, arrays.
	 */
	private static function formatValue( mixed $value ): string {
		if ( $value === null )  return '—';
		if ( $value === true )  return 'Yes';
		if ( $value === false ) return 'No';
		if ( is_array( $value ) ) return implode( ', ', $value );
		return (string) $value;
	}
}
