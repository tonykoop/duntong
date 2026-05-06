# Duntong Original Cylindrical Tongue Drum Print Packet

Generated: 2026-05-05
Packet folder: `/mnt/c/Users/Tony/Documents/GitHub/duntong`

## File Map

| File | Purpose |
| --- | --- |
| `design.md` | Project intent, catalog metadata, assumptions, and validation plan. |
| `bom.csv` | Starter bill of materials with part categories, quantities, drawing refs, and notes. |
| `sourcing.csv` | Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks. |
| `cut-list.csv` | Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts. |
| `drawing-brief.md` | Manufacturing drawing and technical product sketch brief. |
| `assembly-manual.md` | Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes. |
| `validation.csv` | Target/measured values, tolerance, environment, result, and tuning/build action log. |
| `supplier-rfq.md` | Supplier email/request-for-quote starter. |
| `visual-bom-brief.md` | Art direction for an image-forward visual BOM. |
| `README.md` | Project artifact. |
| `family-spec.csv` | Project artifact. |
| `photo-shotlist.md` | Project artifact. |
| `risks.md` | Project artifact. |

<div class="page-break"></div>

## design.md

Project intent, catalog metadata, assumptions, and validation plan.

# Duntong Build Design

## Project Intent

The duntong is Tony Koop's original cylindrical tongue drum concept. It combines a dundun-like round body and optional drumhead/ported ends with wooden tongue drum voices cut directly into the shell wall.

The first build should answer three practical questions:

1. Can a cylindrical stave shell hold predictable cantilever tongue pitches?
2. Which end configuration gives the best musical balance: sealed, ported, or drumheaded?
3. Can the V1 be manufactured safely with Tony's available home-shop and Maker Nexus workflows before SolidWorks CAM exists?

Mode A repo shape is used here: this is a single-instrument repository, so files live at the repo root and in conventional folders.

## Design Intake

| Field | Value |
|---|---|
| Instrument ID | DNT-001 |
| Instrument type | Duntong |
| Family | Cylindrical tongue drum / drum-skin hybrid |
| Inventor | Tony Koop, 2026 |
| Workbook | `duntong-design-table.xlsx`, sheet `Duntong` |
| Reference workbook | `Musical Instruments V2.xlsx`, sheet `Duntong` |
| Done-bar reference | `tonykoop/tongue-drum` for tongue physics; `tonykoop/djembe`, `tonykoop/conga`, and `tonykoop/ashiko-drum-workshop` for segmented/stave construction |
| V1 recommendation | Medium stave cylinder, single-ring tongue layout, sealed or goatskin end option |
| Current scale baseline | C minor pentatonic from the workbook |
| Alternate scale request | D minor pentatonic remains TBD until the workbook row is updated |
| Primary material | Padauk in the workbook; cherry or maple alternate TBD |

Guided intake outputs are in `data/design-intake.json` and `data/design-input-row.csv`.

## Governing Model

### Tongues

The primary pitch model is a fixed-free cantilever beam:

```text
f = K * t / L^2
L = sqrt(K * t / f)
```

Where:

- `f` is tongue fundamental frequency in Hz.
- `K` is the material-specific imperial cantilever constant from the tongue-drum material library.
- `t` is the shell wall thickness in inches. This is also the tongue thickness.
- `L` is tongue length in inches.

For the workbook baseline, `K = 24438` for Padauk. The model assumes the tongue behaves like a flat cantilever. The workbook flags curvature as acceptable when tongue width divided by cylinder OD is less than or equal to 0.20. The handheld ratio is 1.0 / 6.0 = 0.167. The medium ratio is 1.5 / 12.0 = 0.125. Both are inside the first-pass range, but the curved shell may still raise pitch by about 2-5 percent and must be measured.

### Body And End Coupling

The cylinder body is secondary coupling, not the main pitch source. Four end conditions are preserved as design variants:

| Option | End condition | First-pass model | Musical character |
|---|---|---|---|
| A | Both ends solid | Helmholtz-like cavity using tongue slits as neck openings | Warm, focused sustain |
| B | One port, one solid | Stopped pipe approximation | Deeper bass projection |
| C | Two ports | Open pipe approximation | Brighter projection |
| D | One or both drumheads | Membrane plus cantilever hybrid | Closest to dundun inspiration |

Important guard rule: the NAF K2 bore correction does not apply to this instrument. Only cantilever beam K constants are used for tongue pitch. Helmholtz/stopped/open-pipe equations are exploration and validation targets for the body, not corrections to tongue length.

### Worked Medium Example

For the medium prototype:

```text
OD = 12.000 in
length = 16.000 in
wall/tongue thickness = 0.500 in
tongue width = 1.500 in
slit width = 0.125 in
K = 24438
root MIDI = 60 (C4)
```

The C4 tongue prediction is:

```text
L = sqrt(24438 * 0.5 / 261.63) = 6.834 in
```

The medium shell circumference is `pi * 12 = 37.699 in`, allowing about 23 tongue-width-plus-slit slots. The requested 8 tongues fit.

Using the workbook formula for sealed-body slit-area coupling:

```text
slit area = 8 * (0.125 * 1.5 + 2 * 0.125 * 3.0) = 7.5 in^2
internal volume = pi * (11 / 2)^2 * 16 = 1520.5 in^3
effective neck length = 0.5 in
f_H = 13552 / (2*pi) * sqrt(7.5 / (1520.5 * 0.5)) = about 214 Hz
```

The workbook prose note also mentions 135 Hz for medium sealed coupling. That appears to be a stale or alternate-geometry note; keep it visible as a validation question rather than treating either value as proven.

## Family / Variant Targets

| Variant | OD (in) | Length (in) | Wall (in) | Root | Tongues | Construction target |
|---|---:|---:|---:|---|---:|---|
| DNT-HANDHELD | 6.000 | 9.000 | 0.375 | C5 | 8 | Split-blank or stave prototype |
| DNT-MEDIUM | 12.000 | 16.000 | 0.500 | C4 | 8 | V1 stave cylinder |

Medium predicted tongue table:

| # | Note | MIDI | Target Hz | Predicted L (in) |
|---:|---|---:|---:|---:|
| 1 | C4 | 60 | 261.63 | 6.834 |
| 2 | Eb4 | 63 | 311.13 | 6.267 |
| 3 | F4 | 65 | 349.23 | 5.915 |
| 4 | G4 | 67 | 392.00 | 5.583 |
| 5 | Ab4 | 68 | 415.30 | 5.424 |
| 6 | Bb4 | 70 | 466.16 | 5.120 |
| 7 | C5 | 72 | 523.25 | 4.832 |
| 8 | Eb5 | 75 | 622.25 | 4.431 |

## Hardware Alignment

The V1 build is a stave-cylinder shell with CNC-cut tongue slits. The CNC plan is pre-CAM only; feeds, speeds, hold-down, and simulation must be set at the actual machine.

| Operation | Tooling | Fixture / datum | Notes |
|---|---|---|---|
| Rip staves | Table saw, miter sled | Long edge datum, 15 deg miter for 12 staves | Cut extra staves for tuning and destructive tests |
| Thickness staves | Planer / drum sander | Outside face A | Tongue pitch depends directly on final wall thickness |
| Glue cylinder | Band clamps or hose clamps | Shell axis datum A | Glue in two half-shells, then join halves |
| True shell | Lathe | Shell axis between centers/chuck | Final wall is tuning-critical |
| End cap or drumhead prep | Lathe, band saw, drill press | End plane datum B/C | Preserve sealed, ported, and drumhead variants |
| Tongue layout | 1:1 wrap template or SolidWorks unwrap | Shell axis A, equator plane D, index zero E | Single ring around equator for V1 |
| Tongue cuts | CNC router, 1/8 in upcut spiral | V-block cradle, rotary indexing, shell axis A | Start tongues about 5 percent long/flat for tuning trim |
| Tuning | Files, Dremel, tuner | Tongue root and tip marks | Shorten tip to raise pitch; thin near base to lower pitch |

## SolidWorks MasterLayout Plan

Do not fake SolidWorks files. This repo includes a real handoff:

- `cad/SolidWorks-MasterLayout-Plan.md`
- `cad/design-table-inputs.csv`
- `cad/sw-global-variables.csv`

The MasterLayout should own shell OD/ID/length, wall thickness, stave count, miter angle, tongue count, tongue lengths, slit width, tongue band position, end cap variant, port diameter, trim allowance, and registration datums. It should also include an unwrap or wrap-template drawing for V1 CNC layout.

## Open Assumptions

| Assumption | Status | Test |
|---|---|---|
| Padauk K = 24438 applies to curved shell tongues | First-order only | Measure struck pitch before and after slit tuning |
| Curvature ratio below 0.20 keeps flat-beam formula usable | First-order only | Compare predicted vs measured cents error on all eight tongues |
| Medium sealed-body coupling is near 214 Hz by current formula | Formula result | Verify against Excel cached value and measured cavity tap/impulse response |
| Workbook prose note of 135 Hz body resonance is stale or alternate geometry | TBD | Recalculate in Excel and Wolfram after dimensions are frozen |
| Single-ring layout is playable by one or two players | TBD | Mock hand reach on a 12 in diameter cylinder before CNC |
| Goatskin end option is the "true duntong" expression | Design intent | Build sealed, ported, and goatskin variants for comparison |

## Validation Plan

1. Build a scrap tongue coupon at the same wall thickness and grain orientation.
2. Cut one reference C4 tongue 5 percent long and tune upward to target.
3. Record before/after frequency, humidity, temperature, and material thickness.
4. Build the medium shell and cut the eight tongues from longest to shortest.
5. Measure every tongue after rough cut, after tuning, and after finish.
6. Test sealed, one-port, and goatskin end configurations with the same tongue set where practical.
7. Update `validation.csv` and feed measured data back through the empirical-learning loop once a prototype exists.

<div class="page-break"></div>

## bom.csv

Starter bill of materials with part categories, quantities, drawing refs, and notes.

| item_id | category | part_name | qty | unit | material_spec | dimensions | make_buy | source_or_supplier | search_terms | date_checked | unit_cost_usd | total_cost_usd | substitute_rule | drawing_ref | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| B-001 | Body | Padauk staves | 12 | each | Padauk or alternate hardwood | 16 in x 3.1 in x 1.0 in rough | make | lumber supplier | padauk 4/4 or 5/4 lumber blank |  |  |  | Cherry or hard maple acceptable if K is updated | drawings/body-overview.svg | V1 medium stave shell |
| B-002 | Body | End cap blanks | 2 | each | Padauk or matching hardwood | 13 in x 13 in x 0.75 in | make | lumber supplier | padauk panel blank 13 inch square |  |  |  | Use drumhead hardware instead for Config D | drawings/end-config-options.svg | Sealed configuration baseline |
| B-003 | Body | Acoustic port tube | 1 | each | Wood or PVC | 3 in OD x 1 in length | make/buy | hardware supplier | 3 inch wood tube pvc pipe offcut |  |  |  | Only needed for ported variant | drawings/end-config-options.svg | Ported option |
| B-004 | Head | Goatskin rawhide | 1 | each | Goatskin or calfskin | 16 in or larger round | buy | drum parts supplier | goatskin drum head 16 inch rawhide |  |  |  | Synthetic head is alternate | drawings/end-config-options.svg | Optional true duntong end |
| B-005 | Head | Rope tuning kit | 1 | set | Low-stretch polyester or drum rope | TBD | buy | drum parts supplier | djembe rope tuning ring 12 inch |  |  |  | Only needed for goatskin variant | drawings/end-config-options.svg | Includes rings/pullers TBD |
| B-006 | CNC | 1/8 in upcut spiral bit | 1 | each | Carbide router bit | 0.125 in cutting diameter | buy | CNC tooling supplier | 1/8 upcut spiral router bit carbide |  |  |  | Must match CNC collet | drawings/tongue-layout.svg | Tongue slit cutter |
| B-007 | Fixture | V-block cradle | 1 | each | MDF or plywood fixture stock | for 12 in OD cylinder | make | shop stock | MDF plywood V block CNC cradle |  |  |  | Must include clamps and index marks | cnc/setup-sheet.md | Holds shell during tongue cutting |
| B-008 | Hardware | Rubber feet or cradle stand | 4 | each | Rubber bumper or hardwood cradle | TBD | buy/make | hardware supplier | rubber feet bumper instrument stand |  |  |  | Cradle preferred if cylinder wants to roll | drawings/body-overview.svg | Support for playing |
| B-009 | Consumable | Wood glue | 1 | bottle | Titebond III or equivalent | TBD | buy | hardware supplier | water resistant wood glue |  |  |  | Glue choice affects open time | assembly-manual.md | Stave shell glue-up |
| B-010 | Consumable | Finish and abrasives | 1 | set | Tung oil or lacquer plus 80-400 grit | TBD | buy | hardware supplier | tung oil instrument finish lacquer |  |  |  | Avoid heavy finish on active tongues | assembly-manual.md | Final finishing |

<div class="page-break"></div>

## sourcing.csv

Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks.

| source_id | item_id | component | specification | required_match | supplier_candidate | search_terms | url | date_checked | unit_price_usd | minimum_order | lead_time | substitution_risk | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S-001 | B-001 | Padauk stave stock | Stable straight-grained hardwood, enough for 12 staves plus spares | species and grain direction | lumber supplier | padauk lumber 4/4 5/4 straight grain |  |  |  |  | Medium | If cherry/maple is used, update K constant and validation rows |  |
| S-002 | B-002 | End cap blanks | 13 in square hardwood panels, 0.75 in thick | dimensions | lumber supplier | padauk panel blank 13x13 3/4 |  |  |  |  | Low | Can be face-glued from narrower boards |  |
| S-003 | B-003 | Port tube | 3 in diameter tube, about 1 in neck length | diameter if ported | hardware supplier | 3 inch pvc pipe wood tube |  |  |  |  | Medium | Port material may affect finish look but not primary tongue tuning |  |
| S-004 | B-004 | Goatskin rawhide | 16 in or larger round skin for 12 in shell | size and condition | drum parts supplier | 16 inch goatskin rawhide drum head |  |  |  |  | Medium | Must be checked live before purchase |  |
| S-005 | B-005 | Rope tuning hardware | Rope, rings, pullers sized for 12 in shell | fit | drum parts supplier | djembe rope tuning ring 12 inch |  |  |  |  | High | Hardware geometry must be frozen before drilling or rim detailing |  |
| S-006 | B-006 | 1/8 in upcut bit | Carbide spiral bit, 0.125 in kerf, suitable stickout | diameter and shank | CNC tooling supplier | 1/8 inch carbide upcut spiral router bit |  |  |  |  | Medium | Bit deflection will affect slit width and tuning |  |
| S-007 | B-007 | V-block fixture stock | Flat MDF/plywood, clamps, registration/index hardware | fixture rigidity | shop stock | MDF CNC fixture V block clamps |  |  |  |  | Low | Make in shop from scrap if stock is flat |  |
| S-008 | B-008 | Rubber feet or cradle stand | Non-marring feet or hardwood support cradle | stability | hardware supplier | rubber feet instrument bumper cradle |  |  |  |  | Low | Cradle is safer for rolling cylinder |  |
| S-009 | B-009 | Wood glue | Water-resistant wood glue with enough open time | bond quality | hardware supplier | Titebond III wood glue |  |  |  |  | Low | Glue-line stability matters because tongues are cut across the shell |  |
| S-010 | B-010 | Finish system | Low-build oil or lacquer, compatible with struck wood | finish behavior | hardware supplier | tung oil instrument finish lacquer |  |  |  |  | Medium | Finish must be tested on scrap tongue coupon |  |

<div class="page-break"></div>

## cut-list.csv

Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts.

| cut_id | part_name | variant | qty | rough_dimensions_in | finished_dimensions_in | material | grain_orientation | operation | yield_or_offcut_plan | drawing_ref | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| C-001 | Stave blanks | DNT-MEDIUM | 12 | 16.50 x 3.25 x 1.10 | 16.00 x 3.142 x 1.00 | Padauk | grain along cylinder length | rip mitered staves | cut 2 spare staves for tuning coupons | drawings/body-overview.svg | 15 deg miter for 12 staves |
| C-002 | End cap blanks | DNT-MEDIUM | 2 | 13.25 x 13.25 x 0.80 | disc to fit 11 in ID rabbet | Padauk or matching hardwood | stable face grain | cut/turn end caps | offcuts become port and tuning test coupons | drawings/end-config-options.svg | Skip or modify for drumhead option |
| C-003 | V-block cradle | DNT-MEDIUM | 1 | 20 x 16 x 0.75 panels | 12 in OD support cradle | MDF or plywood | n/a | CNC or table saw fixture | save fixture for future variants | cnc/setup-sheet.md | Include index marks every 45 deg |
| C-004 | Tongue wrap template | DNT-MEDIUM | 1 | sheet size TBD | 1:1 wrap, 37.699 in circumference x 16 in length | paper or laser-safe sheet | n/a | print/laser template | n/a | drawings/tongue-layout.svg | SolidWorks unwrap should replace this after CAD |
| C-005 | Port tube | DNT-MEDIUM | 1 | 3.25 OD x 1.25 | 3.00 OD x 1.00 | wood or PVC | n/a | trim and fit | only for ported variant | drawings/end-config-options.svg | Actual neck length must be measured |
| C-006 | Scrap tongue coupons | DNT-MEDIUM | 3 | 8.0 x 2.0 x 0.5 | varies by test | same stock as shell | grain along tongue length | CNC test slits | destructive tests allowed | validation.csv | Use before cutting shell |
| C-007 | Handheld body blank | DNT-HANDHELD | 1 | 10 x 7 x 7 | 6 OD x 9 length x 0.375 wall | Padauk/cherry/maple TBD | grain along tongue length | split-blank or stave build | TBD for later prototype | drawings/body-overview.svg | Not V1 unless Tony selects handheld first |

<div class="page-break"></div>

## drawing-brief.md

Manufacturing drawing and technical product sketch brief.

# Drawing Brief

## Drawing Set

The current SVG drawing set is review-grade and should be replaced or extended by SolidWorks drawings before cutting expensive stock.

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

<div class="page-break"></div>

## assembly-manual.md

Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes.

# Duntong Assembly Manual

## Scope

This manual covers the DNT-MEDIUM V1 stave-cylinder prototype. It is not a CAM file and does not replace machine setup, feeds/speeds, or a SolidWorks drawing review.

## Tools

- Table saw with accurate miter sled.
- Jointer, planer, or drum sander.
- Band clamps or hose clamps for round glue-up.
- Wood lathe large enough for a 12 in OD shell.
- Drill press or lathe setup for port/end work.
- CNC router with 1/8 in upcut spiral bit, or hand-cut slit fallback.
- Calipers, flexible tape, tuner, microphone/recorder, hygrometer.
- Files, Dremel, sanding blocks, 80-400 grit abrasives.

## Phase 1 - Stock Prep

1. Confirm final V1 variant: sealed, ported, or drumheaded.
2. Select straight-grained Padauk or alternate hardwood. Record species, moisture content if available, and board orientation.
3. Rip at least 12 stave blanks plus 2 spares.
4. Cut 15 deg miters for a 12-stave cylinder.
5. Plane or sand all staves to a controlled thickness. Final shell wall is the tongue thickness, so record actual thickness at both ends of each stave.
6. Use one spare stave to cut scrap tongue coupons before cutting the real shell.

## Phase 2 - Shell Glue-Up

1. Dry-fit the 12 staves into a cylinder.
2. Glue as two half-shells if that improves clamping control.
3. Join half-shells into the full cylinder with band clamps.
4. Check roundness with calipers before the glue sets.
5. Let the shell cure fully before lathe work.

## Phase 3 - Turning And End Prep

1. Mount the shell on the lathe with support appropriate to the current blank.
2. True the outside to 12.000 in OD.
3. Bore or turn the inside to 11.000 in ID, leaving a 0.500 in wall.
4. Add end rabbets if sealed caps will be used.
5. For a ported cap, drill or turn the port after the cap is stable.
6. For a drumheaded end, leave enough rim/bearing-edge stock and do not drill hardware until the hardware package is selected.

## Phase 4 - Tongue Layout

1. Use `drawings/tongue-layout.svg` and the SolidWorks unwrap handoff as the layout basis.
2. Mark shell axis datum A, end planes B/C, equator plane D, and index zero E.
3. Print or laser a 1:1 wrap template once CAD is verified.
4. Place all eight tongues in a single ring around the equator for V1.
5. Start each tongue about 5 percent long so it tunes flat and can be shortened upward.

## Phase 5 - Tongue Cutting

1. Test the exact 1/8 in bit and slit depth on a scrap coupon.
2. Mount the shell in the V-block cradle.
3. Clamp so the final operation cannot release the shell.
4. Cut one tongue at a time.
5. Rotate the shell to the next index mark and re-check datum alignment.
6. Leave tabs or bridges only in non-vibrating areas if the CNC strategy requires them.
7. Deburr slits lightly without changing active tongue length.

## Phase 6 - Tuning

1. Measure every rough-cut tongue before trimming.
2. Tune from bass to treble.
3. To raise pitch, shorten at the tongue tip.
4. To lower pitch, thin near the tongue root with caution.
5. Record before/after Hz, temperature, humidity, and strike tool in `validation.csv`.
6. Stop when every note is within +/- 5 cents or when the remaining correction would risk structural damage.

## Phase 7 - End Configuration Tests

1. Test the sealed body first if solid caps are installed.
2. Test one-port response if the port cap is available.
3. Test the goatskin or synthetic head option only after the bearing edge and hardware are confirmed.
4. Record sustain, loudness, body resonance, and player feel for each configuration.

## Phase 8 - Finish And Support

1. Sand 80, 120, 180, 220, 320, and 400 grit as needed.
2. Avoid heavy finish on active tongue surfaces.
3. Apply 2-3 light coats of the selected finish on scrap first.
4. Add rubber feet or a cradle stand so the cylinder cannot roll during play.
5. Take process and finished photos listed in `photo-shotlist.md`.

## Maintenance

- Store away from extreme humidity swings.
- Re-check tuning after finish cure and after the first week of playing.
- If a tongue cracks, preserve the piece and log the failure mode before repair.

<div class="page-break"></div>

## validation.csv

Target/measured values, tolerance, environment, result, and tuning/build action log.

| measurement_id | variant | note | midi | target_hz | predicted_length_in | measured_hz | cents_error | tolerance_cents | environment | result | action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| V-001 | DNT-MEDIUM | C4 | 60 | 261.63 | 6.834 |  |  | 5 | TBD | pending | Measure scrap C4 tongue before shell cut |
| V-002 | DNT-MEDIUM | Eb4 | 63 | 311.13 | 6.267 |  |  | 5 | TBD | pending | Measure after rough cut and after tuning |
| V-003 | DNT-MEDIUM | F4 | 65 | 349.23 | 5.915 |  |  | 5 | TBD | pending | Measure after rough cut and after tuning |
| V-004 | DNT-MEDIUM | G4 | 67 | 392.00 | 5.583 |  |  | 5 | TBD | pending | Measure after rough cut and after tuning |
| V-005 | DNT-MEDIUM | Ab4 | 68 | 415.30 | 5.424 |  |  | 5 | TBD | pending | Measure after rough cut and after tuning |
| V-006 | DNT-MEDIUM | Bb4 | 70 | 466.16 | 5.120 |  |  | 5 | TBD | pending | Measure after rough cut and after tuning |
| V-007 | DNT-MEDIUM | C5 | 72 | 523.25 | 4.832 |  |  | 5 | TBD | pending | Measure after rough cut and after tuning |
| V-008 | DNT-MEDIUM | Eb5 | 75 | 622.25 | 4.431 |  |  | 5 | TBD | pending | Measure after rough cut and after tuning |
| V-009 | DNT-MEDIUM | sealed-body-formula |  | 214.23 |  |  |  | 20 | TBD | pending | Verify against Excel and impulse response |
| V-010 | DNT-MEDIUM | stopped-pipe-one-port |  | 211.75 |  |  |  | 20 | TBD | pending | Test one-port body response if Config B is built |
| V-011 | DNT-MEDIUM | open-pipe-two-port |  | 423.50 |  |  |  | 20 | TBD | pending | Test two-port body response if Config C is built |
| V-012 | DNT-MEDIUM | drumhead-body-response |  |  |  |  |  | 20 | TBD | pending | Record membrane tuning and coupled tone if Config D is built |

<div class="page-break"></div>

## supplier-rfq.md

Supplier email/request-for-quote starter.

# Supplier RFQ - Duntong Prototype Materials And Optional Hardware

Hello,

I am building a first prototype of an original wooden musical instrument called the duntong: a 12 in OD x 16 in long cylindrical tongue drum with optional sealed, ported, or drumhead ends.

Please quote the items below, including unit price, quantity price if available, lead time, shipping estimate, and any substitutions you recommend.

## Hardwood Stock

- Species: Padauk preferred; cherry or hard maple acceptable as alternate.
- Use: 12-stave cylindrical shell with tuned cantilever tongues.
- Rough need: 12 staves plus 2 spares, each about 16.5 in x 3.25 in x 1.10 in before surfacing.
- Grain: straight grain along the 16 in length.
- Requirements: stable, dry stock suitable for musical instrument work.

## Optional End Cap Stock

- Species: same as shell or visually compatible hardwood.
- Quantity: 2 blanks.
- Rough size: 13.25 in x 13.25 in x 0.80 in.
- Use: sealed or ported end caps.

## Optional Drumhead Hardware

- Shell OD: 12 in.
- Desired head type: goatskin/rawhide first choice; synthetic head acceptable as alternate.
- Please quote skin/head, rings/hoop, rope or hardware, and any recommended mounting parts.
- Use case: experimental hybrid dundun/tongue drum, hand-struck.

## CNC Tooling

- 1/8 in carbide upcut spiral router bit.
- Must be suitable for clean hardwood slit cutting.
- Please include shank diameter, flute length, recommended RPM/feed guidance if available.

## Substitution Rules

Do not substitute wood species without naming the species, density/modulus if known, and expected acoustic risk. Tongue pitch predictions depend on material stiffness-to-density ratio.

Thank you,

Tony Koop

<div class="page-break"></div>

## visual-bom-brief.md

Art direction for an image-forward visual BOM.

# Visual BOM Brief

## Purpose

Create a one-page visual BOM for the DNT-MEDIUM duntong prototype in the style of Tony's Ashiko BOM reference: strong header, instrument image or drawing, itemized table, and concrete part visuals.

## Header

- Title: Duntong Original Cylindrical Tongue Drum - Medium Prototype
- Quote date: TBD when live sourcing is checked
- Estimated cost: TBD
- Assembly: DNT-MEDIUM stave-cylinder prototype

## Image Strategy

No built duntong photos exist yet. Use these placeholders honestly:

| Slot | Current asset | Replacement needed |
|---|---|---|
| Hero | `drawings/body-overview.svg` | Finished prototype photo |
| Tongue layout | `drawings/tongue-layout.svg` | CNC setup/process photo |
| End options | `drawings/end-config-options.svg` | Sealed, ported, and drumhead end photos |
| Fixture | `drawings/section-view.svg` | V-block cradle shop photo |

## BOM Rows

Show these grouped parts:

- Body: Padauk staves, end caps, optional port tube.
- Head option: goatskin/rawhide, rope/rings or synthetic hardware.
- CNC and fixtures: 1/8 in upcut bit, V-block cradle, wrap template.
- Support: rubber feet or cradle stand.
- Consumables: glue, abrasives, finish.

## Notes For Designer

- Label all generated drawings as engineering placeholders until replaced by real photos.
- Do not show live prices until `sourcing.csv` has date-checked supplier data.
- Include a footnote: "Original instrument concept by Tony Koop; first prototype measurements forthcoming."

<div class="page-break"></div>

## README.md

Project artifact.

# Duntong - Original Cylindrical Tongue Drum

> Tony Koop's original hybrid instrument concept: a dundun-inspired cylindrical drum body with tuned wooden tongue-drum voices cut around the shell.

## What This Is

The duntong is an original instrument design by Tony Koop. It combines the social, cylindrical playing form of a hand drum with the melodic tuning logic of a wooden tongue drum. Instead of cutting tongues into a flat box lid, the duntong places cantilever tongues around a round shell so the instrument can be played from multiple sides.

The current design table defines two prototype sizes:

1. **Handheld:** 6 in OD x 9 in long, C5-root pentatonic minor, 0.375 in tongue wall.
2. **Medium:** 12 in OD x 16 in long, C4-root pentatonic minor, 0.5 in tongue wall.

The V1 build target is the medium stave-cylinder prototype with a single ring of eight tongues around the equator. The workbook also preserves sealed, ported, and drumhead end variants so the instrument can be tested as a melodic tongue drum, a resonant ported body, and a true dundun/tongue hybrid.

## Why It Is Interesting

Most wooden tongue drums are rectangular boxes. Most dunduns are membrane drums. The duntong asks a neat acoustics question: can a round wooden drum body carry tuned cantilever tongues while still behaving like a hand-drum shell?

The current model treats the tongues as fixed-free cantilever beams:

```text
f = K * t / L^2
```

The cylinder cavity is treated as secondary coupling, not as the main pitch source. The first prototype should measure how much the curved wall, stave glue lines, end condition, and cavity resonance shift the tongue predictions.

## Repository Map

```text
duntong/
├── README.md
├── design.md
├── duntong-design-table.xlsx
├── family-spec.csv
├── bom.csv
├── sourcing.csv
├── cut-list.csv
├── validation.csv
├── assembly-manual.md
├── supplier-rfq.md
├── visual-bom-brief.md
├── drawing-brief.md
├── risks.md
├── photo-shotlist.md
├── cad/
├── cnc/
├── data/
├── drawings/
├── images/
├── site/
└── wolfram/
```

## Current Status

| Area | Status |
|---|---|
| Original concept and workbook | Done |
| Guided v4.2 intake | Done |
| Build packet docs | Drafted for V1 review |
| Drawings | SVG review drawings included |
| CNC/CAM | Pre-CAM operation plan only; no G-code |
| SolidWorks | MasterLayout handoff files included; no fake CAD |
| Wolfram | Readable `.wl` source included |
| Prototype data | Forthcoming |

## Sister Repos

- [tongue-drum](https://github.com/tonykoop/tongue-drum) for cantilever tongue physics and the DoE tuning pattern.
- [dundun](https://github.com/tonykoop/dundun) for the drum-family inspiration.
- [djembe](https://github.com/tonykoop/djembe) and [ashiko-drum-workshop](https://github.com/tonykoop/ashiko-drum-workshop) for segmented/stave drum construction references.

## License

[CC BY 4.0](LICENSE) - see LICENSE for details.

<div class="page-break"></div>

## family-spec.csv

Project artifact.

| member_id | target_hz | target_note | scale_label | predicted_length_in | predicted_width_in | predicted_height_in | predicted_volume_cuin | wood_species | k_constant | k2_correction | outer_diameter_in | inner_diameter_in | wall_thickness_in | tongue_count | slit_width_in | construction_method | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DNT-HANDHELD | 523.25 | C5 | C minor pentatonic | 9.000 | 6.000 | 6.000 | 194.83 | Padauk | 24438 | 0 | 6.000 | 5.250 | 0.375 | 8 | 0.125 | split-blank or stave | Handheld proof of concept; workbook root MIDI 72 |
| DNT-MEDIUM | 261.63 | C4 | C minor pentatonic | 16.000 | 12.000 | 12.000 | 1520.53 | Padauk | 24438 | 0 | 12.000 | 11.000 | 0.500 | 8 | 0.125 | stave cylinder | V1 build target; medium floor/table instrument |

<div class="page-break"></div>

## photo-shotlist.md

Project artifact.

# Photo Shotlist

This follows `instrument-maker/docs/photo-pipeline.md`. No owned duntong hero photo exists yet, so the README and site should say photos forthcoming rather than link broken images.

## File Naming

Use:

```text
images/00-hero-duntong-medium-finished.jpg
images/01-workbook-design-table.jpg
images/02-stave-stock-layout.jpg
images/03-stave-glue-up.jpg
images/04-turned-cylinder-shell.jpg
images/05-wrap-template-on-shell.jpg
images/06-vblock-cnc-setup.jpg
images/07-tongue-slit-cutting.jpg
images/08-tuning-with-tuner.jpg
images/09-end-config-comparison.jpg
images/10-finished-detail.jpg
```

## Required Shots

| Shot | Purpose | Status |
|---|---|---|
| Hero finished instrument | README/site hero | Forthcoming |
| Workbook/source table | Shows parametric design source | Forthcoming |
| Stave stock | Documents grain and material | Forthcoming |
| Stave glue-up | Shows cylindrical shell construction | Forthcoming |
| Lathe turning | Shows wall thickness control | Forthcoming |
| Wrap template | Shows cylindrical tongue layout | Forthcoming |
| V-block CNC setup | Shows safe workholding | Forthcoming |
| Tongue cutting | Shows slit operation | Forthcoming |
| Tuning | Shows validation method | Forthcoming |
| End variants | Sealed/ported/drumheaded comparison | Forthcoming |

## Rules

- Use owned photos when available.
- If generated concept images are added, label them as generated placeholders.
- Replace generated or drawing placeholders with process photos after the first prototype.
- Do not use absolute local paths in README or `site/index.html`.

<div class="page-break"></div>

## risks.md

Project artifact.

# Duntong Risks

## Acoustic

### Acoustic Tongues ring sharp from curvature

**Symptom:** The rough-cut tongues measure consistently sharp compared with the flat cantilever prediction.

**Mechanism:** The shell is curved, not flat. Even with a width/OD ratio below 0.20, curvature and stave glue lines may stiffen the tongue relative to the workbook model.

**Test:** Cut a scrap coupon and one shell test tongue 5 percent long. Record predicted vs measured Hz before final shell cutting.

**Mitigation:** Add a measured curvature correction to the design table, leave more tuning allowance, or lower the starting root for V1.

**Severity:** Medium.

## Structural

### Structural Stave glue lines weaken active tongue zones

**Symptom:** A tongue cracks, buzzes, or loses sustain along a glue line after cutting or playing.

**Mechanism:** Stave construction creates glue lines around the circumference. If a tongue crosses or terminates near a glue line, the local boundary condition may be weak or damped.

**Test:** Align the wrap template against stave seams before cutting. Strike-test a tongue coupon that includes a glue line.

**Mitigation:** Place tongue centerlines between stave seams, widen non-vibrating bridges, or switch the V1 to split-blank construction for the handheld proof.

**Severity:** High; human decision required before cutting if the final tongue layout crosses seams.

## Ergonomic

### Ergonomic Cylinder rolls or forces awkward wrist angle

**Symptom:** Player has to stabilize the instrument instead of playing, or wrist extension becomes uncomfortable on the far-side tongues.

**Mechanism:** A 12 in round shell on a table can roll unless supported. A full 360-degree note layout may invite reaches around the cylinder.

**Test:** Mock the 12 in OD shell with a tube or cardboard form. Mark eight note positions and test seated/table/floor playing positions.

**Mitigation:** Add rubber feet, a cradle stand, or rotate the note order to keep common patterns near the player.

**Severity:** Medium.

## Supply

### Supply Tonewood substitution changes K constant

**Symptom:** Tongues cut to Padauk lengths do not tune correctly when cherry, maple, or another hardwood is substituted.

**Mechanism:** The cantilever formula depends on the material K constant. Species changes alter stiffness-to-density ratio.

**Test:** Before substituting, update `K` in the workbook and cut a coupon from the actual stock.

**Mitigation:** Keep Padauk for V1 or make species substitution an explicit DoE factor with separate validation rows.

**Severity:** Medium.

## Fit/Finish

### Fit/Finish Finish buildup damps tongues

**Symptom:** Tuned tongues lose sustain or shift pitch after finishing.

**Mechanism:** Oil, lacquer, or film finish adds mass and damping to the active tongue surface and slit walls.

**Test:** Finish a tuned coupon with the planned schedule and measure before/after Hz, sustain, and cents error.

**Mitigation:** Use a low-build finish, mask active tongue surfaces, or tune after the finish has cured.

**Severity:** Medium.
