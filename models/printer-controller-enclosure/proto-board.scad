$fn=10;

proto_board();

module proto_board() {
	width=53.5;
	height=33.5;
	thickness=1.5;

	difference() {
		footprint();
		mounting_holes();
	}

	module footprint() {
		d=11;
		hull() {
			translate([d/2,d/2,0])
			cylinder(h=thickness, d=d);

			translate([d/2,height-d/2,0])
			cylinder(h=thickness, d=d);

			translate([width-d/2,d/2,0])
			cylinder(h=thickness, d=d);

			translate([width-d/2,height-d/2,0])
			cylinder(h=thickness, d=d);
		}
	}

	module mounting_holes() {
		translate([4.25,4.25,-0.5])
		cylinder(h=thickness+1, d=3.5);

		translate([width-4.25,4.25,-0.5])
		cylinder(h=thickness+1, d=3.5);

		translate([4.25,height-4.25,-0.5])
		cylinder(h=thickness+1, d=3.5);

		translate([width-4.25,height-4.25,-0.5])
		cylinder(h=thickness+1, d=3.5);
	}
}