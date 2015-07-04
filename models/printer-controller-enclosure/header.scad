$fn=10;

right_angle_header(3);

module right_angle_header(num_pins=1) {
	for (i = [1:num_pins]) {
		translate([0,(i-1)*2.54,0])
		one_pin();
	}

	module one_pin() {
		pin_d=0.5;

		translate([0,0,3])
		cube([3,3,3.75]);

		translate([3/2,3/2,0])
		cylinder(h=7.5, d=pin_d);

		translate([3/2,3/2,7.5])
		rotate([0,90,0])
		cylinder(h=8, d=pin_d);

		translate([3/2,3/2,7.5])
		sphere(d=pin_d);
	}
}