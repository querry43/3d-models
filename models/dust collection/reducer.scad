reducer();

module reducer() {
    $fn = 40;
    difference() {
        union() {
            cylinder(d=80, h=5);
            hull() {
                cylinder(d=62, h=45);
                cylinder(d=55, h=50);
            }
        }
        translate([0,0,-1])
        cylinder(d=52, h=52);
    }
}