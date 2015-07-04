$fn=10;

button();

module button() {
	overall_width=12;
	overall_thickness=16.5;

	cap();
	neck();
	base();
	legs();

	module cap() {
		cap_d1=11.5;
		cap_d2=13;
		cap_height1=5.75;
		cap_height2=1.5;

		translate([overall_width/2,overall_width/2,overall_thickness-cap_height1])
		union() {
			cylinder(d=cap_d1, h=cap_height1);
			cylinder(d=cap_d2, h=cap_height2);
		}
	}

	module neck() {
		width=3;
		translate([overall_width/2-width/2,overall_width/2-width/2,5])
		cube([width,width,overall_thickness-5]);
	}

	module base() {
		thickness=5;
		translate([0,0,3])
		cube([overall_width,overall_width,thickness]);
	}

	module legs() {
		thickness=3;
		translate([-0.5,3.5,0])
		cylinder(d=1, h=thickness+2);
		translate([-0.5,overall_width-3.5,0])
		cylinder(d=1, h=thickness+2);

		translate([overall_width+0.5,3.5,0])
		cylinder(d=1, h=thickness+2);
		translate([overall_width+0.5,overall_width-3.5,0])
		cylinder(d=1, h=thickness+2);
	}
}