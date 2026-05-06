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
