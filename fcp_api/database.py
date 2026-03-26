"""
PostgreSQL connection pool using psycopg2.
"""
import psycopg2
import psycopg2.pool
import psycopg2.extras
from contextlib import contextmanager
import config

_pool: psycopg2.pool.ThreadedConnectionPool | None = None


def init_pool():
    global _pool
    _pool = psycopg2.pool.ThreadedConnectionPool(
        minconn=2,
        maxconn=10,
        host=config.DB_HOST,
        port=config.DB_PORT,
        dbname=config.DB_NAME,
        user=config.DB_USER,
        password=config.DB_PASSWORD,
    )


@contextmanager
def get_conn():
    """Yield a connection from the pool, return it when done."""
    conn = _pool.getconn()
    try:
        yield conn
        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally:
        _pool.putconn(conn)


@contextmanager
def get_cursor():
    """Yield a RealDictCursor — rows come back as dicts."""
    with get_conn() as conn:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
            yield cur
