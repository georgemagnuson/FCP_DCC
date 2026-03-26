<?php
/**
 * SpecialFcpSubmit — receives form POSTs from MediaWiki Page Forms
 * and forwards them to the FCP CRUD API.
 *
 * Form usage:
 *   Any wiki form sets action=Special:FcpSubmit and includes hidden fields:
 *     fcp_action   — API endpoint to call  (e.g. "temperature/reading")
 *     fcp_redirect — wiki page to return to on success (e.g. "FCP:Temperature_Log")
 *
 * The remaining form fields are collected and sent as JSON to the API.
 *
 * On success: redirects to fcp_redirect with ?fcp_success=1
 * On failure: redirects to fcp_redirect with ?fcp_error=<message>
 */
class SpecialFcpSubmit extends \SpecialPage {

	// Fields consumed by the bridge itself — not forwarded to the API
	private const BRIDGE_FIELDS = [ 'fcp_action', 'fcp_redirect', 'wpEditToken' ];

	// Whitelist of allowed API endpoints — prevents abuse
	private const ALLOWED_ENDPOINTS = [
		// Temperature & cooling
		'temperature/reading',
		'cooling/start',
		// Incidents & operations
		'incidents',
		'operations/cleaning',
		'operations/maintenance',
		'operations/delivery',
		// Diary — daily
		'diary/opening-check',
		'diary/closing-check',
		'diary/cooking-verification',
		// Diary — weekly / periodic
		'diary/weekly-check',
		'diary/four-week-review',
		'diary/thermometer-calibration',
	];

	// Dynamic endpoint patterns — endpoints that contain a UUID segment
	private const DYNAMIC_ENDPOINT_PATTERNS = [
		'/^cooling\/[0-9a-f-]{36}\/reading$/',
		'/^incidents\/[0-9a-f-]{36}\/action$/',
		'/^operations\/cleaning\/[0-9a-f-]{36}\/verify$/',
	];

	public function __construct() {
		parent::__construct( 'FcpSubmit', 'read' );
	}

	public function execute( $subPage ): void {
		$this->setHeaders();
		$request = $this->getRequest();
		$user    = $this->getUser();

		// Must be a POST
		if ( !$request->wasPosted() ) {
			$this->getOutput()->addWikiMsg( 'fcpbridge-post-only' );
			return;
		}

		// Must be logged in
		if ( !$user->isRegistered() ) {
			$this->getOutput()->addWikiMsg( 'fcpbridge-login-required' );
			return;
		}

		// CSRF check
		if ( !$user->matchEditToken( $request->getVal( 'wpEditToken' ) ) ) {
			$this->getOutput()->addWikiMsg( 'fcpbridge-csrf-error' );
			return;
		}

		$endpoint = $request->getVal( 'fcp_action', '' );
		$redirect = $request->getVal( 'fcp_redirect', '' );

		// Validate endpoint against whitelist (static + dynamic patterns)
		if ( !$this->isValidEndpoint( $endpoint ) ) {
			$this->redirectWithError( $redirect, 'Invalid FCP action: ' . htmlspecialchars( $endpoint ) );
			return;
		}

		// Collect form data — everything except bridge control fields
		$data = [];
		foreach ( $request->getValues() as $key => $value ) {
			if ( !in_array( $key, self::BRIDGE_FIELDS, true ) && $value !== '' ) {
				$data[$key] = $value;
			}
		}

		try {
			$client   = new FcpApiClient();
			$response = $client->post( $endpoint, $data, $user );
		} catch ( \RuntimeException $e ) {
			$this->redirectWithError( $redirect, $e->getMessage() );
			return;
		}

		// Check if API suggests filing an incident report
		$incidentSuggested = !empty( $response['incident_suggested'] );

		$this->redirectWithSuccess( $redirect, $incidentSuggested );
	}

	private function isValidEndpoint( string $endpoint ): bool {
		if ( in_array( $endpoint, self::ALLOWED_ENDPOINTS, true ) ) {
			return true;
		}
		foreach ( self::DYNAMIC_ENDPOINT_PATTERNS as $pattern ) {
			if ( preg_match( $pattern, $endpoint ) ) {
				return true;
			}
		}
		return false;
	}

	private function redirectWithSuccess( string $redirect, bool $incidentSuggested ): void {
		$params = [ 'fcp_success' => '1' ];
		if ( $incidentSuggested ) {
			$params['fcp_incident_suggested'] = '1';
		}
		$this->getOutput()->redirect(
			\Title::newFromText( $redirect )->getFullURL( $params )
		);
	}

	private function redirectWithError( string $redirect, string $message ): void {
		if ( $redirect ) {
			$this->getOutput()->redirect(
				\Title::newFromText( $redirect )->getFullURL( [
					'fcp_error' => urlencode( $message )
				] )
			);
		} else {
			$this->getOutput()->addHTML(
				'<div class="error">' . htmlspecialchars( $message ) . '</div>'
			);
		}
	}

	protected function getGroupName(): string {
		return 'other';
	}
}
