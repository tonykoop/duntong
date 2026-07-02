# Design Intent — duntong rev A

- Master CAD: `cad/duntong_master.scad` (sha256: 723e69e6e639454bb9617963085709aae8129c8bf647d1cce9ca808ccdad349c), driven by `duntong-design-table.xlsx` (sha256: f86e424c1b98947c1ae340889d75ffa5f2e7d94e46fb72afa1dfbccc727afe02)
- Function: A cylindrical stave-shell drum body that carries tuned cantilever wooden tongues cut around its wall (V1 target: medium size, 12 in OD x 16 in long, single ring of eight tongues, C4-root pentatonic minor, sealed end baseline). The tongues are the primary pitch source (fixed-free cantilever, `f = K * t / L^2`, Padauk `K = 24438`); the cylinder cavity and end condition (sealed / one-port / two-port / drumhead) are secondary coupling under test. Handheld variant (6 in OD x 9 in long, C5-root) is preserved as a parametric alternate.
- Environment: hand-played percussion/melodic instrument; struck tongues carry cyclic fatigue load at stave glue lines; solid-wood shell and tongues move with humidity; optional goatskin head carries static rope-tension load.
- Target qty: 1 (prototype). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Shell OD (medium) | 12.000 in | scrap-coupon Hz check before shell cut | sets cavity coupling + tongue width/OD curvature ratio | design-table-inputs.csv row DNT-MEDIUM-SEALED |
| Wall thickness (= tongue thickness, medium) | 0.500 in | ±5% cents error tolerance (validation.csv) | directly sets tongue frequency via `f = K*t/L^2` | design-table-inputs.csv / validation.csv tolerance_cents=5 |
| Tongue length per note (medium, e.g. C4) | 6.834 in (predicted) | measured vs. target Hz, 5 cents tolerance | intonation | validation.csv V-001, cantilever formula |
| Tongue width | 1.500 in (medium) / 1.000 in (handheld) | width/OD ≤ 0.20 (curvature validity limit) | keeps flat-cantilever model valid; curved shell may still shift pitch 2-5% (measurement-required) | design.md Governing Model |
| Stave count / miter angle | 12 staves, 15.000 deg miter | glue-line placement vs. tongue centerlines | tongue must not cross a glue line (risks.md, High severity) | cad/design-table-inputs.csv |
| Root note (medium) | MIDI 60 (C4) | design-table row change required to alter | sets whole pentatonic layout | design-table-inputs.csv root_midi |
| Body cavity response (sealed, medium) | 214.23 Hz (first-pass) | ±20 cents tolerance, verify vs. Excel + impulse response | secondary coupling could shift measured tongue Hz | validation.csv V-009 |
| Port diameter (ported variant) | 3.000 in | measurement-required if Config B/C built | stopped/open-pipe body tuning | design-table-inputs.csv port_diameter_in |

## Incidental (free for DFM)

- End-cap cosmetic profile, stave grain/figure selection (beyond stated material), rubber-foot/cradle-stand styling, finish sheen, note-position labeling/inlay.

## Must-nots (DFM may never violate)

- Tongue centerlines must not cross stave glue lines without a validated split-blank or wider non-vibrating bridge (risks.md, Structural, Severity: High — human decision required before cutting).
- Do not substitute tonewood species without updating the workbook `K` constant and cutting a validated coupon first (risks.md, Supply).
- Do not finish tuned tongues with the standard schedule before measuring before/after Hz and damping on a coupon (risks.md, Fit/Finish).
- Tongue width/OD ratio must stay ≤ 0.20 (design.md validity boundary) or the flat-cantilever model is no longer applicable without a re-derived curved-shell correction.

## Material intent

- Preferred: Padauk staves and end caps (or matching hardwood) per bom.csv B-001/B-002; goatskin/calfskin head optional for the drumhead-hybrid end variant (B-004).
- Acceptable subs: cherry or hard maple for body/tongues if the workbook `K` constant is updated first (bom.csv substitute_rule); synthetic head as an alternate to goatskin.
- Forbidden: none recorded.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable.
