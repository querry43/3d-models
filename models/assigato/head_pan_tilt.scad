use <../openscad_libraries/robotics.scad>

platform();
mounting_rail();

%translate([6, 1, -9])
rotate([0, 90])
servo();

module mounting_rail() {
    difference() {
        arm();
        translate([-20, 0])
        axis();
    }

    difference() {
        translate([46.5, 0])
        arm();
        
        translate([20, 0])
        axis();
    }
    
    translate([-11, 40, 4.5])
    cube([50, 5, 10]);

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
        cube([35, 34, 3]);
        translate([42.2/2 - (40.2-35), 11, -0.5])
        cylinder(h = 20, d = 10);
    }
    
    mounting_rail();
    translate([0, 29.2])
    mounting_rail();
    bearing();
    
    module bearing() {
        difference() {
            union () {
                translate([30, 0, 3])
                cube([5, 34, 13]);
                
                translate([20, 0, 14])
                cube([12, 4.8, 2]);
                
                translate([20, 29.2, 0])
                cube([12, 4.8, 16]);
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

    %translate([4, 5, 3])
    micro_servo();
}

// use this for centering the hole
module axis() {
    $fn = 20;
    translate([35, 11, 9.5])
    rotate([0, -90])
    cylinder(h = 40.2, d = 4);
}
