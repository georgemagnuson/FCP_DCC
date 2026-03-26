<?php
/**
 * SpecialFcpFile — proxies media files from the FCP API to the browser.
 *
 * The FCP API runs on localhost only, so the browser cannot fetch media
 * directly. This Special page fetches the file server-side and streams
 * it back with the correct Content-Type.
 *
 * Usage:
 *   /mediawiki/index.php/Special:FcpFile?id=<uuid>
 *   /mediawiki/index.php/Special:FcpFile?id=<uuid>&thumb=1
 */
class SpecialFcpFile extends SpecialPage {

	public function __construct() {
		parent::__construct( 'FcpFile' );
	}

	public function execute( $subPage ): void {
		$request = $this->getRequest();
		$id      = $request->getText( 'id' );
		$thumb   = $request->getBool( 'thumb' );

		if ( !$id || !preg_match( '/^[0-9a-f\-]{36}$/', $id ) ) {
			$this->getOutput()->showErrorPage( 'error', 'badrequest' );
			return;
		}

		$user     = $this->getUser();
		$endpoint = $thumb
			? "media/item/{$id}/thumbnail"
			: "media/item/{$id}/file";

		try {
			$client = new FcpApiClient();
			[ $body, $contentType ] = $client->getRaw( $endpoint, $user );
		} catch ( \RuntimeException $e ) {
			$this->getOutput()->showErrorPage( 'error', 'badrequest' );
			return;
		}

		// Stream file directly — bypass MW output pipeline
		$response = $this->getRequest()->response();
		$response->header( 'Content-Type: ' . $contentType );
		$response->header( 'Content-Length: ' . strlen( $body ) );
		$response->header( 'Cache-Control: private, max-age=3600' );
		print $body;

		// Stop MW from appending HTML
		$this->getOutput()->disable();
	}

	public function isListed(): bool {
		return false;
	}
}
