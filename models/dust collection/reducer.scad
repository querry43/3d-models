hose(id=52, od=62, height=50);

module hose(id=10, od=15, height=10) {
    difference() {
        $fn = 60;
        cylinder(d=od, h=height);
        translate([0, 0, -0.5])
        cylinder(d=id, h=height+1);
    }
}