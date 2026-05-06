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
