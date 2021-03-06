difference() {
    back_plate();
    translate([7.7, -0.1, 44.3]) power_jack(d=10);
    translate([-(99.8-125)/2, 1.5, 5.5]) indent(d=10);
    translate([33.7, 10, 37.6]) rotate([-180, 0, 0]) pi_plugs(d=11);
}

//#measure();

module measure() {
    // power jack
    translate([0.75, 8, 45.5])
    cube([7, 0.25, 0.25]);
    translate([10, 6.5, 54.8])
    cube([0.25, 0.25, 8]);
    translate([0.75+7, 8, 49.5])
    cube([14.5, 0.25, 0.25]);

    // hdmi
    translate([0, 2, 32])
    cube([33.25, 0.25, 0.25]);
    translate([40, 2, 2.4])
    cube([0.25, 0.25, 29.25]);
}

module indent(d=1) {
    $fn = 20;
    
    hull() {
        for (x = [2/2, 99.8-2/2]) {
            for (z = [2/2, 36.2-2/2]) {
                translate([x, 0, z]) rotate([-90, 0, 0]) cylinder(d=2, h=d);
            }
        }
    }
}

module pi_plugs(d=1) {
    $fn = 20;
    
    hull() {
        translate([-0.5, 0, 5.6-4.2]) cube([16, d, 4.7]);
        translate([-(11.3-15)/2, 0, 0]) cube([11.3, d, 0.1]);
    }

    translate([32-6/2, 0, 6/2]) rotate([-90, 0, 0]) cylinder(d=6.5, h=d);
}

module power_jack(d=1) {
    $fn = 20;
    hull() {
        cube([0.1, d, 10.5]);
        translate([14.6-(10.5/2), 0, 10.5/2]) rotate([-90, 0, 0]) cylinder(d=10.5, h=d);
    }
}

module back_plate() {
    translate([]) cube([125, 5.1, 2.5]);

    hull() {
        translate([0, 0, 2.5]) cube([125, 8.7, 0.1]);
        translate([-(126.2-125)/2, 0, 17]) cube([126.2, 9.2, 0.1]);
    }

    hull() {
        translate([-(126.2-125)/2, 0, 17]) cube([126.2, 9.2, 0.1]);
        translate([-(121.8-125)/2, 0, 62.7]) cube([121.8, 6.1, 0.1]);
    }
    
    translate([-(87.9-125)/2, 0, 62.7]) cube([87.9, 3.8, 2.6]);

    hull() {
        translate([-(132.9-125)/2, 0, 16.8]) cube([132.9, 5.1, 0.1]);
        translate([-(129-125)/2, 0, 62.7]) cube([129, 3.1, 0.1]);
    }
}