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
