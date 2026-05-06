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
