"""
FCP API configuration.
All secrets loaded from environment variables or /usr/local/www/fcp_api/.env
"""
import os

# Database
DB_HOST     = os.getenv("FCP_DB_HOST", "localhost")
DB_PORT     = int(os.getenv("FCP_DB_PORT", "5432"))
DB_NAME     = os.getenv("FCP_DB_NAME", "jitsu_fcp")
DB_USER     = os.getenv("FCP_DB_USER", "postgres")
DB_PASSWORD = os.getenv("FCP_DB_PASSWORD", "")

# Shared secret — MW extension must send this in every request
# Set in environment: FCP_SHARED_SECRET=<random string>
SHARED_SECRET = os.getenv("FCP_SHARED_SECRET", "")

# API
API_HOST = "127.0.0.1"   # localhost only — not exposed externally
API_PORT = int(os.getenv("FCP_API_PORT", "8765"))
