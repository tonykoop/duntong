# Drawing Brief

## Drawing Set

The current SVG drawing set is review-grade and should be replaced or extended by SolidWorks drawings before cutting expensive stock.
Visual authority for the current packet is tracked in
`visual-output-register.csv`. The existing SVG files are derived review
previews, not DXF/CAD fabrication authority.

| Drawing | Purpose |
|---|---|
| `drawings/body-overview.svg` | Overall medium and handheld envelopes, major datums, V1 build target |
| `drawings/tongue-layout.svg` | Single-ring tongue schedule, note order, tongue lengths, wrap-template concept |
| `drawings/end-config-options.svg` | Sealed, ported, open/open, and drumhead end variants |
| `drawings/section-view.svg` | Cross-section of stave shell, wall/tongue thickness, end cap, V-block fixture concept |

## Drawing Standards

Each drawing must preserve:

- Title block with instrument, part, units, revision, date, and source workbook.
- Datums: shell axis A, left end B, right end C, equator plane D, index zero E.
- Critical dimensions: OD, ID, length, wall/tongue thickness, tongue length, tongue width, slit width, port diameter, and end cap rabbet.
- Default tolerance block: +/- 0.005 in for tongue length/thickness, +/- 0.030 in for noncritical wood body features unless CAD says otherwise.
- Material notes: Padauk baseline, alternate species require K update.
- Operation notes: no G-code; V-block or rotary indexing required for cylindrical tongue cuts.

## CAD Handoff

SolidWorks should create:

1. MasterLayout part with global variables from `cad/sw-global-variables.csv`.
2. Configuration table for handheld and medium variants.
3. Cylindrical unwrap sketch for the single-ring tongue layout.
4. Optional end-cap configurations: sealed, ported, drumhead.
5. Drawing sheets exported to PDF/SVG before CAM.

## Missing V5 Visual Gates

- Export checked DXF plates from native CAD or an Illustrator-reviewed vector
  master before marking the drawing set shop-ready.
- Replace review SVG previews with derived previews that name the governing
  CAD/DXF/design-table source.
- Add Blender/Photoshop/image-generation outputs only after logging their
  source artifacts and keeping them concept/support-only unless derived from
  fabrication authority.
