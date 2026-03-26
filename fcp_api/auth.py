"""
Authentication and permission checking.

Every request from the MW extension must include:
  X-FCP-Secret: <shared secret>       — proves request came from MW extension
  X-MW-User:    <mediawiki username>   — the logged-in MW user
  X-MW-Groups:  <comma-separated groups> — MW explicit groups, e.g. "sysop,bureaucrat"

The API trusts the MW extension as the identity provider.
Any valid MW user (correct secret + non-empty username) is treated as level 1
(employee). Explicit MW groups can elevate that level further.
"""
from fastapi import Header, HTTPException, status
import config

# Permission levels in ascending order.
# Any authenticated MW user starts at level 1 — no FCP-specific group needed.
GROUPS = {
    "sysop":               4,
    "bureaucrat":          3,
    "training_manager":    3,
    "training_supervisor": 2,
    "training_employee":   1,
}


def _parse_groups(raw: str) -> set[str]:
    return {g.strip() for g in raw.split(",") if g.strip()}


def _max_level(groups: set[str]) -> int:
    # Floor of 1: any authenticated MW user has at least employee-level access.
    return max((GROUPS.get(g, 0) for g in groups), default=0) or 1


def verify_request(
    x_fcp_secret: str  = Header(..., alias="X-FCP-Secret"),
    x_mw_user:    str  = Header(..., alias="X-MW-User"),
    x_mw_groups:  str  = Header("", alias="X-MW-Groups"),
) -> dict:
    """
    Dependency injected into every route.
    Returns caller context: {username, groups, level}
    """
    if not config.SHARED_SECRET:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="API shared secret not configured."
        )
    if x_fcp_secret != config.SHARED_SECRET:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid shared secret."
        )
    if not x_mw_user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="MW user header missing."
        )

    groups = _parse_groups(x_mw_groups)
    return {
        "username": x_mw_user,
        "groups":   groups,
        "level":    _max_level(groups),
    }


def require_level(min_level: int):
    """
    Returns a dependency that enforces a minimum permission level.
    Usage: Depends(require_level(GROUPS["training_manager"]))
    """
    def _check(caller: dict = None):
        if caller["level"] < min_level:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Insufficient permissions."
            )
        return caller
    return _check
