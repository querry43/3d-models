platform();
usb_cable_block();


module usb_cable_block() {
    difference() {
        translate([0, 0, 4.96])
        cube([4.64+7.68, 28.89+5+5, 7.74]);
        
        translate([0, 2.64/2, 4.96])
        usb_plugs();
    }

    module usb_plugs() {
        usb_plug();
        translate([0, 16.12+3])
        usb_plug();

        module usb_plug() {
            translate([0, 2.32, 2])
            cube([4.65, 13.25, 5.75]);
            translate([4.65, 0])
            cube([7.68, 17.33, 10]);
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
