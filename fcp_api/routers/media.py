from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form
from fastapi.responses import Response
from typing import Optional
import psycopg2
import database
import auth

router = APIRouter(prefix="/media", tags=["media"])


@router.get("/{business_id}")
def list_media(
    business_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """List all media for a business (metadata only, no file bytes)."""
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT id, business_id, location_id, title, mime_type,
                   length(file_data)      AS file_size,
                   (thumbnail_data IS NOT NULL) AS has_thumbnail,
                   created_by, created_at
            FROM media
            WHERE business_id = %s AND is_active = TRUE
            ORDER BY created_at
        """, (business_id,))
        return [dict(r) for r in cur.fetchall()]


@router.get("/item/{id}")
def get_media(
    id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Single media item metadata."""
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT id, business_id, location_id, title, mime_type,
                   length(file_data)      AS file_size,
                   (thumbnail_data IS NOT NULL) AS has_thumbnail,
                   created_by, created_at
            FROM media
            WHERE id = %s AND is_active = TRUE
        """, (id,))
        row = cur.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Media not found.")
        return dict(row)


@router.get("/item/{id}/file")
def get_media_file(
    id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Stream the media file with correct Content-Type."""
    with database.get_cursor() as cur:
        cur.execute(
            "SELECT mime_type, file_data FROM media WHERE id = %s AND is_active = TRUE",
            (id,)
        )
        row = cur.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Media not found.")
        return Response(
            content=bytes(row["file_data"]),
            media_type=row["mime_type"],
        )


@router.get("/item/{id}/thumbnail")
def get_thumbnail(
    id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Stream the hero frame / thumbnail for video or audio."""
    with database.get_cursor() as cur:
        cur.execute(
            "SELECT thumbnail_data FROM media WHERE id = %s AND is_active = TRUE",
            (id,)
        )
        row = cur.fetchone()
        if not row or not row["thumbnail_data"]:
            raise HTTPException(status_code=404, detail="Thumbnail not found.")
        return Response(
            content=bytes(row["thumbnail_data"]),
            media_type="image/jpeg",
        )


@router.post("/")
def upload_media(
    business_id: str          = Form(...),
    title: str                = Form(...),
    location_id: Optional[str] = Form(None),
    file: UploadFile          = File(...),
    thumbnail: Optional[UploadFile] = File(None),
    caller: dict              = Depends(auth.verify_request),
):
    """Upload a new media item. thumbnail is optional (for video/audio hero frame)."""
    file_data      = file.file.read()
    mime_type      = file.content_type or "application/octet-stream"
    thumbnail_data = thumbnail.file.read() if thumbnail else None

    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO media
                (business_id, location_id, title, mime_type, file_data, thumbnail_data, created_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            RETURNING id
        """, (
            business_id,
            location_id or None,
            title,
            mime_type,
            psycopg2.Binary(file_data),
            psycopg2.Binary(thumbnail_data) if thumbnail_data else None,
            caller["username"],
        ))
        row = cur.fetchone()
        return {
            "id":        str(row["id"]),
            "title":     title,
            "mime_type": mime_type,
            "file_size": len(file_data),
        }


@router.delete("/item/{id}")
def delete_media(
    id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Soft-delete a media item. Requires sysop level."""
    auth.require_level(auth.GROUPS["sysop"])(caller)
    with database.get_cursor() as cur:
        cur.execute(
            "UPDATE media SET is_active = FALSE WHERE id = %s AND is_active = TRUE RETURNING id",
            (id,)
        )
        if not cur.fetchone():
            raise HTTPException(status_code=404, detail="Media not found.")
        return {"status": "deleted", "id": id}
