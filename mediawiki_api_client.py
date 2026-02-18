#!/usr/bin/env python3
"""
MediaWiki API Client for FCP_DCC Project
Stable, auditable way to edit pages via the MediaWiki API
"""

import urllib.request
import urllib.parse
import json
import http.cookiejar
from typing import Optional, Dict, Any
import sys

class MediaWikiAPI:
    def __init__(self, base_url: str, username: str, password: str):
        self.base_url = base_url
        self.username = username
        self.password = password
        self.cookie_jar = http.cookiejar.CookieJar()
        self.opener = urllib.request.build_opener(
            urllib.request.HTTPCookieProcessor(self.cookie_jar)
        )
        urllib.request.install_opener(self.opener)
        self.authenticated = False

    def _request(self, method: str = 'GET', params: Dict = None, data: Dict = None) -> Dict:
        """Make API request"""
        if method == 'GET':
            if params:
                params['format'] = 'json'
                query_string = urllib.parse.urlencode(params)
                url = f"{self.base_url}?{query_string}"
                with urllib.request.urlopen(url) as response:
                    return json.loads(response.read())

        elif method == 'POST':
            if data is None:
                data = {}
            data['format'] = 'json'
            encoded_data = urllib.parse.urlencode(data).encode('utf-8')
            with urllib.request.urlopen(self.base_url, encoded_data) as response:
                return json.loads(response.read())

        raise ValueError(f"Unsupported method: {method}")

    def get_token(self, token_type: str = 'login') -> str:
        """Get API token"""
        result = self._request('GET', {'action': 'query', 'meta': 'tokens', 'type': token_type})
        return result['query']['tokens'][f'{token_type}token']

    def login(self) -> bool:
        """Authenticate to MediaWiki"""
        print("Authenticating to MediaWiki...")
        token = self.get_token('login')

        result = self._request('POST', data={
            'action': 'clientlogin',
            'username': self.username,
            'password': self.password,
            'logintoken': token,
            'loginreturnurl': self.base_url.rsplit('/', 1)[0] + '/index.php',
        })

        if result.get('clientlogin', {}).get('status') == 'PASS':
            self.authenticated = True
            print(f"✓ Authenticated as {self.username}")
            return True
        else:
            print(f"✗ Authentication failed: {result}")
            return False

    def get_page(self, title: str) -> Optional[Dict]:
        """Get page content"""
        if not self.authenticated:
            print("Not authenticated. Call login() first.")
            return None

        result = self._request('GET', {
            'action': 'query',
            'titles': title,
            'prop': 'revisions',
            'rvprop': 'content|timestamp',
        })

        pages = result.get('query', {}).get('pages', {})
        if not pages:
            return None

        page = list(pages.values())[0]
        if 'revisions' in page:
            return {
                'title': title,
                'content': page['revisions'][0]['*'],
                'timestamp': page['revisions'][0]['timestamp'],
                'pageid': page.get('pageid'),
            }
        return None

    def edit_page(self, title: str, content: str, summary: str = "") -> bool:
        """Edit a page"""
        if not self.authenticated:
            print("Not authenticated. Call login() first.")
            return False

        # Get CSRF token for editing
        csrf_token = self.get_token('csrf')

        print(f"Editing page: {title}")
        result = self._request('POST', data={
            'action': 'edit',
            'title': title,
            'text': content,
            'summary': summary,
            'token': csrf_token,
        })

        if 'error' in result:
            print(f"✗ Edit failed: {result['error']}")
            return False

        if result.get('edit', {}).get('result') == 'Success':
            print(f"✓ Page edited successfully")
            return True

        print(f"✗ Unexpected result: {result}")
        return False

    def edit_section(self, title: str, section: int, content: str, summary: str = "") -> bool:
        """Edit a specific section"""
        if not self.authenticated:
            print("Not authenticated. Call login() first.")
            return False

        csrf_token = self.get_token('csrf')

        print(f"Editing section {section} of {title}")
        result = self._request('POST', data={
            'action': 'edit',
            'title': title,
            'section': str(section),
            'text': content,
            'summary': summary,
            'token': csrf_token,
        })

        if 'error' in result:
            print(f"✗ Edit failed: {result['error']}")
            return False

        if result.get('edit', {}).get('result') == 'Success':
            print(f"✓ Section {section} edited successfully")
            return True

        print(f"✗ Unexpected result: {result}")
        return False


def main():
    # Configuration
    BASE_URL = 'http://192.168.2.10/mediawiki/api.php'
    USERNAME = 'Georgemagnuson'
    PASSWORD = 'TestPassword123'

    # Create client
    client = MediaWikiAPI(BASE_URL, USERNAME, PASSWORD)

    # Login
    if not client.login():
        sys.exit(1)

    # Example: Get page content
    print("\n--- Getting Page Content ---")
    page = client.get_page('FCP:Setting_Up:Responsibility')
    if page:
        print(f"Title: {page['title']}")
        print(f"Timestamp: {page['timestamp']}")
        print(f"Content length: {len(page['content'])} chars")
        print(f"Preview:\n{page['content'][:300]}...\n")

    # Example: Edit the page (commented out for safety)
    # print("--- Editing Page ---")
    # new_content = page['content'].replace("Old text", "New text")
    # client.edit_page('Test:Page', new_content, "Updated via API")


if __name__ == '__main__':
    main()
