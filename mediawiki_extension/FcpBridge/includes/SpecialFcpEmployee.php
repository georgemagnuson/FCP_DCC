<?php
/**
 * Special:FcpEmployee — Employee profile page.
 *
 * URL: Special:FcpEmployee?employee=Carlos_Chef
 *      Special:FcpEmployee?employee=<mediawiki_username>
 *
 * Fetches employee data live from the FCP API and renders the profile.
 * Links to Special:FcpEmployeeTraining for the training record.
 */
class SpecialFcpEmployee extends SpecialPage {

	public function __construct() {
		parent::__construct( 'FcpEmployee' );
	}

	public function execute( $subpage ): void {
		$request = $this->getRequest();
		$out     = $this->getOutput();
		$user    = $this->getUser();

		$employeeParam = trim( $request->getVal( 'employee', $subpage ?? '' ) );

		if ( !$employeeParam ) {
			$out->setPageTitle( 'Employee Profile' );
			$out->addHTML( '<p>No employee specified. Return to '
				. '<a href="' . htmlspecialchars( \Title::newFromText( 'Employee_Directory' )->getLocalURL() ) . '">Employee Directory</a>.</p>' );
			return;
		}

		try {
			$client   = new FcpApiClient();
			$usernameForUrl = str_replace( ' ', '_', $employeeParam );
			$data     = $client->get( 'employees/by-username/' . $usernameForUrl, [], $user );
		} catch ( \RuntimeException $e ) {
			$out->setPageTitle( 'Employee Profile' );
			$out->addHTML( '<span class="error">FCP error: ' . htmlspecialchars( $e->getMessage() ) . '</span>' );
			return;
		}

		$name = htmlspecialchars( $data['full_name'] ?? $employeeParam );
		$out->setPageTitle( $name );
		$out->addHTML( $this->renderCard( $data, $employeeParam ) );
	}

	private function renderCard( array $e, string $employeeParam ): string {
		$name     = htmlspecialchars( $e['full_name']                ?? '—' );
		$role     = htmlspecialchars( $e['role']                     ?? '—' );
		$username = htmlspecialchars( $e['mediawiki_username']       ?? '—' );
		$cert     = htmlspecialchars( $e['food_handler_cert_number'] ?? '—' );
		$expiry   = htmlspecialchars( $e['cert_expiry']              ?? '—' );
		$active   = ( $e['is_active'] ?? true ) ? 'Active' : 'Inactive';

		$trainingUrl = htmlspecialchars(
			\SpecialPage::getTitleFor( 'FcpEmployeeTraining' )->getLocalURL()
			. '?employee=' . urlencode( $employeeParam )
		);
		$directoryUrl = htmlspecialchars( \Title::newFromText( 'Employee_Directory' )->getLocalURL() );

		return <<<HTML
<p><a href="{$directoryUrl}">&larr; Employee Directory</a></p>

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
<div style="margin:10px 0;">
<strong><a href="{$trainingUrl}">&#128203; View Training Record</a></strong>
</div>
HTML;
	}

	protected function getGroupName(): string {
		return 'other';
	}
}
