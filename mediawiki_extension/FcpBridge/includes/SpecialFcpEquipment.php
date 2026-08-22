<?php
/**
 * Special:FcpEquipment — add, edit, and delete equipment records.
 *
 * URL actions:
 *   (none / ?action=list)         — redirect to Equipment_Registry_Documentation
 *   ?action=add                   — form to create new equipment
 *   ?action=edit&id=<uuid>        — form to edit existing equipment (pre-filled)
 *   ?action=delete&id=<uuid>      — confirmation page
 *
 * GET renders a form; POST processes and redirects.
 *
 * Requires training_manager group for add/edit/delete.
 */
class SpecialFcpEquipment extends \SpecialPage {

	private const LOCATION_ID = 'b1000000-0000-0000-0000-000000000001';
	private const REGISTRY_PAGE = 'Equipment_Registry_Documentation';

	public function __construct() {
		parent::__construct( 'FcpEquipment', 'read' );
	}

	public function execute( $subpage ): void {
		$this->setHeaders();
		$out     = $this->getOutput();
		$request = $this->getRequest();
		$user    = $this->getUser();

		if ( !$user->isRegistered() ) {
			$out->addHTML( '<p class="error">You must be logged in.</p>' );
			return;
		}

		$action = $request->getVal( 'action', 'list' );
		$id     = trim( $request->getVal( 'id', '' ) );

		switch ( $action ) {
			case 'add':
				if ( $request->wasPosted() ) {
					$this->handleAdd( $out, $request, $user );
				} else {
					$this->renderForm( $out, $user, null );
				}
				break;

			case 'edit':
				if ( !$id ) {
					$out->addHTML( '<p class="error">Missing equipment ID.</p>' );
					return;
				}
				if ( $request->wasPosted() ) {
					$this->handleEdit( $out, $request, $user, $id );
				} else {
					$equipment = $this->fetchEquipment( $out, $user, $id );
					if ( $equipment !== null ) {
						$this->renderForm( $out, $user, $equipment );
					}
				}
				break;

			case 'delete':
				if ( !$id ) {
					$out->addHTML( '<p class="error">Missing equipment ID.</p>' );
					return;
				}
				if ( $request->wasPosted() ) {
					$this->handleDelete( $out, $request, $user, $id );
				} else {
					$equipment = $this->fetchEquipment( $out, $user, $id );
					if ( $equipment !== null ) {
						$this->renderDeleteConfirm( $out, $user, $equipment );
					}
				}
				break;

			default:
				$out->redirect(
					\Title::newFromText( self::REGISTRY_PAGE )->getFullURL()
				);
		}
	}

	// =========================================================
	// ADD / EDIT FORM
	// =========================================================

	private function renderForm( $out, $user, ?array $equipment ): void {
		$isEdit = ( $equipment !== null );
		$title  = $isEdit ? 'Edit Equipment' : 'Add Equipment';
		$out->setPageTitle( $title );

		// Fetch categories for dropdown
		$categories = $this->fetchCategories( $out, $user );
		if ( $categories === null ) {
			return;
		}

		$token     = $user->getEditToken();
		$actionUrl = htmlspecialchars(
			$this->getPageTitle()->getLocalURL(
				$isEdit ? [ 'action' => 'edit', 'id' => $equipment['id'] ] : [ 'action' => 'add' ]
			)
		);
		$backUrl   = htmlspecialchars(
			\Title::newFromText( self::REGISTRY_PAGE )->getLocalURL()
		);

		// Build category options
		$categoryOptions = '';
		$selectedCatId   = $equipment['category_id'] ?? '';
		foreach ( $categories as $cat ) {
			$catId    = htmlspecialchars( $cat['id'] );
			$catName  = htmlspecialchars( $cat['name'] );
			$selected = ( $cat['id'] === $selectedCatId ) ? ' selected' : '';
			$categoryOptions .= "<option value=\"{$catId}\"{$selected}>{$catName}</option>";
		}

		// Pre-fill values for edit
		$v = static function( ?string $val ): string {
			return htmlspecialchars( $val ?? '' );
		};

		$fName     = $v( $equipment['name'] ?? '' );
		$fMake     = $v( $equipment['make'] ?? '' );
		$fModel    = $v( $equipment['model'] ?? '' );
		$fSerial   = $v( $equipment['serial_number'] ?? '' );
		$fMinTemp  = $v( isset( $equipment['min_safe_temp'] ) ? (string)$equipment['min_safe_temp'] : '' );
		$fMaxTemp  = $v( isset( $equipment['max_safe_temp'] ) ? (string)$equipment['max_safe_temp'] : '' );
		$fFreq     = $v( isset( $equipment['check_frequency_minutes'] ) ? (string)$equipment['check_frequency_minutes'] : '' );
		$fNotes      = $v( $equipment['notes'] ?? '' );
		$submitBtn   = $isEdit ? 'Save Changes' : 'Add Equipment';
		$locationId  = self::LOCATION_ID;

		$out->addHTML( <<<HTML
<p><a href="{$backUrl}">&larr; Equipment Registry</a></p>

<div style="background:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;padding:20px;max-width:560px;">
<form method="post" action="{$actionUrl}">
<input type="hidden" name="wpEditToken" value="{$token}">
<input type="hidden" name="location_id" value="{$locationId}">

<table class="wikitable" style="width:100%;">
<tr>
  <th style="width:200px;color:#000;">Category <span style="color:red">*</span></th>
  <td>
    <select name="category_id" required style="width:100%;padding:6px;box-sizing:border-box;">
      <option value="">— select —</option>
      {$categoryOptions}
    </select>
  </td>
</tr>
<tr>
  <th style="color:#000;">Name <span style="color:red">*</span></th>
  <td><input type="text" name="name" value="{$fName}" required style="width:100%;padding:6px;box-sizing:border-box;"
      placeholder="e.g. FRIDGE-02 — Walk-in Cooler"></td>
</tr>
<tr>
  <th style="color:#000;">Make</th>
  <td><input type="text" name="make" value="{$fMake}" style="width:100%;padding:6px;box-sizing:border-box;"
      placeholder="Manufacturer"></td>
</tr>
<tr>
  <th style="color:#000;">Model</th>
  <td><input type="text" name="model" value="{$fModel}" style="width:100%;padding:6px;box-sizing:border-box;"
      placeholder="Model number"></td>
</tr>
<tr>
  <th style="color:#000;">Serial No.</th>
  <td><input type="text" name="serial_number" value="{$fSerial}" style="width:100%;padding:6px;box-sizing:border-box;"></td>
</tr>
<tr>
  <th style="color:#000;">Min Safe Temp (°C)</th>
  <td><input type="number" name="min_safe_temp" value="{$fMinTemp}" step="0.1"
      style="width:120px;padding:6px;" placeholder="e.g. 0"></td>
</tr>
<tr>
  <th style="color:#000;">Max Safe Temp (°C)</th>
  <td><input type="number" name="max_safe_temp" value="{$fMaxTemp}" step="0.1"
      style="width:120px;padding:6px;" placeholder="e.g. 4"></td>
</tr>
<tr>
  <th style="color:#000;">Check Frequency (min)</th>
  <td><input type="number" name="check_frequency_minutes" value="{$fFreq}" min="1"
      style="width:120px;padding:6px;" placeholder="e.g. 240"></td>
</tr>
<tr>
  <th style="color:#000;vertical-align:top;padding-top:10px;">Notes</th>
  <td><textarea name="notes" rows="3" style="width:100%;padding:6px;box-sizing:border-box;">{$fNotes}</textarea></td>
</tr>
</table>

<p style="margin-top:12px;">
  <input type="submit" value="{$submitBtn}"
         style="background:#0070c0;color:white;border:none;padding:8px 20px;border-radius:4px;cursor:pointer;font-size:1em;">
  &nbsp;
  <a href="{$backUrl}" style="padding:8px 16px;border:1px solid #ccc;border-radius:4px;text-decoration:none;color:#333;">Cancel</a>
</p>
</form>
</div>
HTML );
	}

	private function handleAdd( $out, $request, $user ): void {
		if ( !$user->matchEditToken( $request->getVal( 'wpEditToken' ) ) ) {
			$out->addHTML( '<p class="error">Security token mismatch. Please try again.</p>' );
			$this->renderForm( $out, $user, null );
			return;
		}

		$data = $this->collectFormData( $request );
		$data['location_id'] = self::LOCATION_ID;

		if ( !$data['name'] || !$data['category_id'] ) {
			$out->addHTML( '<p class="error">Name and category are required.</p>' );
			$this->renderForm( $out, $user, null );
			return;
		}

		try {
			$client = new FcpApiClient();
			$client->post( 'equipment', $data, $user );
		} catch ( \RuntimeException $e ) {
			$out->addHTML( '<p class="error">Error: ' . htmlspecialchars( $e->getMessage() ) . '</p>' );
			$this->renderForm( $out, $user, null );
			return;
		}

		$out->redirect(
			\Title::newFromText( self::REGISTRY_PAGE )->getFullURL( [ 'fcp_success' => '1' ] )
		);
	}

	private function handleEdit( $out, $request, $user, string $id ): void {
		if ( !$user->matchEditToken( $request->getVal( 'wpEditToken' ) ) ) {
			$out->addHTML( '<p class="error">Security token mismatch. Please try again.</p>' );
			$equipment = $this->fetchEquipment( $out, $user, $id );
			if ( $equipment !== null ) {
				$this->renderForm( $out, $user, $equipment );
			}
			return;
		}

		$data = $this->collectFormData( $request );
		$data['location_id'] = self::LOCATION_ID;

		if ( !$data['name'] || !$data['category_id'] ) {
			$out->addHTML( '<p class="error">Name and category are required.</p>' );
			$equipment = $this->fetchEquipment( $out, $user, $id );
			if ( $equipment !== null ) {
				$this->renderForm( $out, $user, $equipment );
			}
			return;
		}

		try {
			$client = new FcpApiClient();
			$client->put( 'equipment/' . rawurlencode( $id ), $data, $user );
		} catch ( \RuntimeException $e ) {
			$out->addHTML( '<p class="error">Error: ' . htmlspecialchars( $e->getMessage() ) . '</p>' );
			$equipment = $this->fetchEquipment( $out, $user, $id );
			if ( $equipment !== null ) {
				$this->renderForm( $out, $user, $equipment );
			}
			return;
		}

		$out->redirect(
			\Title::newFromText( self::REGISTRY_PAGE )->getFullURL( [ 'fcp_success' => '1' ] )
		);
	}

	// =========================================================
	// DELETE
	// =========================================================

	private function renderDeleteConfirm( $out, $user, array $equipment ): void {
		$out->setPageTitle( 'Delete Equipment' );

		$name      = htmlspecialchars( $equipment['name'] );
		$category  = htmlspecialchars( $equipment['category'] );
		$token     = $user->getEditToken();
		$actionUrl = htmlspecialchars(
			$this->getPageTitle()->getLocalURL( [ 'action' => 'delete', 'id' => $equipment['id'] ] )
		);
		$backUrl   = htmlspecialchars(
			\Title::newFromText( self::REGISTRY_PAGE )->getLocalURL()
		);

		$out->addHTML( <<<HTML
<p><a href="{$backUrl}">&larr; Equipment Registry</a></p>

<div style="background:#fff3cd;border:1px solid #ffc107;border-radius:4px;padding:20px;max-width:500px;">
<p><strong>Are you sure you want to delete this equipment record?</strong></p>
<table class="wikitable" style="width:auto;">
<tr><th style="color:#000;">Name</th><td>{$name}</td></tr>
<tr><th style="color:#000;">Category</th><td>{$category}</td></tr>
</table>
<p style="color:#856404;">This will hide the equipment from all FCP records. Historical temperature and compliance logs are retained.</p>

<form method="post" action="{$actionUrl}">
<input type="hidden" name="wpEditToken" value="{$token}">
<input type="submit" value="Yes, Delete"
       style="background:#dc3545;color:white;border:none;padding:8px 20px;border-radius:4px;cursor:pointer;font-size:1em;">
&nbsp;
<a href="{$backUrl}" style="padding:8px 16px;border:1px solid #ccc;border-radius:4px;text-decoration:none;color:#333;">Cancel</a>
</form>
</div>
HTML );
	}

	private function handleDelete( $out, $request, $user, string $id ): void {
		if ( !$user->matchEditToken( $request->getVal( 'wpEditToken' ) ) ) {
			$out->addHTML( '<p class="error">Security token mismatch. Please try again.</p>' );
			$equipment = $this->fetchEquipment( $out, $user, $id );
			if ( $equipment !== null ) {
				$this->renderDeleteConfirm( $out, $user, $equipment );
			}
			return;
		}

		try {
			$client = new FcpApiClient();
			$client->delete( 'equipment/' . rawurlencode( $id ), $user );
		} catch ( \RuntimeException $e ) {
			$out->addHTML( '<p class="error">Error: ' . htmlspecialchars( $e->getMessage() ) . '</p>' );
			return;
		}

		$out->redirect(
			\Title::newFromText( self::REGISTRY_PAGE )->getFullURL( [ 'fcp_success' => '1' ] )
		);
	}

	// =========================================================
	// Helpers
	// =========================================================

	private function collectFormData( $request ): array {
		$data = [
			'category_id' => trim( $request->getVal( 'category_id', '' ) ),
			'name'        => trim( $request->getVal( 'name', '' ) ),
			'make'        => trim( $request->getVal( 'make', '' ) ) ?: null,
			'model'       => trim( $request->getVal( 'model', '' ) ) ?: null,
			'serial_number' => trim( $request->getVal( 'serial_number', '' ) ) ?: null,
			'notes'       => trim( $request->getVal( 'notes', '' ) ) ?: null,
		];

		$minTemp = $request->getVal( 'min_safe_temp', '' );
		$maxTemp = $request->getVal( 'max_safe_temp', '' );
		$freq    = $request->getVal( 'check_frequency_minutes', '' );

		if ( $minTemp !== '' ) {
			$data['min_safe_temp'] = (float) $minTemp;
		}
		if ( $maxTemp !== '' ) {
			$data['max_safe_temp'] = (float) $maxTemp;
		}
		if ( $freq !== '' ) {
			$data['check_frequency_minutes'] = (int) $freq;
		}

		return $data;
	}

	private function fetchEquipment( $out, $user, string $id ): ?array {
		try {
			$client = new FcpApiClient();
			return $client->get( 'equipment/' . rawurlencode( $id ), [], $user );
		} catch ( \RuntimeException $e ) {
			$out->addHTML( '<p class="error">Could not load equipment: '
				. htmlspecialchars( $e->getMessage() ) . '</p>' );
			return null;
		}
	}

	private function fetchCategories( $out, $user ): ?array {
		try {
			$client = new FcpApiClient();
			return $client->get( 'equipment/categories', [], $user );
		} catch ( \RuntimeException $e ) {
			$out->addHTML( '<p class="error">Could not load categories: '
				. htmlspecialchars( $e->getMessage() ) . '</p>' );
			return null;
		}
	}

	protected function getGroupName(): string {
		return 'other';
	}
}
