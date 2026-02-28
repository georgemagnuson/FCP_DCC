# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FCP_DCC is a Python project. Add a brief description of the project's purpose and main functionality here once the codebase is established.

## Development Commands

### Setup

```bash
# Set up the development environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -e ".[dev]"   # Install package in editable mode with dev dependencies
```

### Running Tests

```bash
# Run all tests
pytest

# Run specific test file
pytest tests/test_module.py

# Run with coverage
pytest --cov=src
```

### Code Quality

```bash
# Lint with ruff
ruff check src/ tests/

# Format with ruff
ruff format src/ tests/

# Type checking (if using mypy)
mypy src/
```

### Building

```bash
# Build distribution packages
python -m build

# Install in development mode
pip install -e .
```

## Project Structure

Once the project structure is established, describe:
- Main package location (src/ vs package_name/)
- Key modules and their purposes
- Tests organization
- Configuration file locations

## Architecture Notes

Add high-level architectural information here once the codebase grows, including:
- Core design patterns used
- Key dependencies and their roles
- Major components and their interactions
- Data flow between systems

## Configuration

Document any important configuration:
- Environment variables required
- Configuration file formats and locations
- Development vs. production settings

## File Access Permissions

This project requires access to temporary files for Memory Bank document extraction and data processing:
- Allow reading from /tmp/
- Allow writing to /tmp/
- Memory Bank extracts documents to /tmp/ for analysis

## Common Development Tasks

Add task-specific instructions here as the project develops, such as:
- How to add a new feature
- How to run a specific component
- How to work with the database (if applicable)
- How to handle common issues
