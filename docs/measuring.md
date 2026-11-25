# Measuring the rod joint (design record)

> **This is a record from the design process, kept close to how it was written.**
> It was a page used partway through designing the adapter. It asked how much bare thin rod there is next to the joint, and checked the answers gathered so far. In it, "I" is the assistant (Claude) that designed the adapter, and "you" is the owner of the rod.
> The sizes in the drawings are illustrations, not the final design. See [What happened next](#what-happened-next) at the end, and the [README](../README.md) and [HANDOFF](../HANDOFF.md) for the current version.

---

*Curtain rod ramp · open question*

## How much bare thin rod is next to the joint?

I need this measurement to size the ramp. The first drawing shows what to measure, the second shows why it matters, and the third checks that I understood your answer about the clip's opening.

### 1. What to measure

![Side view of the joint. Measure the bare thin rod from the thick tube's rim to the first bracket or end cap.](images/measure-joint.svg)

Start at the rim of the thick tube and measure along the thin rod to the first thing attached to it, such as a wall bracket or the end cap. If nothing is close, measure to the end of the thin rod.

### 2. Why I need it

![Side view with the adapter fitted. The ramp sits on the thin rod inside the measured space and a sleeve wraps over the rim.](images/adapter-placement.svg)

The adapter has to fit in that space. Its ramp starts on the thin rod and rises to just above the thick tube, and a short sleeve wraps over the rim. A longer ramp gives the rings a gentler slope, so more room means a smoother slide. The ramp and sleeve lengths shown are placeholders.

### 3. Checking the clip opening

<p align="center"><img src="images/clip-opening.svg" width="460" alt="End view looking along the rod. The wall is on the left, the room on the right. The clip's opening faces the room and the ring rides on top."></p>

Looking along the rod. You picked the room side for the clip's opening, so it snaps on from the front and the rings ride over the closed top. Tell me if this isn't what you meant.

*The rods and rings are drawn to scale from your measurements. The ring thickness, the bracket shape and the adapter's wall thickness are only for illustration.*

### Your answers so far

| | |
|---|---|
| Thick tube | 0.8865 in · 22.52 mm |
| Thin rod | 0.7555 in · 19.19 mm |
| Step per side | 0.0655 in · 1.66 mm |
| Shape | Both round |
| Thick tube rim | Plain flat edge |
| Loops | Rings, 1.2075 in · 30.67 mm inside |
| Where they catch | Going from the thin rod onto the thick tube |
| The gap | Just the step, no open space |
| Mounting | Snaps on from the side |
| At the rim | Sleeve overlaps the thick tube |
| Clip opening | Faces the room |
| Bare thin rod | Still needed |

### Still to ask after this

- How many joints the rod has
- Which filament and nozzle size you'll print with
- Which way you'd like it to lie on the print bed

---

## What happened next

*Added afterward, to close out the open questions above.*

| Question | Answer |
|---|---|
| Bare thin rod | Nothing is attached to the thin rod near the joint, so there's no limit on ramp length. |
| Number of joints | One. |
| Filament and nozzle | PLA, 0.4 mm nozzle. |
| Print orientation | Standing on the sleeve end, with no supports. |
| Ramp and sleeve | Version 1 used a 25 mm ramp and a 10 mm sleeve. Version 2 uses 50 mm and 20 mm. |

Version 1 also used a sloped stop at the rim. It was replaced by a flat stop in version 2, because rings pushing on the ramp could force the adapter onto the thick tube. The full story is in the [HANDOFF](../HANDOFF.md).
