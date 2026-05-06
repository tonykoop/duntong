# SolidWorks MasterLayout Plan - Duntong

## Purpose

This is the CAD handoff for the original duntong. It does not claim that a SolidWorks part exists. It defines the MasterLayout variables, configurations, datums, and drawings that should be created before CAM.

## MasterLayout Part

Create `DNT-001_MasterLayout.SLDPRT` with these top-level datums:

| Datum | Meaning | Use |
|---|---|---|
| A | Shell axis | Lathe, V-block, rotary indexing, section view |
| B | Left end plane | End cap and drumhead interface |
| C | Right end plane | End cap and drumhead interface |
| D | Tongue equator plane | Single-ring layout center |
| E | Index zero radial plane | First tongue centerline |

## Configurations

| Configuration | Purpose |
|---|---|
| DNT-HANDHELD | 6 in OD x 9 in long concept proof |
| DNT-MEDIUM-SEALED | V1 medium with solid end caps |
| DNT-MEDIUM-PORTED | Medium with one 3 in acoustic port |
| DNT-MEDIUM-DRUMHEAD | Medium with drumhead rim and hardware placeholder |

## Required Sketches

1. `SK_MasterEnvelope`: cylinder OD, ID, length, wall.
2. `SK_StaveSection`: 12-stave polygon, miter angle, glue line locations.
3. `SK_TongueUnwrap`: 37.699 in circumference x 16 in length flattened layout.
4. `SK_TongueRing`: eight tongue centerlines around equator.
5. `SK_EndOptions`: sealed cap, port cap, drumhead bearing edge.
6. `SK_VBlockFixture`: 12 in OD shell cradle and clamp clearance.

## Drawing Sheets

| Sheet | Contents |
|---|---|
| SHT-001 Body Overview | OD, ID, length, wall, datums, stave count |
| SHT-002 Tongue Layout | Unwrapped tongue paths, note labels, trim allowance |
| SHT-003 End Options | Sealed, ported, two-port, drumhead variants |
| SHT-004 CNC Setup | V-block, clamp zones, index rotation table |
| SHT-005 Validation | Measurement points, tuner logging callouts |

## CAD Rules

- Keep all driven dimensions named with the same variables used in `cad/sw-global-variables.csv`.
- Tongue lengths should be model dimensions, not sketch-only notes.
- Show stave seam locations relative to tongue roots before approving the CNC layout.
- Add suppressible features for the port and drumhead options rather than separate unrelated parts.
- Do not export CAM until the V-block fixture and clamp clearance are reviewed.

## Open Decisions

- Final V1 end condition: sealed, ported, or drumhead.
- Whether to rotate the tongue layout to avoid all glue-line crossings.
- Whether D minor pentatonic should replace the workbook's current C minor pentatonic baseline.
- Whether the first physical prototype should be medium stave or handheld split-blank.
