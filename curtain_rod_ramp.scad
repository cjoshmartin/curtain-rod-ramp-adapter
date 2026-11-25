// Curtain rod ramp adapter, version 2
//
// Snaps onto the thin rod right where it enters the thick tube. A long,
// curved ramp lifts the curtain rings up and over the thick tube's rim, and a
// sleeve wraps over the rim. Inside, a flat stop butts against the rim so the
// rings can't push the adapter onto the thick tube.
//
// Every edge the rings or the rod slide over (ramp tip, sleeve end and both
// edges of the clip opening) thins down to edge_wall.
//
// Install: push it onto the rod from the room side with the opening facing
//          you, then slide it until the flat stop meets the thick tube's rim.
// Print:   as exported, standing on the sleeve end (wide open end) on the
//          bed. No supports needed. Use a brim: the base is only edge_wall
//          wide and the part is tall.
//
// Lengths are in mm, except settings whose names end in _in (inches).

/* [Your measurements] */
// Thick tube outside diameter (inches)
outer_tube_dia_in = 0.8865;
// Thin rod outside diameter (inches)
inner_rod_dia_in  = 0.7555;
// Curtain ring inside diameter (inches), only used to check clearance
ring_inner_dia_in = 1.2075;

/* [Fit] */
// Added to each rod diameter for the bore. Lower = tighter grip
fit_clearance = 0.2;
// Clip opening as a fraction of the bore width. Lower = grips harder but is harder to snap on
snap_opening  = 0.82;

/* [Shape] */
// Length of the ramp along the thin rod
ramp_length   = 50;
// Length of the sleeve over the thick tube
sleeve_length = 20;
// Wall thickness over the rim, the thickest point (1.2 = 3 lines with a 0.4 mm nozzle)
sleeve_wall   = 1.2;
// Wall thickness at every thin edge (0.4 = 1 line with a 0.4 mm nozzle)
edge_wall     = 0.4;
// How far around from each opening edge the wall thins, in degrees
opening_taper_angle = 20;
// Width of the flat stop that butts against the thick tube's rim
stop_ledge_width    = 1.0;

/* [Preview] */
// Show see-through rods in preview (F5). They are never exported
show_rods = true;

/* [Hidden] */
profile_steps = 60;   // points along each of the ramp and the sleeve
angle_step    = 1;    // degrees between slices around the clip
mm_per_in     = 25.4;

thick_d = outer_tube_dia_in * mm_per_in;
thin_d  = inner_rod_dia_in  * mm_per_in;
ring_d  = ring_inner_dia_in * mm_per_in;

thick_bore_r = (thick_d + fit_clearance) / 2;
thin_bore_r  = (thin_d  + fit_clearance) / 2;

peak_r = thick_bore_r + sleeve_wall;   // highest point, right over the rim
tip_r  = thin_bore_r  + edge_wall;     // ramp leading edge
end_r  = thick_bore_r + edge_wall;     // sleeve far end

// Inside, the bore steps from the thick tube down to the thin rod. The outer
// part of that step is flat (the stop the rim pushes against); the inner part
// is a 45 degree chamfer so it prints without supports.
ledge_r   = thick_bore_r - stop_ledge_width;
chamfer_h = ledge_r - thin_bore_r;
total_h   = sleeve_length + ramp_length;

// Half the angle cut away for the clip opening.
open_half_angle = asin(snap_opening);
arc_angle       = 360 - 2 * open_half_angle;

assert(thick_d > thin_d, "The thick tube must be wider than the thin rod.");
assert(snap_opening > 0 && snap_opening < 1, "snap_opening must be between 0 and 1.");
assert(edge_wall > 0 && edge_wall <= sleeve_wall, "edge_wall must be between 0 and sleeve_wall.");
assert(stop_ledge_width > 0 && stop_ledge_width < thick_bore_r - thin_bore_r,
       "stop_ledge_width must be smaller than the step between the rods.");
assert(chamfer_h < ramp_length, "ramp_length is too short for the step.");
assert(2 * opening_taper_angle < arc_angle, "opening_taper_angle is too large.");
assert(2 * peak_r < ring_d, "The adapter would be wider than the rings' inside diameter.");

// Smooth 0..1 curve, flat at both ends, so the surfaces have no corners.
function ease(t) = let (c = min(1, max(0, t))) c * c * (3 - 2 * c);

// Radius the thinned walls are measured from. It follows the bore, except at
// the rim step, where it moves inward at 45 degrees. That way the thin
// opening edges never jump inward over thin air while printing.
function edge_ref_r(z) =
    z <= sleeve_length ? thick_bore_r :
    max(thin_bore_r, thick_bore_r - (z - sleeve_length));

// Full-thickness outside radius at height z.
function outer_r_at(z) =
    z <= sleeve_length
        ? end_r  + (peak_r - end_r)  * ease(z / sleeve_length)
        : peak_r - (peak_r - tip_r)  * ease((z - sleeve_length) / ramp_length);

// Heights sampled along the outside, bottom to top.
outer_z = concat(
    [for (i = [0 : profile_steps]) i / profile_steps * sleeve_length],
    [sleeve_length + chamfer_h],
    [for (i = [1 : profile_steps])
        let (z = sleeve_length + i / profile_steps * ramp_length)
        if (z > sleeve_length + chamfer_h + 0.01) z]
);

// Half cross-section as [radius, height]. Height 0 is the sleeve end on the
// bed. s = 1 is full wall thickness,
// s = 0 is thinned to edge_wall (used at the clip opening edges).
function section(s) = concat(
    [for (z = outer_z)
        let (ri = edge_ref_r(z), w = outer_r_at(z) - ri)
        [ri + edge_wall + max(0, w - edge_wall) * s, z]],
    [[thin_bore_r,  total_h],
     [thin_bore_r,  sleeve_length + chamfer_h],
     [ledge_r,      sleeve_length],
     [thick_bore_r, sleeve_length],
     [thick_bore_r, 0]]
);

slices = ceil(arc_angle / angle_step);
sec_n  = len(section(1));

function slice_angle(j) = open_half_angle + j * arc_angle / slices;

// Wall scale around the clip: thin at both opening edges, full elsewhere.
function wall_scale(a) =
    ease(min(a - open_half_angle, 360 - open_half_angle - a) / opening_taper_angle);

module adapter() {
    points = [for (j = [0 : slices])
                let (a = slice_angle(j))
                for (p = section(wall_scale(a)))
                    [p[0] * cos(a), p[0] * sin(a), p[1]]];
    sides = [for (j = [0 : slices - 1]) for (k = [0 : sec_n - 1])
                let (a = j * sec_n + k,
                     b = j * sec_n + (k + 1) % sec_n,
                     c = (j + 1) * sec_n + (k + 1) % sec_n,
                     d = (j + 1) * sec_n + k)
                each [[a, b, c], [a, c, d]]];
    caps = [[for (k = [sec_n - 1 : -1 : 0]) k],
            [for (k = [0 : sec_n - 1]) slices * sec_n + k]];
    // Opening is centered on +X
    polyhedron(points = points, faces = concat(sides, caps), convexity = 6);
}

// The rod, positioned as installed: thick tube below, thin rod above.
module rods() {
    translate([0, 0, sleeve_length - 40]) cylinder(d = thick_d, h = 40, $fn = 120);
    translate([0, 0, sleeve_length - 10]) cylinder(d = thin_d, h = ramp_length + 50, $fn = 120);
}

adapter();

if (show_rods) %rods();

echo(str("Widest diameter: ", 2 * peak_r, " mm  (ring inside: ", ring_d,
         " mm, clearance ", ring_d - 2 * peak_r, " mm)"));
echo(str("Edge the rings meet on the thin rod: ", tip_r - thin_d / 2,
         " mm  (bare joint was ", (thick_d - thin_d) / 2, " mm)"));
echo(str("Edge the rings meet on the thick tube: ", end_r - thick_d / 2, " mm"));
echo(str("Steepest ramp angle: ",
         atan(1.5 * (peak_r - tip_r) / ramp_length), " degrees"));
echo(str("Steepest sleeve taper angle: ",
         atan(1.5 * (peak_r - end_r) / sleeve_length), " degrees"));
echo(str("Clip opening at the thin rod: ", 2 * thin_bore_r * snap_opening,
         " mm  (rod: ", thin_d, " mm)"));
echo(str("Print height: ", total_h, " mm"));
