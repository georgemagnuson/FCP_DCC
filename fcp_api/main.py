"""
FCP CRUD API
Food Control Plan operational records for jitsu_fcp database.
Localhost only — served via uvicorn, accessed by MediaWiki extension.
"""
from fastapi import FastAPI
from contextlib import asynccontextmanager
import database
from routers import temperature, cooling, incidents, operations, business, media, training, employees, diary
from routers.business import suppliers_router, equipment_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    database.init_pool()
    yield
    if database._pool:
        database._pool.closeall()


app = FastAPI(
    title="FCP API",
    description="Food Control Plan operational records API. Internal use only.",
    version="0.1.0",
    lifespan=lifespan,
    # Disable docs on production — enable for development
    docs_url="/docs",
    redoc_url=None,
)

app.include_router(business.router)
app.include_router(media.router)
app.include_router(temperature.router)
app.include_router(cooling.router)
app.include_router(incidents.router)
app.include_router(operations.router)
app.include_router(training.router)
app.include_router(employees.router)
app.include_router(diary.router)
app.include_router(suppliers_router)
app.include_router(equipment_router)


@app.get("/health")
def health():
    """Health check — confirms API and DB are reachable."""
    with database.get_cursor() as cur:
        cur.execute("SELECT 1")
    return {"status": "ok"}
