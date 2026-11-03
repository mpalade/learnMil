# Fieldplot C2IP editor

A dependency-free browser port of the repository's organization-chart and map-overlay editing workflows. It runs locally in a modern browser and does not upload workspace data.

## Run

Open `index.html` directly in a browser. For local storage and file access, a local static server also works, for example:

```powershell
python -m http.server 8000
```

Then open `http://localhost:8000/port/`.

## Features

- Switch between an organization chart and a map overlay.
- Add, select, edit, reorder, reposition, and delete unit symbols.
- Edit unit name, unit type, echelon, hostility, and headquarters status.
- Draw and edit lines, arrows, axis-of-advance indicators, ambushes, circles, rectangles, freehand lines, and breach corridors.
- Load an image as a temporary overlay background.
- Import legacy `.c2ip` JSON and export organization charts or overlays in the legacy `TaskOrg` / `Overlay` JSON structure.
- Automatically save the current workspace in browser local storage.

The Clarion `.TPS` catalog/database files and the original Clarion symbol library are not ported. Background maps are temporary and are not embedded into the legacy C2IP file.
