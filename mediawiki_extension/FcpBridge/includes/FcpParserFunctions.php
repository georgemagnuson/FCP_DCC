<?php
/**
 * FcpParserFunctions — display FCP API data in wiki pages.
 *
 * Usage:
 *   {{#fcp_query: endpoint=temperature/today | equipment_id=<uuid> | format=table}}
 *   {{#fcp_query: endpoint=temperature/summary/<uuid> | days=7 | format=summary}}
 *   {{#fcp_query: endpoint=cooling/active | location_id=<uuid> | format=table}}
 *   {{#fcp_query: endpoint=incidents/open | location_id=<uuid> | format=table}}
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
