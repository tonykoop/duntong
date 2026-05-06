// Duntong parametric OpenSCAD starter
// Units: inches
// This is a concept/master-layout scaffold, not production CAM.

$fn = 96;

variant = "medium"; // "handheld" or "medium"
show_tongues = true;
show_end_caps = true;
show_vblock = false;

shell_od = variant == "handheld" ? 6 : 12;
shell_len = variant == "handheld" ? 9 : 16;
wall = variant == "handheld" ? 0.375 : 0.5;
shell_id = shell_od - 2 * wall;
tongue_count = 8;
tongue_width = variant == "handheld" ? 1.0 : 1.5;
slit_width = 0.125;
root_midi = variant == "handheld" ? 72 : 60;
k_cantilever = 24438;
trim_allowance = 1.05;
port_dia = variant == "handheld" ? 2.0 : 3.0;

notes = [
    ["C", 0],
    ["Eb", 3],
    ["F", 5],
    ["G", 7],
    ["Ab", 8],
    ["Bb", 10],
    ["C", 12],
    ["Eb", 15]
];

function freq_from_midi(m) = 440 * pow(2, (m - 69) / 12);
function tongue_len(offset) = sqrt(k_cantilever * wall / freq_from_midi(root_midi + offset)) * trim_allowance;

module shell() {
    difference() {
        cylinder(h = shell_len, d = shell_od, center = true);
        cylinder(h = shell_len + 0.1, d = shell_id, center = true);
    }
}

module tongue_cut(angle_deg, len, label) {
    // Visual placeholder only. Production geometry needs a wrapped or
    // projected sketch in SolidWorks.
    rotate([0, 0, angle_deg])
        translate([shell_od / 2 - wall / 2, 0, 0])
            rotate([0, 90, 0])
                union() {
                    cube([len, slit_width, wall * 3], center = true);
                    translate([len / 2, 0, 0])
                        cube([slit_width, tongue_width, wall * 3], center = true);
                    translate([-len / 2, 0, 0])
                        cube([slit_width, tongue_width, wall * 3], center = true);
                }
}

module tongue_labels() {
    for (i = [0 : tongue_count - 1]) {
        angle = i * 360 / tongue_count;
        len = tongue_len(notes[i][1]);
        rotate([0, 0, angle])
            translate([shell_od / 2 + 0.25, 0, 0])
                rotate([90, 0, angle])
                    linear_extrude(0.02)
                        text(str(notes[i][0], " ", len), size = 0.25, halign = "center");
    }
}

module end_caps() {
    translate([0, 0, shell_len / 2 + 0.02])
        cylinder(h = 0.35, d = shell_id, center = true);
    translate([0, 0, -shell_len / 2 - 0.02])
        cylinder(h = 0.35, d = shell_id, center = true);
}

module ported_end_cap() {
    difference() {
        cylinder(h = 0.35, d = shell_id, center = true);
        cylinder(h = 0.5, d = port_dia, center = true);
    }
}

module vblock() {
    translate([0, 0, -shell_od / 2 - 1.0])
        difference() {
            cube([shell_od + 4, shell_len + 3, 2], center = true);
            rotate([90, 0, 0])
                cylinder(h = shell_len + 4, d = shell_od + 0.25, center = true);
        }
}

difference() {
    shell();
    if (show_tongues) {
        for (i = [0 : tongue_count - 1]) {
            tongue_cut(i * 360 / tongue_count, tongue_len(notes[i][1]), notes[i][0]);
        }
    }
}

if (show_end_caps) {
    end_caps();
}

if (show_vblock) {
    vblock();
}

// Echo design table values for review.
echo(str("variant=", variant));
echo(str("shell_od=", shell_od, " shell_id=", shell_id, " length=", shell_len, " wall=", wall));
for (i = [0 : tongue_count - 1]) {
    echo(str(notes[i][0], " length_with_trim=", tongue_len(notes[i][1])));
}
