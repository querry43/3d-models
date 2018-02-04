needle_holder();

%translate([0, 0, -20])
frame_and_needle();

module needle_holder($fn=30) {
    difference() {
        translate([(21-25)/2, (19-25)/2])
        cube([25, 25, 20]);
        
        translate([-5, 0, -1])
        cube([26, 19, 100]);
    }

    translate([-1.25, -0.25, 0])
    cylinder(h=20, d=1.5);

    translate([-1.25, 19.25, 0])
    cylinder(h=20, d=1.5);
    
    translate([21, 19/2, 0])
    difference() {
        cylinder(h=20, d=25);

        translate([-100, -50, -1])
        cube([100, 100, 100]);

        translate([25/2, 0, -0.5])
        cylinder(h=26, d=5);
        
        translate([8, 0, -0.5])
        cylinder(h=26, d=10.5);
    }
}

module frame_and_needle() {
    cube([21, 19, 100]);

    translate([29, 19/2])
    cylinder(h=140, d=10);
}