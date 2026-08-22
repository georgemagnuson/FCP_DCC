<?php
/**
 * FcpApiClient — HTTP client for the FCP CRUD API.
 *
 * Adds auth headers automatically on every request:
 *   X-FCP-Secret  — shared secret proving request came from MediaWiki
 *   X-MW-User     — logged-in MediaWiki username
 *   X-MW-Groups   — comma-separated MediaWiki groups for the user
 */
class FcpApiClient {

	private string $baseUrl;
	private string $secret;

	public function __construct() {
		$this->baseUrl = $GLOBALS['wgFcpApiUrl'] ?? 'http://127.0.0.1:8765';
		$this->secret  = $GLOBALS['wgFcpApiSecret'] ?? '';
	}

	/**
	 * Build auth headers for the current MediaWiki user.
	 */
	private function authHeaders( \MediaWiki\User\User $user ): array {
		$userGroupManager = \MediaWiki\MediaWikiServices::getInstance()->getUserGroupManager();
		$groups = $userGroupManager->getUserGroups( $user );
		return [
			'X-FCP-Secret' => $this->secret,
			'X-MW-User'    => $user->getName(),
			'X-MW-Groups'  => implode( ',', $groups ),
			'Content-Type' => 'application/json',
		];
	}

	/**
	 * Get the MW 1.43 HttpRequestFactory service.
	 */
	private function httpFactory(): \MediaWiki\Http\HttpRequestFactory {
		return \MediaWiki\MediaWikiServices::getInstance()->getHttpRequestFactory();
	}

	/**
	 * POST data to an API endpoint.
	 * Returns decoded response array or throws on error.
	 */
	public function post( string $endpoint, array $data, \MediaWiki\User\User $user ): array {
		$url = rtrim( $this->baseUrl, '/' ) . '/' . ltrim( $endpoint, '/' );

		$req = $this->httpFactory()->create( $url, [
			'method'   => 'POST',
			'timeout'  => 10,
			'postData' => json_encode( $data ),
		] );

		foreach ( $this->authHeaders( $user ) as $key => $value ) {
			$req->setHeader( $key, $value );
		}

		$status = $req->execute();

		if ( !$status->isOK() ) {
			$body    = $req->getContent();
			$decoded = json_decode( $body, true );
			$detail  = $decoded['detail'] ?? $body ?? 'Unknown error';
			throw new \RuntimeException( "FCP API error ($endpoint): $detail" );
		}

		return json_decode( $req->getContent(), true ) ?? [];
	}

	/**
	 * GET raw bytes from an API endpoint (for media files).
	 * Returns [ $body, $contentType ] or throws on error.
	 */
	public function getRaw( string $endpoint, \MediaWiki\User\User $user ): array {
		$url = rtrim( $this->baseUrl, '/' ) . '/' . ltrim( $endpoint, '/' );

		$req = $this->httpFactory()->create( $url, [
			'method'  => 'GET',
			'timeout' => 30,
		] );

		foreach ( $this->authHeaders( $user ) as $key => $value ) {
			$req->setHeader( $key, $value );
		}

		$status = $req->execute();

		if ( !$status->isOK() ) {
			throw new \RuntimeException( "FCP API error ($endpoint): could not fetch file" );
		}

		$contentType = $req->getResponseHeader( 'content-type' ) ?? 'application/octet-stream';
		return [ $req->getContent(), $contentType ];
	}

	/**
	 * PUT data to an API endpoint.
	 * Returns decoded response array or throws on error.
	 */
	public function put( string $endpoint, array $data, \MediaWiki\User\User $user ): array {
		$url = rtrim( $this->baseUrl, '/' ) . '/' . ltrim( $endpoint, '/' );

		$req = $this->httpFactory()->create( $url, [
			'method'   => 'PUT',
			'timeout'  => 10,
			'postData' => json_encode( $data ),
		] );

		foreach ( $this->authHeaders( $user ) as $key => $value ) {
			$req->setHeader( $key, $value );
		}

		$status = $req->execute();

		if ( !$status->isOK() ) {
			$body    = $req->getContent();
			$decoded = json_decode( $body, true );
			$detail  = $decoded['detail'] ?? $body ?? 'Unknown error';
			throw new \RuntimeException( "FCP API error ($endpoint): $detail" );
		}

		return json_decode( $req->getContent(), true ) ?? [];
	}

	/**
	 * DELETE an API endpoint.
	 * Returns decoded response array or throws on error.
	 */
	public function delete( string $endpoint, \MediaWiki\User\User $user ): array {
		$url = rtrim( $this->baseUrl, '/' ) . '/' . ltrim( $endpoint, '/' );

		$req = $this->httpFactory()->create( $url, [
			'method'  => 'DELETE',
			'timeout' => 10,
		] );

		foreach ( $this->authHeaders( $user ) as $key => $value ) {
			$req->setHeader( $key, $value );
		}

		$status = $req->execute();

		if ( !$status->isOK() ) {
			$body    = $req->getContent();
			$decoded = json_decode( $body, true );
			$detail  = $decoded['detail'] ?? $body ?? 'Unknown error';
			throw new \RuntimeException( "FCP API error ($endpoint): $detail" );
		}

		return json_decode( $req->getContent(), true ) ?? [];
	}

	/**
	 * GET data from an API endpoint.
	 * Returns decoded response array or throws on error.
	 */
	public function get( string $endpoint, array $params, \MediaWiki\User\User $user ): array {
		$url = rtrim( $this->baseUrl, '/' ) . '/' . ltrim( $endpoint, '/' );
		if ( $params ) {
			$url .= '?' . http_build_query( $params );
		}

		$req = $this->httpFactory()->create( $url, [
			'method'  => 'GET',
			'timeout' => 10,
		] );

		foreach ( $this->authHeaders( $user ) as $key => $value ) {
			$req->setHeader( $key, $value );
		}

		$status = $req->execute();

		if ( !$status->isOK() ) {
			$body    = $req->getContent();
			$decoded = json_decode( $body, true );
			$detail  = $decoded['detail'] ?? $body ?? 'Unknown error';
			throw new \RuntimeException( "FCP API error ($endpoint): $detail" );
		}

		return json_decode( $req->getContent(), true ) ?? [];
	}
}
