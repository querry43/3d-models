servo();

translate([0, 60])
micro_servo();

translate([-40, 0])
raspberry_pi_cam();

module raspberry_pi_cam() {
    cube([25, 24, 4]);
    translate([25/2 - 8/2, 5.7, 4])
    cube([8, 8, 5.3]);
    translate([25/2 - 8/2, 5.7+8, 4])
    cube([8, 9, 1.3]);
    translate([25/2 - 21/2, 0, -3])
    cube([21, 6, 3]);
}

module micro_servo() {
    body();
    output_shaft();
    cable();

    height = 13;
    depth = 23;

    module body() {
        $fn = 25;

        cube([depth, 24, height]);

        difference() {
            offset = 5;
            translate([offset, -(32-24)/2])
            cube([3, 32, height]);

            translate([offset+3+0.5, -2.5, height/2])
            rotate([0, -90])
            union() {
                cylinder(h = 4, d = 3);
                translate([0, 28.75])
                cylinder(h = 4, d = 3);
            }
        }

        translate([0, 12/2, height/2])
        rotate([0, -90])
        cylinder(h = 4, d = 12);

        translate([0, 12, height/2])
        rotate([0, -90])
        cylinder(h = 4, d = 5);
    }

    module output_shaft() {
        $fn = 25;
        translate([-4, 12/2, height/2])
        rotate([0, -90])
        cylinder(h = 3.25, d = 4.5);
    }

    module cable() {
        translate([depth-1, -1, height/2 - 4/2])
        cube([2, 2, 4]);
    }
}

module servo() {
    body();
    output_shaft();
    cable();

    height = 20;
    depth = 36;

    module body() {
        $fn = 25;

        cube([depth, 41, height]);

        difference() {
            offset = 7;
            translate([offset, -(56-41)/2])
            cube([3, 56, height]);

            translate([offset+3+0.5, -4.5, 2+5/2])
            rotate([0, -90])
            union() {
                cylinder(h = 4, d = 5);

                translate([10, 0, 0])
                cylinder(h = 4, d = 5);

                translate([0, 50])
                cylinder(h = 4, d = 5);

                translate([10, 50])
                cylinder(h = 4, d = 5);
            }
        }

        translate([0, 10, height/2])
        rotate([0, -90])
        cylinder(h = 4, d = 14);
    }

    module output_shaft() {
        $fn = 25;
        translate([-4, 10, height/2])
        rotate([0, -90])
        cylinder(h = 3.25, d = 5.75);
    }

    module cable() {
        translate([depth-1, -1, height/2 - 4/2])
        cube([2, 2, 4]);
    }
}
