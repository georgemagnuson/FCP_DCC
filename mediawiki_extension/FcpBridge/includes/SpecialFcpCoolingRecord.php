<?php
/**
 * Special:FcpCoolingRecord — multi-step food cooling process tracker.
 *
 * Implements NZ FCP cooling requirements (S39-00006):
 *   Stage 1: 60°C → ≤21°C within 2 hours
 *   Stage 2: 21°C → ≤5°C within 4 hours
 *
 * URL actions:
 *   ?action=start                — form to open a new cooling event
 *   ?action=view&event={uuid}    — view event details and all readings
 *   ?action=reading&event={uuid} — form to add a temperature reading
 *
 * GET renders a form or view; POST processes and redirects.
 */
class SpecialFcpCoolingRecord extends \SpecialPage {

	// Hardcoded for The Jitsu — single-location deployment
	private const LOCATION_ID = 'b1000000-0000-0000-0000-000000000001';

	private const COOLING_METHODS = [
		'ice_bath'           => 'Ice bath',
		'blast_chiller'      => 'Blast chiller',
		'shallow_containers' => 'Shallow containers',
		'cooling_racks'      => 'Cooling racks',
		'smaller_portions'   => 'Smaller portions',
	];

	public function __construct() {
		parent::__construct( 'FcpCoolingRecord', 'read' );
	}

	public function execute( $subpage ): void {
		$this->setHeaders();
		$out     = $this->getOutput();
		$request = $this->getRequest();
		$user    = $this->getUser();

		if ( !$user->isRegistered() ) {
			$out->addHTML( '<p class="error">You must be logged in to record cooling events.</p>' );
			return;
		}

		$action  = $request->getVal( 'action', 'start' );
		$eventId = trim( $request->getVal( 'event', '' ) );

		switch ( $action ) {
			case 'reading':
				if ( !$eventId ) {
					$out->addHTML( '<p class="error">Missing event ID.</p>' );
					return;
				}
				if ( $request->wasPosted() ) {
					$this->handleReading( $out, $request, $user, $eventId );
				} else {
					$this->renderReadingForm( $out, $user, $eventId );
				}
				break;

			case 'view':
				if ( !$eventId ) {
					$out->addHTML( '<p class="error">Missing event ID.</p>' );
					return;
				}
				$this->renderView( $out, $user, $eventId );
				break;

			case 'start':
			default:
				if ( $request->wasPosted() ) {
					$this->handleStart( $out, $request, $user );
				} else {
					$this->renderStartForm( $out, $user );
				}
		}
	}

	// =========================================================
	// START — open a new cooling event
	// =========================================================

	private function renderStartForm( $out, $user ): void {
		$out->setPageTitle( 'Start Food Cooling Record' );
		$token     = $user->getEditToken();
		$actionUrl = htmlspecialchars( $this->getPageTitle()->getLocalURL( [ 'action' => 'start' ] ) );
		$now       = date( 'Y-m-d\TH:i' );

		$methodCheckboxes = '';
		foreach ( self::COOLING_METHODS as $value => $label ) {
			$methodCheckboxes .= '<label style="display:block;margin:4px 0;">'
				. '<input type="checkbox" name="cooling_methods[]" value="' . htmlspecialchars( $value ) . '"> '
				. htmlspecialchars( $label )
				. '</label>';
		}

		$viewAllUrl = htmlspecialchars(
			\Title::newFromText( 'FCP_MAIN:Cooling_Records' )->getLocalURL()
		);

		$out->addHTML( <<<HTML
<p><a href="{$viewAllUrl}">&larr; All Cooling Records</a></p>

<div style="background:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;padding:20px;max-width:540px;">
<form method="post" action="{$actionUrl}">
<input type="hidden" name="wpEditToken" value="{$token}">

<table class="wikitable" style="width:100%;">
<tr>
  <th style="width:200px;color:#000;">Food item <span style="color:red">*</span></th>
  <td><input type="text" name="food_description" required style="width:100%;padding:6px;"
      placeholder="e.g. Chicken stock, Beef curry"></td>
</tr>
<tr>
  <th style="color:#000;">Cooking finished at <span style="color:red">*</span></th>
  <td><input type="datetime-local" name="cooked_at" value="{$now}" required style="width:100%;padding:6px;"></td>
</tr>
<tr>
  <th style="color:#000;">Quantity (kg)</th>
  <td><input type="number" name="quantity_kg" step="0.1" min="0" style="width:120px;padding:6px;"
      placeholder="Optional"></td>
</tr>
<tr>
  <th style="color:#000;">Batch reference</th>
  <td><input type="text" name="batch_reference" style="width:100%;padding:6px;"
      placeholder="Optional batch/lot number"></td>
</tr>
<tr>
  <th style="color:#000;vertical-align:top;padding-top:10px;">Cooling method(s)</th>
  <td style="padding:8px;">{$methodCheckboxes}</td>
</tr>
<tr>
  <th style="color:#000;">Notes</th>
  <td><textarea name="notes" rows="2" style="width:100%;padding:6px;"
      placeholder="Optional"></textarea></td>
</tr>
</table>

<p style="margin-top:12px;">
  <input type="submit" value="Start Cooling Record"
         style="background:#0070c0;color:white;border:none;padding:8px 20px;border-radius:4px;cursor:pointer;font-size:1em;">
</p>
</form>
</div>
HTML );
	}

	private function handleStart( $out, $request, $user ): void {
		if ( !$user->matchEditToken( $request->getVal( 'wpEditToken' ) ) ) {
			$out->addHTML( '<p class="error">Security token mismatch. Please try again.</p>' );
			$this->renderStartForm( $out, $user );
			return;
		}

		$foodDescription = trim( $request->getVal( 'food_description', '' ) );
		$cookedAt        = trim( $request->getVal( 'cooked_at', '' ) );
		if ( !$foodDescription || !$cookedAt ) {
			$out->addHTML( '<p class="error">Food item and cooking time are required.</p>' );
			$this->renderStartForm( $out, $user );
			return;
		}

		// datetime-local sends "2026-03-26T14:30" — append seconds for API
		if ( strlen( $cookedAt ) === 16 ) {
			$cookedAt .= ':00';
		}

		$data = [
			'location_id'      => self::LOCATION_ID,
			'food_description' => $foodDescription,
			'cooked_at'        => $cookedAt,
		];

		$quantityKg     = $request->getVal( 'quantity_kg', '' );
		$batchReference = trim( $request->getVal( 'batch_reference', '' ) );
		$notes          = trim( $request->getVal( 'notes', '' ) );
		$coolingMethods = $request->getArray( 'cooling_methods', [] );

		if ( $quantityKg !== '' ) {
			$data['quantity_kg'] = (float) $quantityKg;
		}
		if ( $batchReference !== '' ) {
			$data['batch_reference'] = $batchReference;
		}
		if ( $notes !== '' ) {
			$data['notes'] = $notes;
		}
		if ( !empty( $coolingMethods ) ) {
			$data['cooling_methods'] = $coolingMethods;
		}

		try {
			$client   = new FcpApiClient();
			$response = $client->post( 'cooling/start', $data, $user );
		} catch ( \RuntimeException $e ) {
			$out->addHTML( '<p class="error">Error: ' . htmlspecialchars( $e->getMessage() ) . '</p>' );
			$this->renderStartForm( $out, $user );
			return;
		}

		$eventId = $response['id'] ?? '';
		if ( !$eventId ) {
			$out->addHTML( '<p class="error">Unexpected response from API — no event ID returned.</p>' );
			return;
		}

		$out->redirect( $this->getPageTitle()->getLocalURL( [ 'action' => 'view', 'event' => $eventId ] ) );
	}

	// =========================================================
	// ADD READING
	// =========================================================

	private function renderReadingForm( $out, $user, string $eventId ): void {
		$out->setPageTitle( 'Add Cooling Reading' );

		// Fetch current event for context
		$event = $this->fetchEvent( $out, $user, $eventId );
		if ( $event === null ) {
			return;
		}

		$token     = $user->getEditToken();
		$actionUrl = htmlspecialchars(
			$this->getPageTitle()->getLocalURL( [ 'action' => 'reading', 'event' => $eventId ] )
		);
		$viewUrl   = htmlspecialchars(
			$this->getPageTitle()->getLocalURL( [ 'action' => 'view', 'event' => $eventId ] )
		);
		$foodDesc  = htmlspecialchars( $event['food_description'] ?? '' );
		$now       = date( 'Y-m-d\TH:i' );

		$readingCount = count( $event['readings'] ?? [] );
		$lastTemp     = '';
		if ( $readingCount > 0 ) {
			$last     = end( $event['readings'] );
			$lastTemp = htmlspecialchars( $last['temp_celsius'] . '°C at ' . substr( $last['recorded_at'], 0, 16 ) );
		}
		$lastRow = $lastTemp
			? "<tr><th style=\"color:#000;\">Last reading</th><td>{$lastTemp}</td></tr>"
			: '';

		$out->addHTML( <<<HTML
<p><a href="{$viewUrl}">&larr; Back to event</a></p>

<table class="wikitable" style="width:auto;margin-bottom:1em;">
<tr><th style="color:#000;">Food item</th><td>{$foodDesc}</td></tr>
<tr><th style="color:#000;">Readings so far</th><td>{$readingCount}</td></tr>
{$lastRow}
</table>

<div style="background:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;padding:20px;max-width:400px;">
<form method="post" action="{$actionUrl}">
<input type="hidden" name="wpEditToken" value="{$token}">

<table class="wikitable" style="width:100%;">
<tr>
  <th style="width:160px;color:#000;">Temperature (°C) <span style="color:red">*</span></th>
  <td><input type="number" name="temp_celsius" step="0.1" required
      style="width:120px;padding:6px;" autofocus></td>
</tr>
<tr>
  <th style="color:#000;">Recorded at</th>
  <td><input type="datetime-local" name="recorded_at" value="{$now}" style="width:100%;padding:6px;"></td>
</tr>
<tr>
  <th style="color:#000;">Notes</th>
  <td><input type="text" name="notes" style="width:100%;padding:6px;"
      placeholder="e.g. moved to blast chiller"></td>
</tr>
</table>

<p style="margin-top:12px;">
  <input type="submit" value="Add Reading"
         style="background:#28a745;color:white;border:none;padding:8px 20px;border-radius:4px;cursor:pointer;font-size:1em;">
  &nbsp;
  <a href="{$viewUrl}" style="padding:8px 16px;border:1px solid #ccc;border-radius:4px;text-decoration:none;color:#333;">Cancel</a>
</p>
</form>
</div>
HTML );
	}

	private function handleReading( $out, $request, $user, string $eventId ): void {
		if ( !$user->matchEditToken( $request->getVal( 'wpEditToken' ) ) ) {
			$out->addHTML( '<p class="error">Security token mismatch. Please try again.</p>' );
			$this->renderReadingForm( $out, $user, $eventId );
			return;
		}

		$tempCelsius = $request->getVal( 'temp_celsius', '' );
		if ( $tempCelsius === '' ) {
			$out->addHTML( '<p class="error">Temperature is required.</p>' );
			$this->renderReadingForm( $out, $user, $eventId );
			return;
		}

		$data = [ 'temp_celsius' => (float) $tempCelsius ];

		$recordedAt = trim( $request->getVal( 'recorded_at', '' ) );
		if ( $recordedAt !== '' ) {
			if ( strlen( $recordedAt ) === 16 ) {
				$recordedAt .= ':00';
			}
			$data['recorded_at'] = $recordedAt;
		}

		$notes = trim( $request->getVal( 'notes', '' ) );
		if ( $notes !== '' ) {
			$data['notes'] = $notes;
		}

		try {
			$client = new FcpApiClient();
			$client->post( 'cooling/' . rawurlencode( $eventId ) . '/reading', $data, $user );
		} catch ( \RuntimeException $e ) {
			$out->addHTML( '<p class="error">Error: ' . htmlspecialchars( $e->getMessage() ) . '</p>' );
			$this->renderReadingForm( $out, $user, $eventId );
			return;
		}

		$out->redirect( $this->getPageTitle()->getLocalURL( [ 'action' => 'view', 'event' => $eventId ] ) );
	}

	// =========================================================
	// VIEW — event details + readings
	// =========================================================

	private function renderView( $out, $user, string $eventId ): void {
		$event = $this->fetchEvent( $out, $user, $eventId );
		if ( $event === null ) {
			return;
		}

		$foodDesc  = htmlspecialchars( $event['food_description'] ?? '' );
		$out->setPageTitle( 'Cooling Record: ' . $foodDesc );

		$addReadingUrl = htmlspecialchars(
			$this->getPageTitle()->getLocalURL( [ 'action' => 'reading', 'event' => $eventId ] )
		);
		$startNewUrl   = htmlspecialchars(
			$this->getPageTitle()->getLocalURL( [ 'action' => 'start' ] )
		);
		$listUrl       = htmlspecialchars(
			\Title::newFromText( 'FCP_MAIN:Cooling_Records' )->getLocalURL()
		);

		// ---- Event summary table ----
		$cookedAt   = htmlspecialchars( substr( $event['cooked_at'] ?? '', 0, 16 ) );
		$closedAt   = $event['closed_at'] ? htmlspecialchars( substr( $event['closed_at'], 0, 16 ) ) : '—';
		$quantityKg = $event['quantity_kg'] ? htmlspecialchars( $event['quantity_kg'] . ' kg' ) : '—';
		$methods    = implode( ', ', array_map(
			fn( $m ) => htmlspecialchars( self::COOLING_METHODS[$m] ?? $m ),
			$event['cooling_methods'] ?? []
		) ) ?: '—';

		$clockStarted = $event['clock_started_at']
			? htmlspecialchars( substr( $event['clock_started_at'], 0, 16 ) )
			: 'Not yet (no reading ≤ ' . $event['clock_start_temp'] . '°C recorded)';

		// ---- Compliance status ----
		$complianceHtml = $this->renderComplianceStatus( $event );

		// ---- Readings table ----
		$readings    = $event['readings'] ?? [];
		$readingsHtml = $this->renderReadingsTable( $readings );

		$closedBadge = $event['closed_at']
			? '<span style="background:#6c757d;color:white;padding:2px 8px;border-radius:3px;font-size:0.85em;">CLOSED</span>'
			: '<span style="background:#28a745;color:white;padding:2px 8px;border-radius:3px;font-size:0.85em;">ACTIVE</span>';

		$addReadingBtn = $event['closed_at']
			? ''
			: "<a href=\"{$addReadingUrl}\" style=\"background:#0070c0;color:white;padding:8px 16px;"
			. "border-radius:4px;text-decoration:none;display:inline-block;margin-right:8px;\">"
			. "&#43; Add Reading</a>";

		$readingsCount = count( $readings );

		$out->addHTML( <<<HTML
<p>
  <a href="{$listUrl}">&larr; All Cooling Records</a>
  &nbsp;|&nbsp;
  <a href="{$startNewUrl}">Start New Event</a>
</p>

<h2>{$foodDesc} {$closedBadge}</h2>

<table class="wikitable" style="width:auto;margin-bottom:1em;">
<tr><th style="color:#000;">Food item</th><td>{$foodDesc}</td></tr>
<tr><th style="color:#000;">Cooked at</th><td>{$cookedAt}</td></tr>
<tr><th style="color:#000;">Quantity</th><td>{$quantityKg}</td></tr>
<tr><th style="color:#000;">Cooling methods</th><td>{$methods}</td></tr>
<tr><th style="color:#000;">Clock started</th><td>{$clockStarted}</td></tr>
<tr><th style="color:#000;">Closed at</th><td>{$closedAt}</td></tr>
</table>

{$complianceHtml}

<h3>Readings ({$readingsCount})</h3>
{$addReadingBtn}
{$readingsHtml}
HTML );
	}

	private function renderComplianceStatus( array $event ): string {
		$s1Compliant = $event['stage1_compliant'];
		$s2Compliant = $event['stage2_compliant'];
		$overall     = $event['overall_compliant'];
		$closed      = !empty( $event['closed_at'] );

		$s1Target = $event['target_stage1_temp'] . '°C in '
			. ( $event['target_stage1_minutes'] / 60 ) . ' hrs';
		$s2Target = $event['target_stage2_temp'] . '°C in '
			. ( $event['target_stage2_minutes'] / 60 ) . ' hrs';

		$badge = static function( ?bool $v, bool $inProgress ): string {
			if ( $v === true )  {
				return '<span style="background:#28a745;color:white;padding:2px 8px;border-radius:3px;">&#10003; Pass</span>';
			}
			if ( $v === false ) {
				return '<span style="background:#dc3545;color:white;padding:2px 8px;border-radius:3px;">&#10007; FAIL</span>';
			}
			if ( $inProgress )  {
				return '<span style="background:#ffc107;color:#000;padding:2px 8px;border-radius:3px;">In progress</span>';
			}
			return '<span style="color:#999;">Pending</span>';
		};

		$s1InProgress = ( $event['clock_started_at'] && !$event['stage1_completed_at'] );
		$s2InProgress = ( $event['stage1_completed_at'] && !$event['stage2_completed_at'] );

		$s1Badge      = $badge( $s1Compliant !== null ? (bool)$s1Compliant : null, $s1InProgress );
		$s2Badge      = $badge( $s2Compliant !== null ? (bool)$s2Compliant : null, $s2InProgress );
		$overallBadge = '';
		if ( $closed ) {
			$overallBadge = $badge( $overall !== null ? (bool)$overall : null, false );
		}

		$overallRow = $closed
			? "<tr><th style=\"color:#000;\">Overall</th><td>{$overallBadge}</td></tr>"
			: '';

		return <<<HTML
<table class="wikitable" style="width:auto;margin-bottom:1em;background:#f8f9fa;">
<tr><th colspan="2" style="background:#e9ecef;color:#000;">Compliance Status (NZ FCP S39-00006)</th></tr>
<tr>
  <th style="color:#000;">Stage 1 &mdash; 60°C &rarr; ≤{$s1Target}</th>
  <td>{$s1Badge}</td>
</tr>
<tr>
  <th style="color:#000;">Stage 2 &mdash; 21°C &rarr; ≤{$s2Target}</th>
  <td>{$s2Badge}</td>
</tr>
{$overallRow}
</table>
HTML;
	}

	private function renderReadingsTable( array $readings ): string {
		if ( empty( $readings ) ) {
			return '<p><em>No readings recorded yet. '
				. 'Record the first temperature reading to start the compliance clock.</em></p>';
		}

		$stageLabels = [ 0 => 'Pre-clock', 1 => 'Stage 1', 2 => 'Stage 2' ];
		$rows = '';
		foreach ( $readings as $r ) {
			$temp    = htmlspecialchars( $r['temp_celsius'] . '°C' );
			$time    = htmlspecialchars( substr( $r['recorded_at'], 0, 16 ) );
			$elapsed = $r['minutes_elapsed'] !== null
				? htmlspecialchars( $r['minutes_elapsed'] . ' min' )
				: '—';
			$stage   = htmlspecialchars( $stageLabels[ $r['stage'] ?? 0 ] ?? '—' );
			$notes   = htmlspecialchars( $r['notes'] ?? '' );
			$rows   .= "<tr><td>{$time}</td><td>{$temp}</td><td>{$elapsed}</td><td>{$stage}</td><td>{$notes}</td></tr>";
		}

		return <<<HTML
<table class="wikitable sortable" style="width:auto;">
<tr>
  <th style="color:#000;">Time</th>
  <th style="color:#000;">Temp</th>
  <th style="color:#000;">Elapsed</th>
  <th style="color:#000;">Stage</th>
  <th style="color:#000;">Notes</th>
</tr>
{$rows}
</table>
HTML;
	}

	// =========================================================
	// Helpers
	// =========================================================

	/**
	 * Fetch a cooling event from the API. Returns null and writes error on failure.
	 */
	private function fetchEvent( $out, $user, string $eventId ): ?array {
		try {
			$client = new FcpApiClient();
			return $client->get( 'cooling/' . rawurlencode( $eventId ), [], $user );
		} catch ( \RuntimeException $e ) {
			$out->addHTML( '<p class="error">Could not load cooling event: '
				. htmlspecialchars( $e->getMessage() ) . '</p>' );
			return null;
		}
	}

	protected function getGroupName(): string {
		return 'other';
	}
}
