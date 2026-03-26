<?php
/**
 * Special:FcpEmployeeTraining — Employee training record page.
 *
 * URL: Special:FcpEmployeeTraining?employee=Carlos_Chef
 *
 * Fetches training data live from the FCP API and renders the full
 * training module table with role-appropriate action links.
 */
class SpecialFcpEmployeeTraining extends SpecialPage {

	public function __construct() {
		parent::__construct( 'FcpEmployeeTraining' );
	}

	public function execute( $subpage ): void {
		$request = $this->getRequest();
		$out     = $this->getOutput();
		$user    = $this->getUser();

		$employeeParam  = trim( $request->getVal( 'employee', $subpage ?? '' ) );
		$usernameForUrl = str_replace( ' ', '_', $employeeParam );

		if ( !$employeeParam ) {
			$out->setPageTitle( 'Training Record' );
			$out->addHTML( '<p>No employee specified.</p>' );
			return;
		}

		try {
			$client = new FcpApiClient();
			$data   = $client->get( 'training/employee/' . $usernameForUrl, [], $user );
		} catch ( \RuntimeException $e ) {
			$out->setPageTitle( 'Training Record' );
			$out->addHTML( '<span class="error">FCP error: ' . htmlspecialchars( $e->getMessage() ) . '</span>' );
			return;
		}

		$fullName = htmlspecialchars( $data['full_name'] ?? $employeeParam );
		$out->setPageTitle( 'Training Record — ' . $fullName );

		$profileUrl = htmlspecialchars(
			\SpecialPage::getTitleFor( 'FcpEmployee' )->getLocalURL()
			. '?employee=' . urlencode( $employeeParam )
		);
		$out->addHTML( "<p><a href=\"{$profileUrl}\">&larr; {$fullName}'s Profile</a></p>" );

		// Role-based action permissions — no cascading, each role is independent
		$userGroupManager = \MediaWiki\MediaWikiServices::getInstance()->getUserGroupManager();
		$groups           = $userGroupManager->getUserGroups( $user );
		$isManager    = in_array( 'training_manager',    $groups ) || in_array( 'sysop', $groups ) || in_array( 'bureaucrat', $groups );
		$isSupervisor = in_array( 'training_supervisor', $groups ) || in_array( 'sysop', $groups ) || in_array( 'bureaucrat', $groups );
		// isSelf: viewing employee is the logged-in user
		$isSelf = str_replace( '_', ' ', $user->getName() ) === str_replace( '_', ' ', $employeeParam );

		$modules = $data['modules'] ?? [];
		if ( empty( $modules ) ) {
			$out->addHTML( '<p><em>No training modules found.</em></p>' );
			return;
		}

		// Role instruction banner — show the highest applicable role
		if ( $isSupervisor ) {
			$out->addHTML( '<div style="background:#d4edda;padding:10px 15px;margin:10px 0;border-left:4px solid #28a745;border-radius:0 4px 4px 0;"><em>Supervisor:</em> Use Re-assign, N/A, and Verify links.</div>' );
		} elseif ( $isManager ) {
			$out->addHTML( '<div style="background:#fff3cd;padding:10px 15px;margin:10px 0;border-left:4px solid #ffc107;border-radius:0 4px 4px 0;"><em>Manager:</em> Use Assign and N/A links to manage training assignments.</div>' );
		} elseif ( $isSelf ) {
			$out->addHTML( '<div style="background:#d1ecf1;padding:10px 15px;margin:10px 0;border-left:4px solid #17a2b8;border-radius:0 4px 4px 0;"><em>Employee:</em> Use Mark Complete once you have read and understood a module.</div>' );
		}

		$out->addHTML( $this->renderTrainingTable( $modules, $usernameForUrl, $employeeParam, $isManager, $isSupervisor, $isSelf ) );
	}

	private function renderTrainingTable(
		array $modules,
		string $usernameForUrl,
		string $employeeParam,
		bool $isManager,
		bool $isSupervisor,
		bool $isSelf
	): string {
		$returnUrl = \SpecialPage::getTitleFor( 'FcpEmployeeTraining' )->getLocalURL()
			. '?employee=' . urlencode( $employeeParam );

		$specialBase = \SpecialPage::getTitleFor( 'FcpTrainingAction' )->getLocalURL();

		$statusLabels = [
			'verified'     => '<span style="color:#155724;font-weight:bold;">&#10003; Verified</span>',
			'completed'    => '<span style="color:#0c5460;font-weight:bold;">&#10003; Completed</span>',
			'na'           => '<span style="color:#856404;">N/A</span>',
			'assigned'     => '<span style="color:#383d41;">Assigned</span>',
			'not_assigned' => '<span style="color:#999;">Not Assigned</span>',
		];

		$html = '<table class="wikitable sortable" style="width:100%">'
			. '<tr>'
			. '<th style="color:#000;">Status</th>'
			. '<th style="color:#000;">Category</th>'
			. '<th style="color:#000;">Module Name</th>'
			. '<th style="color:#000;">Assigned</th>'
			. '<th style="color:#000;">Completed</th>'
			. '<th style="color:#000;">Verified</th>'
			. '</tr>';

		foreach ( $modules as $m ) {
			$moduleCode = $m['module_code'];
			$moduleName = htmlspecialchars( $m['module_name'] );
			$category   = htmlspecialchars( ucfirst( $m['category'] ) );
			$status     = $m['status'] ?? 'not_assigned';
			$statusHtml = $statusLabels[$status] ?? htmlspecialchars( $status );

			$assignUrl = $specialBase . '?' . http_build_query( [
				'employee' => $usernameForUrl, 'module' => $moduleCode,
				'action' => 'assign', 'return' => $returnUrl,
			] );
			$naUrl = $specialBase . '?' . http_build_query( [
				'employee' => $usernameForUrl, 'module' => $moduleCode,
				'action' => 'na', 'return' => $returnUrl,
			] );

			// --- Assigned cell ---
			// Manager: Assign (not_assigned) + N/A (not_assigned)
			// Supervisor: Re-assign (already assigned) + N/A (not_assigned or assigned)
			$assignedDate = $m['assigned_date'] ? htmlspecialchars( $m['assigned_date'] ) : '';
			$assignedCell = $assignedDate ?: '&mdash;';

			if ( $status === 'not_assigned' ) {
				if ( $isManager ) {
					$assignedCell = '<a href="' . htmlspecialchars( $assignUrl ) . '">Assign</a>'
						. ' <small>[<a href="' . htmlspecialchars( $naUrl ) . '">N/A</a>]</small>';
				} elseif ( $isSupervisor ) {
					$assignedCell = '<a href="' . htmlspecialchars( $assignUrl ) . '">Assign</a>'
						. ' <small>[<a href="' . htmlspecialchars( $naUrl ) . '">N/A</a>]</small>';
				}
			} elseif ( in_array( $status, [ 'assigned', 'completed' ] ) ) {
				if ( $isSupervisor ) {
					$assignedCell = $assignedDate
						. ' <small>[<a href="' . htmlspecialchars( $assignUrl ) . '">Re-assign</a>]'
						. ' [<a href="' . htmlspecialchars( $naUrl ) . '">N/A</a>]</small>';
				} elseif ( $isManager ) {
					// Manager can see the date but cannot re-assign
					$assignedCell = $assignedDate ?: '&mdash;';
				}
			}

			// --- Completed cell ---
			// Only the employee themselves can mark complete
			$completedDate = $m['completed_date'] ? htmlspecialchars( $m['completed_date'] ) : '';
			if ( $isSelf && $status === 'assigned' ) {
				$url = $specialBase . '?' . http_build_query( [
					'employee' => $usernameForUrl, 'module' => $moduleCode,
					'action' => 'complete', 'return' => $returnUrl,
				] );
				$completedCell = '<a href="' . htmlspecialchars( $url ) . '">Mark Complete</a>';
			} else {
				$completedCell = $completedDate ?: '&mdash;';
			}

			// --- Verified cell ---
			// Only supervisors can verify (not managers)
			$verifiedDate = $m['verified_date'] ? htmlspecialchars( $m['verified_date'] ) : '';
			if ( $isSupervisor && $status === 'completed' ) {
				$url = $specialBase . '?' . http_build_query( [
					'employee' => $usernameForUrl, 'module' => $moduleCode,
					'action' => 'verify', 'return' => $returnUrl,
				] );
				$verifiedCell = '<a href="' . htmlspecialchars( $url ) . '">Verify</a>';
			} else {
				$verifiedCell = $verifiedDate ?: '&mdash;';
			}

			$html .= "<tr><td>{$statusHtml}</td><td>{$category}</td><td>{$moduleName}</td>"
				. "<td>{$assignedCell}</td><td>{$completedCell}</td><td>{$verifiedCell}</td></tr>";
		}

		$html .= '</table>';
		return $html;
	}

	protected function getGroupName(): string {
		return 'other';
	}
}
