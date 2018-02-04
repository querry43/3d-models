$fn = 12;
mount();
//quad();

module mount() {
	base();

	difference() {
		hooks();
		rotate([0, 0, 180])
		quad();
	}

	module base() {
		difference() {
			union() {
				hull() {
						translate([0, -25, 0])
						cylinder(h=3, d=25);

						translate([12, 0, 0])
						cylinder(h=3, d=20);

						translate([-12, 0, 0])
						cylinder(h=3, d=20);

						translate([0, 40, 0])
						cylinder(h=3, d=44);
				}

				translate([0, 45, 0])
				cylinder(h=6, d=7);
			}

			translate([0, 45, -0.5])
			cylinder(h=7, d=4);
		}
	}

	module hooks() {
		translate([0, -25, 0])
		cylinder(h=22, d=25);

		translate([12, 0, 0])
		cylinder(h=18, d=20);

		translate([-12, 0, 0])
		cylinder(h=18, d=20);
	}
}


module quad() {
	pillar_width=9;
	pillar_distance=75;

	translate([-pillar_distance/2, -pillar_distance/2, 0])
	union() {
		body();

		translate([pillar_width/2, pillar_width/2, 0])
		pillar();

		translate([pillar_distance-pillar_width/2, pillar_width/2, 0])
		pillar();

		translate([pillar_distance-pillar_width/2, pillar_distance-pillar_width/2, 0])
		pillar();

		translate([pillar_width/2, pillar_distance-pillar_width/2, 0])
		pillar();
	}

	module prop() {
		translate([0, 0, 4])
		sphere(d=4);
		rotate([0, 0, 45])
		translate([0, -49/2, 0])
		hull() {
			cylinder(h=3, d=9);
			translate([0, 58-9, 0])
			cylinder(h=3, d=9);
		}
	}

	module pillar() {
		cylinder(h=11, d=pillar_width);
		cylinder(h=23, d=8);
		translate([0, 0, 23])
		prop();
		%translate([0, 0, 8]) cylinder(h=20, d=70);
	}

	module body() {
		hull() {
			translate([pillar_distance/2, pillar_distance/2, 3])
			cylinder(h=17, d=33);

			translate([pillar_distance/2, 9+4, 3])
			cylinder(h=10, d=8);

			translate([pillar_distance/2, 75-11, 9])
			cylinder(h=4, d=12);
		}

		translate([2, 6, 11-6])
		rotate([0, 0, -45])
		cube([6, 95, 6]);

		translate([69, 2, 11-6])
		rotate([0, 0, 45])
		cube([6, 95, 6]);
	}
}