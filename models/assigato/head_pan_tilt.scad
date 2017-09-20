use <../openscad_libraries/robotics.scad>

platform();
mounting_rail();

%translate([6.5, 1, -9])
rotate([0, 90])
servo();

module mounting_rail() {
    difference() {
        arm();
        translate([-20, 0])
        axis(diameter = 7);
    }

    difference() {
        translate([49.5, 0])
        arm();
        
        translate([20, 0])
        axis();
    }

    translate([-11, 40, 4.5])
    cube([54.5, 10, 10]);

    module arm() {
        hull() {
            translate([-6, 11, 9.5])
            rotate([0, -90])
            cylinder(h = 5, d = 10);
            
            translate([-11, 40, 4.5])
            cube([5, 5, 10]);
        }
    }
} 

module platform() {
    difference() {
        base();

        translate([43.2/2 - (43.2 - 38), 11, -0.5])
        cylinder(h = 20, d = 10);
    }
 
    mounting_rail();
    translate([0, 29.2])
    mounting_rail();
    bearing();

    %translate([4, 5, 3])
    micro_servo();

    module base() {
        hull() {
            translate([37, 0])
            cube([1, 34, 3]);

            $fn = 20;

            translate([2, 2-5])
            cylinder(h = 3, d = 4);
            
            #translate([38-2, 2-5])
            cylinder(h = 3, d = 4);

            translate([2, 34-2])
            cylinder(h = 3, d = 4);
        }
    }
 
    module bearing() {
        difference() {
            union () {
                translate([33, 0, 3])
                cube([5, 34, 13]);
                
                translate([20, 0, 14])
                cube([15, 4.8, 2]);
                
                translate([20, 29.2, 0])
                cube([15, 4.8, 16]);
            }

            axis();
        }
    }
 
    module mounting_rail() {
        translate([4, 0, 3])
        cube([4.75, 4.8, 3]);

        difference() {
            translate([12, 0, 3])
            cube([13, 4.8, 13]);

            $fn = 8;
            translate([17, 2.5, 9.5])
            rotate([0, -90])
            cylinder(h = 6, d = 3);
        }
    }
}

// use this for centering the hole
module axis(diameter = 4) {
    $fn = 20;
    translate([38, 11, 9.5])
    rotate([0, -90])
    cylinder(h = 43.2, d = diameter);
}
