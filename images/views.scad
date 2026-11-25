// Views of the adapter for the README. Render them all with: sh images/render.sh
use <../curtain_rod_ramp.scad>

view = "installed"; // [installed, section, print, end]

adapter_color = "#2f6fd6";
rod_color     = "#c3c9d1";
cut_color     = "#f08c2e";

// As installed: rod axis along X (thin rod on the left, thick tube on the
// right), clip opening facing the viewer (the room side, -Y).
module as_installed() { rotate([0, -90, 0]) rotate([0, 0, -90]) children(); }

module scene() {
    as_installed() {
        color(rod_color) rods();
        color(adapter_color) adapter();
    }
}

if (view == "installed") scene();

if (view == "section") {
    // Adapter cut in half to show its wall profile against the (uncut) rod
    as_installed() color(rod_color) rods();
    difference() {
        as_installed() color(adapter_color) adapter();
        color(cut_color) translate([-200, -100, -100]) cube([400, 100, 200]);
    }
}

if (view == "print") {
    // Standing on the print bed, as exported
    color(adapter_color) adapter();
    color("#3a3f47") translate([-30, -30, -1]) cube([60, 60, 1]);
}

if (view == "end") {
    // Looking along the rod from the thin end
    as_installed() color(adapter_color) adapter();
    as_installed() color(rod_color) translate([0, 0, 20]) cylinder(d = 19.19, h = 100, $fn = 120);
}
