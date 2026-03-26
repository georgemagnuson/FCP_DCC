<?php
/**
 * Special:FcpNewEmployee — Add a new employee via the FCP API.
 *
 * GET:  renders an HTML form
 * POST: sends data to POST /employees, then redirects to Employee_Directory
 *
 * Requires training_manager or sysop group.
 */
class SpecialFcpNewEmployee extends SpecialPage {

	private const ROLES = [
		'Chef / Kitchen Staff',
		'Waitstaff',
		'Manager / Front-of-House',
		'Owner / Operator',
		'Other',
	];

	public function __construct() {
		parent::__construct( 'FcpNewEmployee', 'read' );
	}

	public function execute( $subpage ): void {
		$this->setHeaders();
		$out     = $this->getOutput();
		$request = $this->getRequest();
		$user    = $this->getUser();

		if ( !$user->isRegistered() ) {
			$out->addHTML( '<p class="error">You must be logged in to add employees.</p>' );
			return;
		}

		// Check manager permission via MW groups
		$groupManager = \MediaWiki\MediaWikiServices::getInstance()->getUserGroupManager();
		$groups = $groupManager->getUserGroups( $user );
		$canAdd = in_array( 'training_manager', $groups, true )
		       || in_array( 'sysop', $groups, true )
		       || in_array( 'bureaucrat', $groups, true );

		if ( !$canAdd ) {
			$out->setPageTitle( 'Add New Employee' );
			$out->addHTML( '<p class="error">Only managers can add new employees.</p>' );
			return;
		}

		if ( $request->wasPosted() ) {
			$this->handlePost( $out, $request, $user );
		} else {
			$this->renderForm( $out, $user );
		}
	}

	private function handlePost( $out, $request, $user ): void {
		// CSRF check
		if ( !$user->matchEditToken( $request->getVal( 'wpEditToken' ) ) ) {
			$out->setPageTitle( 'Add New Employee' );
			$out->addHTML( '<p class="error">Security token mismatch. Please try again.</p>' );
			$this->renderForm( $out, $user );
			return;
		}

		$data = [
			'full_name'               => trim( $request->getVal( 'full_name', '' ) ),
			'role'                    => trim( $request->getVal( 'role', '' ) ),
			'mediawiki_username'      => trim( $request->getVal( 'mediawiki_username', '' ) ) ?: null,
			'food_handler_cert_number' => trim( $request->getVal( 'food_handler_cert_number', '' ) ) ?: null,
			'cert_expiry'             => trim( $request->getVal( 'cert_expiry', '' ) ) ?: null,
		];

		// Remove nulls so JSON omits them
		$data = array_filter( $data, fn( $v ) => $v !== null );

		if ( empty( $data['full_name'] ) || empty( $data['role'] ) ) {
			$out->setPageTitle( 'Add New Employee' );
			$out->addHTML( '<p class="error">Full name and role are required.</p>' );
			$this->renderForm( $out, $user, $data );
			return;
		}

		try {
			$client = new FcpApiClient();
			$result = $client->post( 'employees', $data, $user );
		} catch ( \RuntimeException $e ) {
			$out->setPageTitle( 'Add New Employee' );
			$out->addHTML( '<p class="error">Error: ' . htmlspecialchars( $e->getMessage() ) . '</p>' );
			$this->renderForm( $out, $user, $data );
			return;
		}

		$directoryUrl = \Title::newFromText( 'Employee_Directory' )->getFullURL( [ 'fcp_success' => '1' ] );
		$out->redirect( $directoryUrl );
	}

	private function renderForm( $out, $user, array $prefill = [] ): void {
		$out->setPageTitle( 'Add New Employee' );

		$token       = $user->getEditToken();
		$actionUrl   = htmlspecialchars( $this->getPageTitle()->getLocalURL() );
		$directoryUrl = htmlspecialchars( \Title::newFromText( 'Employee_Directory' )->getLocalURL() );

		$roleOptions = '';
		$prefillRole = $prefill['role'] ?? '';
		foreach ( self::ROLES as $r ) {
			$selected = ( $r === $prefillRole ) ? ' selected' : '';
			$roleOptions .= '<option value="' . htmlspecialchars( $r ) . '"' . $selected . '>'
				. htmlspecialchars( $r ) . '</option>';
		}

		$v = fn( $k ) => htmlspecialchars( $prefill[$k] ?? '' );

		$out->addHTML( <<<HTML
<p><a href="{$directoryUrl}">&larr; Employee Directory</a></p>

<form method="post" action="{$actionUrl}" style="max-width:560px;">
<input type="hidden" name="wpEditToken" value="{$token}">

<table class="wikitable" style="width:100%;">
<tr>
  <th style="width:35%;color:#000;">Full Name <span style="color:red">*</span></th>
  <td><input type="text" name="full_name" value="{$v('full_name')}" size="40" required
       placeholder="e.g. Jane Smith" style="width:100%;"></td>
</tr>
<tr>
  <th style="color:#000;">Role <span style="color:red">*</span></th>
  <td>
    <select name="role" required style="width:100%;">
      <option value="">— select —</option>
      {$roleOptions}
    </select>
  </td>
</tr>
<tr>
  <th style="color:#000;">MediaWiki Username</th>
  <td><input type="text" name="mediawiki_username" value="{$v('mediawiki_username')}" size="30"
       placeholder="e.g. Jane_Smith (no spaces)" style="width:100%;"></td>
</tr>
<tr>
  <th style="color:#000;">Food Handler Cert #</th>
  <td><input type="text" name="food_handler_cert_number" value="{$v('food_handler_cert_number')}" size="30"
       style="width:100%;"></td>
</tr>
<tr>
  <th style="color:#000;">Cert Expiry</th>
  <td><input type="date" name="cert_expiry" value="{$v('cert_expiry')}" style="width:100%;"></td>
</tr>
</table>

<p style="margin-top:12px;">
  <input type="submit" value="Add Employee" class="mw-ui-button mw-ui-progressive">
  &nbsp;
  <a href="{$directoryUrl}" class="mw-ui-button">Cancel</a>
</p>
<p style="color:#666;font-size:0.9em;">
  * Required fields. Training modules are assigned automatically after the employee is created.
</p>
</form>
HTML );
	}

	protected function getGroupName(): string {
		return 'other';
	}
}
