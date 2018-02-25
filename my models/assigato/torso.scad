use <../openscad_libraries/robotics.scad>
use <head_shell.scad>

shell();

neck();
neck_base();

#translate([10, -10, -31])
rotate([0, 90, 90])
servo();

module neck_base() {
    difference() {
        translate([0, 0, -51])
        cylinder(d=120, h=10);

        translate([-32, -11, -52])
        cube([43, 22, 12]);

        for (x = [-35.5, 14.5]) {
            for (y = [-5.5, 4.5]) {
                translate([x, y, -52])
                servo_hole();
            }
        }
    }

    module servo_hole() {
        $fn = 16;
        cylinder(d=5, h=12);
    }
}

module neck() {
    difference() {
        translate([0, 0, -70])
        difference() {
            sphere(d=120);
            sphere(d=110);
        }

        scale([1.05, 1.05, 1.05])
        hull() {
            sphere(d=1);
            shell();
        }

        translate([-100, -100, -140])
        cube([200, 200, 100]);

        translate([-100, -100, -23])
        cube([200, 200, 100]);
    }
}