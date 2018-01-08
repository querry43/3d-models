pi_mount();

module pi_mount() {
    difference() {
        cube([85, 60, 12]);

        translate([6, 8.5, 0]) union() {
            translate([0, 0, 8.5]) gc_hole(h=10);
            translate([33.3, 0, 8.5]) gc_hole(h=10);
            translate([66.6, 0, 8.5]) gc_hole(h=10);
            translate([17.8, 23.3, 0]) gc_hole(h=10);
        }
    }

    for (x = [18.5, 18+5+58]) {
        for (y = [6, 6+49]) {
            translate([x, y, 12]) pi_hole(h=14.5);
        }
    }



    module gc_hole(h=1) {
        $fn = 20;
        cylinder(h=h, d=3);
        translate([0, 0, -h]) cylinder(h=h, d=6);
        translate([0, 0, 3]) cylinder(h=h, d=8);
    }

    module pi_hole(h=5) {
        $fn = 20;
        difference(){
            cylinder(h=h, d=6.3);
            translate([0, 0, h-3.9]) cylinder(h=4, d=3);
        }
    }
}