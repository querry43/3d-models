pi_mount();



module pi_mount() {

    difference() {
        union() {
            cube([82, 60, 11]);

            for (x = [18.5, 18.5+58]) {
                for (y = [6, 6+49]) {
                    translate([x, y, 11]) pi_hole(h=14.5);
                }
            }

            translate([18.5+58, 6+49, 17])
            pi_nub();
        }

        translate([6, 8.5, 0]) union() {
            translate([0, 0, 8.5]) gc_hole(h=10);
            translate([33.3, 0, 8.5]) gc_hole(h=10);
            translate([66.6, 0, 8.5]) gc_hole(h=10);
            translate([17.8, 23.3, 0]) gc_hole(h=10);
        }

        mask();
    }
    
    module mask() {
        translate([-10, -10, -5])
        cube([100, 10, 30]);
        translate([-10, 60, -5])
        cube([100, 10, 30]);
        translate([82, -5, -5])
        cube([10, 70, 30]); 
        translate([63.4, 2, 11])
        cube([10, 100, 20]);
        translate([5.3, 0, 11])
        cube([10, 20, 30]);
        translate([3.5, 50, 11])
        cube([10, 20, 30]);
        translate([22, 50, 11])
        cube([10, 20, 30]);
        translate([-7, 23, 7])
        cube([20, 40, 30]);
    }

    module gc_hole(h=1) {
        $fn = 20;
        cylinder(h=h, d=3);
        translate([0, 0, -h]) cylinder(h=h, d=7.5);
        translate([0, 0, 3]) cylinder(h=h, d=8);
    }

    module pi_hole(h=5) {
        $fn = 20;
        difference(){
            cylinder(h=h, d=6.3);
            translate([0, 0, h-3.9]) cylinder(h=4, d=3);
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

    module pi_nub(h=5) {
        $fn = 10;
        cylinder(h=8.5, d=4);
        cylinder(h=10, d=2);
    }
}