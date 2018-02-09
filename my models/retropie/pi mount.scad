pi_mount();



module pi_mount() {

    difference() {
        union() {
            cube([68.5, 60, 11]);

            x_off = 5;
            y_off = 6;
            for (x = [x_off, x_off+58]) {
                for (y = [y_off, y_off+49]) {
                    translate([x, y, 11]) pi_hole(h=11);
                }
            }
        }

        translate([6, 8.5, 0]) union() {
            translate([33.3-13.5, 0, 8.5]) gc_hole(h=10);
            translate([66.6-13.5, 0, 8.5]) gc_hole(h=10);
            translate([17.8-13.5, 23.3, 0]) gc_hole(h=10);
        }

        mask();
    }
    
    module mask() {
        translate([-10, -10, -5])
        cube([100, 10, 30]);
        translate([-10, 60, -5])
        cube([100, 10, 30]);
        translate([68.5, -5, -5])
        cube([10, 70, 30]);
        translate([49.9, 2, 11])
        cube([10, 100, 20]);
        translate([-8.2, 0, 4])
        cube([10, 20, 30]);
        translate([8.5, 0, 11])
        cube([10, 20, 30]);
        translate([-10, 50, 11])
        cube([10, 20, 30]);
        translate([8.5, 60-8, 0])
        cube([51.4, 8, 30]);
    }

    module gc_hole(h=1) {
        $fn = 20;
        cylinder(h=h, d=3);
        translate([0, 0, -h]) cylinder(h=h, d=7.5);
        translate([0, 0, 2.5]) cylinder(h=h, d=8);
    }

    module pi_hole(h=5) {
        $fn = 20;
        difference(){
            cylinder(h=h, d=6.3);
            translate([0, 0, h-7.9]) cylinder(h=8, d=2.5);
        }
        hull() {
            translate([2, -1, 0])
            cube([0.1, 2, h-2]);
            translate([2, -1, 0])
            cube([10, 2, 0.1]);
        }
        hull() {
            translate([-2, -1, 0])
            cube([0.1, 2, h-2]);
            translate([-12, -1, 0])
            cube([10, 2, 0.1]);
        }
        hull() {
            translate([-1, 2, 0])
            cube([2, 0.1, h-2]);
            translate([-1, 2, 0])
            cube([2, 10, 0.1]);
        }
        hull() {
            translate([-1, -2, 0])
            cube([2, 0.1, h-2]);
            translate([-1, -12, 0])
            cube([2, 10, 0.1]);
        }
    }
}