use <../openscad_libraries/robotics.scad>
use <head_pan_tilt.scad>

// -28 to 22
head_assembly(tilt_angle = 0);

// skull();
// face();



module head_assembly(tilt_angle = 0) {
    translate([0, 7])
    rotate([tilt_angle, 0])
    translate([0, -7])

    union() {
        skull();

        translate([-17, -4, -10])
        head_pan_tilt_assembly(pan_angle = 0, tilt_angle = 90+tilt_angle, neck_height = 30, rail_height = 35);
    }

    union() {
        face();

        #translate([-25/2, -27, -9])
        rotate([90, 0])
        raspberry_pi_cam();

        #translate([-18, -27, 13])
        rotate([90, 0])
        led_5mm();

        #translate([18, -27, 13])
        rotate([90, 0])
        led_5mm();
    }
}

module face() {
    intersection() {
        translate([-100, -60, -50])
        cube([200, 50, 100]);
        head();
    }
}

module flange() {
    $fn = 40;

    difference() {

        translate([0, -8])
        resize([105, 3, 70])
        rotate([90, 0])
        cylinder(h = 1, d = 1);

        translate([0, -7.5])
        resize([105-15, 4, 70-15])
        rotate([90, 0])
        cylinder(h = 1, d = 1);
    }
}

module skull() {
    intersection() {
        translate([-100, -10, -50])
        cube([200, 50, 100]);
        head();
    }
}

module head() {
    difference() {
        shell();

        nose();
        mouth();
        eyes();

        mount_hole();

        hull() {
            translate([0, -5, -40])
            cylinder(h = 20, d = 25);

            translate([0, 18, -40])
            cylinder(h = 20, d = 25);
        }
    }

    mount_slots();
    camera_mount();
}

module mount_hole() {
    $fn = 10;
    translate([0, 7, 20])
    cylinder(h = 20, d = 4);
}

module camera_mount() {
    translate([13, -34, -9])
    cube([5, 5, 17]);
    translate([-18, -34, -9])
    cube([5, 5, 17]);
    translate([-31/2, -34, -9])
    cube([31, 2, 5]);
    translate([-8/2, -32.5, 13])
    cube([8, 0.5, 5]);
}

module mount_slots() {
    right();
    left();

    translate([-25, -3, 29])
    cube([50, 11, 3]);

    module right() {
        translate([-29, 0])
        mount_slot();

        hull() {
            translate([-31, -3])
            cube([2, 20, 25.5]);

            translate([-31, -3, 25.5])
            cube([2, 1, 5]);

            translate([-31, 8, 24])
            cube([2, 1, 5]);
        }
    }

    module left() {
        translate([23.5, 0])
        mount_slot();

        hull() {
            translate([27.5, -3])
            cube([2, 20, 26]);

            translate([27.5, -3, 25.5])
            cube([2, 1, 5]);

            translate([27.5, 8, 25])
            cube([2, 1, 5]);
        }
    }

    module mount_slot() {
        translate([0, -3])
        cube([4, 4, 31]);
        translate([0, 13])
        cube([4, 4, 26]);
    }
}

module eyes() {
    $fn = 15;

    translate([-18, -25, 13])
    rotate([90, 0])
    cylinder(h = 10, d = 6);

    translate([18, -25, 13])
    rotate([90, 0])
    cylinder(h = 10, d = 6);
}

module mouth() {
    translate([-25/2, -35, -20])
    cube([25, 10, 4]);
}

module nose() {
    translate([-9/2, -38, -4])
    cube([9, 20, 10]);
}

module shell($fn = 15) {
    difference() {
        ellipsoid(height = 75, length = 110);
        ellipsoid(height = 72, length = 107);
    }
    flange();
}

module ellipsoid(height, length) {
    hull() {
        for(x = [-length:1:length]) {
            cross_section(x, height, length);
        }
    }
}

module cross_section(x, height, length) {
    y = sqrt(pow(height/2, 2) - (pow(height/2, 2)*pow(x, 2))/pow(length/2, 2));
    translate([x, 0])
    rotate([0, 90])
    cylinder(h = 0.1, r = y);
}
