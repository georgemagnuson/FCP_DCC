<?php
/**
 * Special:FcpTrainingAction — Confirmation form for training record actions.
 *
 * URL params (GET):
 *   employee  — mediawiki_username
 *   module    — module_code (e.g. safety_basics)
 *   action    — assign | na | complete | verify
 *   return    — URL to redirect to on success/cancel
 *
 * GET:  renders a confirmation form (date picker; reason field for na)
 * POST: calls POST /training/employee/{employee}/{module}/{action}, then redirects
 */
class SpecialFcpTrainingAction extends SpecialPage {

	private const VALID_ACTIONS = [ 'assign', 'na', 'complete', 'verify' ];

	// Minimum MW group level required per action
	private const ACTION_GROUPS = [
		'assign'   => [ 'training_manager', 'training_supervisor', 'sysop', 'bureaucrat' ],
		'na'       => [ 'training_manager', 'training_supervisor', 'sysop', 'bureaucrat' ],
		'complete' => [ 'training_employee', 'sysop', 'bureaucrat' ],  // self-complete only; sysop override
		'verify'   => [ 'training_supervisor', 'sysop', 'bureaucrat' ],  // NOT training_manager
	];

	private const ACTION_LABELS = [
		'assign'   => 'Assign Module',
		'na'       => 'Mark Not Applicable',
		'complete' => 'Mark Complete',
		'verify'   => 'Verify Completion',
	];

	public function __construct() {
		parent::__construct( 'FcpTrainingAction', 'read' );
	}

	public function execute( $subpage ): void {
		$this->setHeaders();
		$out     = $this->getOutput();
		$request = $this->getRequest();
		$user    = $this->getUser();

		if ( !$user->isRegistered() ) {
			$out->addHTML( '<p class="error">You must be logged in to record training actions.</p>' );
			return;
		}

		$employee  = trim( $request->getVal( 'employee', '' ) );
		$module    = trim( $request->getVal( 'module',   '' ) );
		$action    = trim( $request->getVal( 'action',   '' ) );
		$returnUrl = trim( $request->getVal( 'return',   '' ) );

		if ( !$employee || !$module || !in_array( $action, self::VALID_ACTIONS, true ) ) {
			$out->setPageTitle( 'Training Action' );
			$out->addHTML( '<p class="error">Invalid or missing parameters.</p>' );
			return;
		}

		// Permission check
		$groupManager = \MediaWiki\MediaWikiServices::getInstance()->getUserGroupManager();
		$userGroups   = $groupManager->getUserGroups( $user );
		$allowed      = array_intersect( self::ACTION_GROUPS[$action], $userGroups );

		// Employees completing their own module: special-case — no group needed
		$isSelfComplete = ( $action === 'complete' && str_replace( '_', ' ', $user->getName() ) === str_replace( '_', ' ', $employee ) );

		if ( !$allowed && !$isSelfComplete ) {
			$out->setPageTitle( self::ACTION_LABELS[$action] );
			$out->addHTML( '<p class="error">You do not have permission to perform this action.</p>' );
			return;
		}

		if ( $request->wasPosted() ) {
			$this->handlePost( $out, $request, $user, $employee, $module, $action, $returnUrl );
		} else {
			$this->renderForm( $out, $user, $employee, $module, $action, $returnUrl );
		}
	}

	private function handlePost( $out, $request, $user, $employee, $module, $action, $returnUrl ): void {
		if ( !$user->matchEditToken( $request->getVal( 'wpEditToken' ) ) ) {
			$out->setPageTitle( self::ACTION_LABELS[$action] );
			$out->addHTML( '<p class="error">Security token mismatch. Please try again.</p>' );
			$this->renderForm( $out, $user, $employee, $module, $action, $returnUrl );
			return;
		}

		$data = [];
		$dateVal = trim( $request->getVal( 'action_date', '' ) );
		if ( $dateVal ) {
			$data['action_date'] = $dateVal;
		}
		if ( $action === 'na' ) {
			$reason = trim( $request->getVal( 'reason', '' ) );
			if ( !$reason ) {
				$out->setPageTitle( self::ACTION_LABELS[$action] );
				$out->addHTML( '<p class="error">A reason is required when marking a module N/A.</p>' );
				$this->renderForm( $out, $user, $employee, $module, $action, $returnUrl );
				return;
			}
			$data['reason'] = $reason;
		}

		$endpoint = 'training/employee/' . rawurlencode( $employee ) . '/' . rawurlencode( $module ) . '/' . $action;

		try {
			$client = new FcpApiClient();
			$client->post( $endpoint, $data, $user );
		} catch ( \RuntimeException $e ) {
			$out->setPageTitle( self::ACTION_LABELS[$action] );
			$out->addHTML( '<p class="error">Error: ' . htmlspecialchars( $e->getMessage() ) . '</p>' );
			$this->renderForm( $out, $user, $employee, $module, $action, $returnUrl );
			return;
		}

		if ( $returnUrl ) {
			$out->redirect( $returnUrl );
		} else {
			$out->redirect( \Title::newFromText( 'Employee_Directory' )->getLocalURL() );
		}
	}

	private function renderForm( $out, $user, $employee, $module, $action, $returnUrl ): void {
		$label     = self::ACTION_LABELS[$action];
		$out->setPageTitle( $label );

		$token      = $user->getEditToken();
		$actionUrl  = htmlspecialchars( $this->getPageTitle()->getLocalURL() );
		$cancelUrl  = htmlspecialchars( $returnUrl ?: \Title::newFromText( 'Employee_Directory' )->getLocalURL() );
		$moduleName = htmlspecialchars( ucwords( str_replace( '_', ' ', $module ) ) );
		$empName    = htmlspecialchars( str_replace( '_', ' ', $employee ) );
		$today      = date( 'Y-m-d' );

		$hidden = '<input type="hidden" name="wpEditToken" value="' . htmlspecialchars( $token ) . '">'
			. '<input type="hidden" name="employee" value="' . htmlspecialchars( $employee ) . '">'
			. '<input type="hidden" name="module"   value="' . htmlspecialchars( $module ) . '">'
			. '<input type="hidden" name="action"   value="' . htmlspecialchars( $action ) . '">'
			. '<input type="hidden" name="return"   value="' . htmlspecialchars( $returnUrl ) . '">';

		$reasonRow = '';
		if ( $action === 'na' ) {
			$reasonRow = <<<HTML
<tr>
  <th style="color:#000;">Reason <span style="color:red">*</span></th>
  <td><input type="text" name="reason" size="50" required placeholder="Why is this module not applicable?"
       style="width:100%;"></td>
</tr>
HTML;
		}

		$out->addHTML( <<<HTML
<p><a href="{$cancelUrl}">&larr; Back to Training Record</a></p>

<table class="wikitable" style="width:auto;margin-bottom:1em;">
<tr><th style="color:#000;">Employee</th><td>{$empName}</td></tr>
<tr><th style="color:#000;">Module</th><td>{$moduleName}</td></tr>
<tr><th style="color:#000;">Action</th><td><strong>{$label}</strong></td></tr>
</table>

<form method="post" action="{$actionUrl}" style="max-width:480px;">
{$hidden}
<table class="wikitable" style="width:100%;">
<tr>
  <th style="width:35%;color:#000;">Date</th>
  <td><input type="date" name="action_date" value="{$today}" style="width:100%;"></td>
</tr>
{$reasonRow}
</table>
<p style="margin-top:12px;">
  <input type="submit" value="{$label}" class="mw-ui-button mw-ui-progressive">
  &nbsp;
  <a href="{$cancelUrl}" class="mw-ui-button">Cancel</a>
</p>
</form>
HTML );
	}

	protected function getGroupName(): string {
		return 'other';
	}
}
