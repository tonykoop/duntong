# CNC / Manufacturing Setup Sheet

- Packet: `.`
- Family: duntong-hybrid
- Generated: 2026-05-06
- Machine note: Pre-CAM plan for a stave-shell cylindrical tongue drum. Verify actual CNC router, lathe swing, clamps, feed/speed, bit stickout, and air-cut before machining.

## Assumptions

- This is not G-code.
- V1 target is the medium 12 in OD x 16 in long stave-cylinder prototype.
- Tongue pitches depend on final wall thickness, so stock prep and turning checks are tuning-critical.
- The CNC tongue operation needs either a rigid V-block with rotary indexing or a true rotary axis.

## Operation Graph

### OP-010 - Review workbook, drawings, and datums

- Machine: Bench
- Tool: Calipers, flexible tape, square, marker
- Workholding: Flat bench
- Datum: Shell axis A, left end B, right end C, equator D, index zero E
- Inputs: `design.md`, `drawing-brief.md`, `family-spec.csv`
- Outputs: marked datum checklist
- Checks:
  - C minor vs D minor decision visible
  - End configuration selected or marked TBD
  - No CAM until SolidWorks unwrap is reviewed
- Notes: Preserve all TBDs instead of burying them in CAM assumptions.

### OP-110 - Cut and thickness stave blanks

- Machine: Table saw, jointer, planer, drum sander
- Tool: Sharp rip/crosscut blade, planer knives, calipers
- Workholding: Miter sled, featherboard, push blocks
- Datum: Outside face and long edge of each stave
- Inputs: `cut-list.csv`, `bom.csv`
- Outputs: 12 staves plus spare coupons
- Checks:
  - 15 deg miter verified on scrap
  - Thickness recorded for every stave
  - Straight grain along shell length
- Notes: Cut extra stock for destructive tongue and finish tests.

### OP-210 - Glue stave cylinder

- Machine: Bench
- Tool: Band clamps, hose clamps, cauls, glue brush
- Workholding: Round clamp-up with two-half-shell option
- Datum: Shell axis A established by roundness checks
- Inputs: `assembly-manual.md`
- Outputs: cured cylindrical shell blank
- Checks:
  - Glue gaps inspected
  - Roundness checked before cure
  - Seam positions logged for tongue layout
- Notes: Tongue roots should avoid weak seam locations where possible.

### OP-310 - Turn shell to OD, ID, and wall thickness

- Machine: Wood lathe
- Tool: Bowl gouge, scraper, calipers, wall-thickness gauge
- Workholding: Chuck/faceplate with tailstock support as appropriate
- Datum: Shell axis A
- Inputs: `drawings/section-view.svg`
- Outputs: 12 in OD, 11 in ID, 0.5 in wall shell
- Checks:
  - Wall thickness within tuning tolerance
  - Ends square to axis
  - No thin spots below 0.5 in before tongue cuts
- Notes: Final wall is the tongue thickness in `f = K*t/L^2`.

### OP-410 - Prepare end configuration

- Machine: Lathe, drill press, band saw, bench
- Tool: Forstner bits, hole saw, turning tools, sanding blocks
- Workholding: End-cap fixture or rim support
- Datum: End planes B and C
- Inputs: `drawings/end-config-options.svg`, `bom.csv`
- Outputs: sealed caps, ported cap, or drumhead-ready rim
- Checks:
  - Port diameter and neck length measured if ported
  - Bearing edge smooth if drumheaded
  - Cap fit tested before glue
- Notes: Do not drill hardware for drumhead until the actual hardware is sourced.

### OP-510 - Create wrap template and index plan

- Machine: Laser cutter, printer, or SolidWorks drawing export
- Tool: Paper template, laser-safe sheet, marking knife
- Workholding: Template taped to shell with index zero
- Datum: Equator plane D and index zero E
- Inputs: `drawings/tongue-layout.svg`, `cad/design-table-inputs.csv`
- Outputs: 1:1 tongue wrap template
- Checks:
  - Circumference is 37.699 in for medium
  - Eight index steps at 45 deg
  - Tongue lengths include tuning trim allowance
- Notes: SolidWorks unwrap should replace the temporary SVG-derived template.

### OP-610 - CNC cut tongue slits

- Machine: CNC router
- Tool: 1/8 in upcut spiral bit
- Workholding: Rigid V-block cradle, clamps clear of toolpath, rotary index marks
- Datum: Shell axis A, equator D, index zero E
- Inputs: `cad/SolidWorks-MasterLayout-Plan.md`, `drawings/tongue-layout.svg`
- Outputs: rough-cut eight-tongue shell
- Checks:
  - Air-cut complete
  - Bit deflection checked on coupon
  - Shell cannot rotate/slip during final cut
  - No tongue crosses a weak seam without approval
- Notes: Cut one tongue, re-index, re-clamp, and verify before the next cut unless a true rotary axis is used.

### OP-710 - Tune tongues and validate body coupling

- Machine: Bench
- Tool: Chromatic tuner, microphone, file, Dremel, sanding block
- Workholding: Padded cradle or stand
- Datum: Tongue root and tip marks
- Inputs: `validation.csv`
- Outputs: updated validation.csv, measured tuning notes
- Checks:
  - Every tongue has measured Hz
  - Cents error computed
  - End configuration response logged
  - Finish shift measured after cure
- Notes: Shorten tongue tip to raise pitch. Thin near root only with caution.

## Release Checks

- [ ] Every operation has a datum and workholding method.
- [ ] CNC operations have a fixture and clamp plan.
- [ ] All tuning-critical dimensions include measurement checkpoints.
- [ ] No file claims to be verified CAM or G-code.
- [ ] `validation.csv` is updated after prototype measurements.
