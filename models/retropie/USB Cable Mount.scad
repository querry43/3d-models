usb_cable_mounting_block();
retaining_clip();

module retaining_clip(clip_depth = 3.5) {
    translate([0, -0.5, 11.3])
    union() {
        spring_height = 1.5;
        cube([clip_depth, 28.89+5+5+1, spring_height]);
        
        translate([0, 5, -0.5])
        cube([clip_depth, 11.5, 1]);

        translate([0, 24, -0.5])
        cube([clip_depth, 11.5, 1]);

        translate([0, 0, 3])
        cube([clip_depth, 28.89+5+5+1, spring_height]);
    }

    translate([0, -2.5, 6.1])
    union() {
        cube([clip_depth, 2, 4.7+5]);
        translate([0, 28.89+5+5+1+2, 0])
        cube([clip_depth, 2, 4.7+5]);
    }
    
    union() {
        $fn = 20;
        clip_radius = 4.55;
        
        difference() {
            translate([0, -1.8, 8])
            rotate([0, 90])
            cylinder(h=clip_depth, d=clip_radius);
            
            translate([0, -6.5, 0])
            cube([4, 4, 15]);
        }

        difference() {
            translate([0, 28.89+5+5+0.4+1.3, 8])
            rotate([0, 90])
            cylinder(h=clip_depth, d=clip_radius);
            
            translate([0, 28.89+5+5+2.5, 0])
            cube([4, 4, 15]);
        }
    }
}

module usb_cable_mounting_block() {
    difference() {
        union() {
            platform();
            usb_cable_block();
        }

        translate([0, 2.64/2, 2.96])
        usb_plugs();
        
        translate([19, 3, 2.96])
        cube([10, 10, 10]);

        translate([16, 27, 2.96])
        cube([12, 10, 10]);
    }

    module usb_cable_block() {
        difference() {
            translate([0, 0, 2.96])
            cube([4.64+7.68, 28.89+5+5, 7.74]);
            
            union() {
                $fn = 20;
                
                translate([0, -1.5, 8])
                rotate([0, 90])
                cylinder(h=4, d=5);
                
                translate([0, 28.89+5+5+1.5, 8])
                rotate([0, 90])
                cylinder(h=4, d=5);
            }
        }
    }

    module usb_plugs() {
        usb_plug();
        translate([0, 16.12+3])
        usb_plug();

        module usb_plug() {
            translate([0, 2.32, 2])
            cube([4.65, 13.25, 5.75]);
            hull() {
                translate([4.65, 0])
                cube([10, 17.33, 10]);
                translate([24.34, (17.33-10)/2, 0])
                cube([0.1, 10, 10]);
            }
            translate([24.34, (17.33-10)/2])
            cube([9, 10, 10]);
        }
    }
}

module platform() {
    difference() {
        cube([22.58+5, 28.89+5+5, 4.96]);

        translate([0, 5]) {
            translate([22.58, 1])
            cylinder(h=5, d=3);

            hull() {
                cube([14.80, 2, 2.64]);
                translate([0, -2])
                cube([5, 4, 2.64]);
            }
        }

        translate([0, 5+28.89]) {
            translate([22.58, 1])
            cylinder(h=5, d=3);

            hull() {
                cube([14.80, 2, 2.64]);
                cube([5, 4, 2.64]);
            }
        }
    }
}
