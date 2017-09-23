use <../openscad_libraries/robotics.scad>
use <head_pan_tilt.scad>

difference() {
    shell();

    translate([-25/2, -29, -9])
    rotate([90, 0])
    raspberry_pi_cam();
    
    translate([-25/2, -35, -20])
    cube([25, 10, 4]);
    
    $fn = 10;
    
    translate([-18, -25, 13])
    rotate([90, 0])
    cylinder(h = 10, d = 5);
    
    translate([18, -25, 13])
    rotate([90, 0])
    cylinder(h = 10, d = 5);
}



translate([-17, -10, -10])
head_pan_tilt_assembly(upright = true);




module shell() {
    hull() {
        for(x = [-115:1:115]) {
            cross_section(x, $fn = 25);
        }
    }
}

module cross_section(x, height = 75, length = 110, $fn = 15) {
    y = sqrt(pow(height/2, 2) - (pow(height/2, 2)*pow(x, 2))/pow(length/2, 2));
    translate([x, 0])
    rotate([0, 90])
    cylinder(h = 0.1, r = y);
}