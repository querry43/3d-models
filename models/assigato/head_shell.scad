shell();
translate([0, 0, -65/2])
cylinder(h = 20, d = 45);


module shell() {
    hull() {
        for(x = [-90:2:90]) {
            cross_section(x, $fn = 20);
        }
    }
}

module cross_section(x, height = 65, length = 90, $fn = 15) {
    y = sqrt(pow(height/2, 2) - (pow(height/2, 2)*pow(x, 2))/pow(length/2, 2));
    translate([x, 0])
    rotate([0, 90])
    cylinder(h = 0.1, r = y);
}