use <../openscad_libraries/robotics.scad>
use <head_pan_tilt.scad>

%difference() {
    shell();
    
    scale([0.9, 0.9, 0.9])
    shell();

    translate([-25/2, -28, -9])
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



translate([-17, -11, -10])
head_pan_tilt_assembly(pan_angle = 0, tilt_angle = 90);

translate([-25/2, -27, -9])
rotate([90, 0])
raspberry_pi_cam();




module shell() {
    hull() {
        for(x = [-115:5:115]) {
            cross_section(x);
        }
    }
}

module cross_section(x, height = 75, length = 110, $fn = 15) {
    y = sqrt(pow(height/2, 2) - (pow(height/2, 2)*pow(x, 2))/pow(length/2, 2));
    translate([x, 0])
    rotate([0, 90])
    cylinder(h = 0.1, r = y);
}