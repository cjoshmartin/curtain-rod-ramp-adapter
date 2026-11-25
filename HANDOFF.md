# Curtain Rod Ramp Adapter: Handoff

Last updated: 2026-11-26

## Where things stand

- **Version 2 is designed and ready to print**, but it hasn't been printed or tried on the rod yet.
- Version 1 was printed. It fit, but slid off when a ring hit it, in both directions (see History).
- **Next step:** print `curtain_rod_ramp.3mf`, install it, and run rings across it both ways. Check whether it stays put.

## Files

| File | What it is |
|---|---|
| `curtain_rod_ramp.scad` | The OpenSCAD model (version 2). Every setting is at the top of the file. |
| `curtain_rod_ramp.stl` | Exported from the `.scad`, already standing upright for printing. |
| `curtain_rod_ramp.3mf` | Bambu Studio project with the print settings below. Open it as a project, not "geometry only". |
| `README.md` | Public overview: how it works, fitting it to a rod, printing and installing. |
| `HANDOFF.md` | This file. |
| `docs/measuring.md` | Design record: the diagram page used to work out the measurements, moved into the repo. Its pictures are in `docs/images/`. |
| `images/` | README pictures. `sh images/render.sh` re-renders them from `images/views.scad`. |
| `LICENSE` | CC BY 4.0. |

## The problem

The curtain rod is telescoping: a thin rod slides into a thick tube. The curtain rings catch on the flat rim of the thick tube when they move from the thin rod onto the thick tube. The step is 1.66 mm per side. The adapter clips onto the thin rod at the joint and gives the rings a ramp over that step.

## Measurements

| | Inches | mm |
|---|---|---|
| Thick tube, outside diameter | 0.8865 | 22.52 |
| Thin rod, outside diameter | 0.7555 | 19.19 |
| Step per side | 0.0655 | 1.66 |
| Ring, inside diameter | 1.2075 | 30.67 |

- Both pieces are round.
- The thick tube's rim is a plain flat edge, with no lip, bushing or screw.
- The rod has one joint.
- Nothing is attached to the thin rod near the joint, so there's no limit on ramp length.
- The loops are separate rings (metal, plastic or wood). They originally caught only going from the thin rod onto the thick tube.

## Design decisions (your answers)

- It snaps on from the side while the rod stays on the wall, and comes off by hand.
- The clip's opening faces the room. The rings ride on top of the rod, over the closed part of the clip.
- A sleeve overlaps the thick tube's rim. You chose to keep it after version 1 failed.
- The ramp is curved: it starts nearly flat, then rounds over at the top.
- It prints standing on the sleeve end with no supports.
- Printing setup: PLA, 0.4 mm nozzle, Bambu A1, Bambu PLA Basic, Textured PEI plate, 0.16 mm layers.
- Version 2 lengths: ramp 50 mm, sleeve 20 mm.
- Thin edges are wanted both where the rings ride over (ramp tip and sleeve end) and along the clip's opening.
- **Grip:** for version 2 you chose *not* to tighten the fit. Your idea was that a longer adapter with thinner edges would stop the sliding on its own.
- The sleeve end stays at 0.4 mm and the Bambu warning is ignored (see Known issues).

## How version 2 is shaped

- It's a C-shaped clip. The opening is 0.82 × the bore width, a gap of about 110°.
- The bore is 0.2 mm wider than the rod (and than the tube in the sleeve section).
- **Sleeve** (bottom 20 mm as printed): fits over the thick tube. The wall goes from 0.4 mm at the end up to 1.2 mm over the rim, on a smooth curve.
- **Stop** (at the rim): a flat ledge 1 mm wide that butts against the thick tube's rim, then a 45° chamfer down to the thin-rod bore. The chamfer lets it print without supports.
- **Ramp** (top 50 mm as printed): goes from its highest point over the rim down to a 0.4 mm leading edge on the thin rod, on a smooth curve that's flat at both ends.
- **Opening edges:** the wall thins to 0.4 mm over the last 20° on each side of the opening. The top of the clip, where the rings ride, keeps its full shape. At the rim step, these edges step inward at 45° so they never print over thin air.

| Key number | Value |
|---|---|
| Widest diameter | 25.12 mm (5.55 mm clearance inside the rings) |
| Edge the rings meet on the thin rod | 0.5 mm (bare joint: 1.66 mm) |
| Edge the rings meet coming off the thick tube | 0.5 mm |
| Steepest ramp angle | 4.2° |
| Steepest sleeve taper | 3.4° |
| Print height | 70 mm |
| Print time and filament (A1) | about 37 min, 5.6 g |

## History

### Version 1

- Ramp 25 mm and sleeve 10 mm.
- The edges were 0.5 mm.
- A 45° slope inside served as the stop.
- Same fit as version 2.

**Result:** it fit, but it slid off when a ring hit it, in both directions, and a light push by hand slid it along the rod. Three causes:

1. **No clamping.** The bore is wider than the rod, so the clip holds on but doesn't squeeze.
2. **The 45° stop acted like a wedge.** Rings pushing toward the thick tube made the rim spread the clip open, and the adapter rode onto the thick tube.
3. **The sleeve's end edge caught rings coming back** off the thick tube and dragged the adapter along the thin rod.

### Version 2 changes

- Flat stop instead of the slope.
- Ramp lengthened to 50 mm and sleeve to 20 mm.
- All edges thinned to 0.4 mm, including the clip's opening edges.
- Opening edges step inward at 45° at the rim step.
- The fit is unchanged, by your choice.

## Print setup (`curtain_rod_ramp.3mf`)

The project uses an A1 with a 0.4 mm nozzle, Bambu PLA Basic @BBL A1, the Textured PEI plate and Bambu's **0.16mm Optimal @BBL A1** profile, with these changes:

| Setting | Bambu default | This project | Why |
|---|---|---|---|
| Brim type | Auto | Outer brim only | The base is only 0.4 mm wide and the part is 70 mm tall on a bed that moves under it |
| Brim width | 5 mm | 8 mm | Same reason |
| Brim-object gap | 0.1 mm | 0.1 mm (unchanged) | Lets the brim snap off cleanly, with no burr on the sleeve's end edge |
| Elephant foot compensation | 0.075 mm | 0.15 mm | Stops the first layer flaring the sleeve's end edge outward |
| Wall generator | Classic | Arachne | Prints the 0.4 mm edges and changing wall thickness cleanly |
| Wall loops | 2 | 7 | Makes the part all outline lines with no infill, so it flexes without cracking |

Supports stay off.

**To rebuild the 3MF after changing the model:**

1. In Bambu Studio, select the A1 with a 0.4 mm nozzle, Bambu PLA Basic, the Textured PEI plate and the 0.16mm Optimal profile.
2. Import the new STL.
3. Apply the settings in the table above.
4. Save the project.

The scripts I used to build this 3MF lived in a temporary folder and weren't kept. Doing it by hand in Bambu Studio is simpler anyway.

## Known issues and trade-offs

- **"Floating regions" warning when slicing:** this is a false alarm caused by the 0.4 mm sleeve end. I checked the G-code: the first layer prints a full ring at the same radius as the layers above it. Don't turn on supports. Making the sleeve end 0.5 mm clears the warning, but raises the edge the rings meet coming off the thick tube from 0.5 mm to 0.6 mm. You chose to keep 0.4 mm.
- **Grip is untested.** Version 1 slid with a light push. Version 2 has the same fit, so it may still slide when rings drag on it.
- **The sleeve end is a new edge.** Before the adapter, rings coming back off the thick tube met no edge. Now they meet a 0.5 mm one.
- **Brim leftovers:** any burr left on the sleeve end when you remove the brim gives the rings something to catch on. Clean it off.
- **Fragile edges:** the 0.4 mm edges are a single line of PLA and could chip.
- **Bambu command-line quirk** (only matters if you rebuild the 3MF from the command line): exporting that way silently changes the A1's acceleration limits for X, Y and travel to 6000. In this 3MF they're restored to Bambu's stock values of 12000, 12000 and 9000.

## Tuning (settings at the top of `curtain_rod_ramp.scad`)

| Setting | Now | What it does |
|---|---|---|
| `fit_clearance` | 0.2 | Added to each rod diameter for the bore. **If it slides, try 0 first, then -0.1 to -0.2** so the clip squeezes the rod. |
| `snap_opening` | 0.82 | Clip opening as a fraction of the bore. Lower grips harder but is harder to snap on. |
| `ramp_length` | 50 | Ramp length in mm. |
| `sleeve_length` | 20 | Sleeve length in mm. |
| `sleeve_wall` | 1.2 | Wall thickness over the rim, the thickest point. |
| `edge_wall` | 0.4 | Thickness of every thin edge. 0.4 is the practical minimum with a 0.4 mm nozzle. |
| `opening_taper_angle` | 20 | How far around from each opening edge the wall thins, in degrees. |
| `stop_ledge_width` | 1.0 | Width of the flat stop that butts against the rim. |
| `show_rods` | true | Shows see-through rods in preview only. They're never exported. |

Your measurements are at the top of the file in inches: `outer_tube_dia_in`, `inner_rod_dia_in` and `ring_inner_dia_in`.

**To regenerate the STL:** run this in the repo folder (tested with OpenSCAD 2026.10):

```
openscad --export-format binstl -o curtain_rod_ramp.stl curtain_rod_ramp.scad
```

The `binstl` option writes a binary STL: same shape, about a sixth of the file size. The 3MF was built from the same shape.

**To regenerate the README images:** `sh images/render.sh`

The console lists the key numbers: widest diameter, ring clearance, edge heights, slope angles and print height. If a setting would make the adapter wider than the rings, the file stops with a message instead of exporting.

**Model layout:** height 0 is the sleeve end, sitting on the bed. The rim stop is at height `sleeve_length`, and the ramp tip is at the top. The clip opening faces +X.

## To report back after testing version 2

- Does it stay in place when rings cross it in each direction?
- Do the rings pass the sleeve end smoothly when coming off the thick tube?
- How hard is it to snap on and pull off by hand?
- Did the brim come off cleanly, and did any thin edges chip?
