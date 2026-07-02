# MCP Session Log - Duntong

Current status: no MCP sessions were run in this Round 30 conservative lane.
This log is present so future V5 work can record OpenSCAD, Blender,
Illustrator, Photoshop, image-generation, or other MCP-generated artifacts
without inventing provenance for the existing packet.

| timestamp_utc | tool | session_id | artifact | parent_artifact | authority | notes |
|---|---|---|---|---|---|---|
| 2026-05-18 | none | n/a | cad/duntong_master.scad | cad/design-table-inputs.csv | starter_layout | Existing OpenSCAD starter reviewed as packet evidence; no live MCP session used in this lane. |
| 2026-05-18 | none | n/a | drawings/*.svg | cad/design-table-inputs.csv | derived_preview | Existing SVGs are review previews and are tracked in visual-output-register.csv. |
| 2026-07-01 | claude-code (Fable 5) + OpenSCAD CLI | fable-v5-refresh-2026-07-01 | cad/duntong_master.scad | cad/design-table-inputs.csv | pending_measurement | V5 packet refresh: existing parametric master kept as-is (EXISTING MASTERS clause; not rewritten). Render check: `openscad -o /tmp/duntong-check.stl cad/duntong_master.scad`, exit 0. |
| 2026-07-01 | claude-code (Fable 5) | fable-v5-refresh-2026-07-01 | wolfram/duntong-wolfram-model.wl | cad/design-table-inputs.csv | derived_preview | Existing Wolfram cantilever/cavity model source reviewed for V5 register; source-only, not executed (wolframscript not run per V5 evidence rule). |
| 2026-07-01 | claude-code (Fable 5) | fable-v5-refresh-2026-07-01 | bom.csv, sourcing.csv, cut-list.csv, validation.csv, cad/design-table-inputs.csv | duntong-design-table.xlsx | fabrication | V5 refresh pass: tabular packet data reviewed against design-table baseline; no dimension changes made. Provenance row added to satisfy V5 fabrication-artifact logging. |
