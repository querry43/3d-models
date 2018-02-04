%cube([30, 60, 47]);

wall_thickness = 3;

box();
flange();

module box() {
    difference() {
        cube([29, 60, wall_thickness]);
        translate([6, -1, -0.5])
        cube([17, 25, wall_thickness+1]);
    }

    difference() {
        cube([wall_thickness, 60, 45]);
        translate([-0.5, 3, 5])
        cube([wall_thickness+1, 28, 28]);
    }

    translate([29-wall_thickness, 0])
    difference() {
        cube([wall_thickness, 60, 45]);
        translate([-0.5, -0.5, 19])
        cube([wall_thickness+1, 40, 13]);
    }

    translate([0, 60-wall_thickness])
    cube([29, wall_thickness, 45]);
}

module flange() {
    flange_thickness = 2;

    translate([-flange_thickness, 0])
    cube([wall_thickness+flange_thickness, flange_thickness, 45]);

    translate([29-wall_thickness, 0])
    cube([wall_thickness+flange_thickness, flange_thickness, 45]);
}