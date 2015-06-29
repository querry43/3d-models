overall_width = 155;
overall_height = 141;
overall_depth = 49;

center_line = overall_width/2;

$fn = 12;

//%bounding_box();

//color("SlateGray")
//back_plate();
//
//translate([overall_width/2, 72, overall_depth+1])
//rotate([0, 0, 180])
//quad();

mount();

module mount() {
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



	difference() {
		union() {
			translate([0, -25, 0])
			cylinder(h=22, d=25);
		
			translate([12, 0, 0])
			cylinder(h=18, d=20);
		
			translate([-12, 0, 0])
			cylinder(h=18, d=20);
		}
	
		rotate([0, 0, 180])
		quad();
	}
}


module bounding_box() {
	cube([overall_width, overall_height, overall_depth]);
	translate([center_line-0.5, 0, 0])
	cube([1, overall_height, overall_depth]);
}

module back_plate() {
	lower_width = 104.5;
	lower_height = 71;

	upper_width = 41;
	upper_height = 134;

	bevel_width = 2;

	depth = 6;

	difference() {
		union() {
			hull() {
				lower_plate();
				lower_plate_bevel();
			}
			hull() {
				upper_plate();
				upper_plate_bevel();
			}
			fillets();

		}

		// this mask can be removed later
		cube([overall_width, overall_height, overall_depth-depth]);
	}


	module lower_plate() {
		hull() {
			difference() {
				translate([center_line-lower_width/2, depth, overall_depth-depth])
				rotate([0, 90, 0])
				cylinder(h = lower_width, r = depth);
	
			}
			
			translate([center_line-lower_width/2+2, 71-2, overall_depth-depth])
			cylinder(h = depth, r = 2);
		
			translate([center_line+lower_width/2-2, 71-2, overall_depth-depth])
			cylinder(h = depth, r = 2);
		}
	}

	module lower_plate_bevel() {
		lower_width = lower_width+bevel_width*2;
		translate([center_line-lower_width/2, 0, overall_depth-depth-1])
		cube([lower_width, lower_height+bevel_width, 1]);
	}

	module upper_plate() {
		hull() {
			translate([center_line-upper_width/2+1, upper_height-1, overall_depth-depth])
			cylinder(h = depth, r = 1);
		
			translate([center_line+upper_width/2-1, upper_height-1, overall_depth-depth])
			cylinder(h = depth, r = 1);
		
			translate([center_line-upper_width/2, 10, overall_depth-depth])
			cube([upper_width, 10, depth]);
		}
	}

	module upper_plate_bevel() {
		upper_width = upper_width+bevel_width*2;
		translate([center_line-upper_width/2, 0, overall_depth-depth-1])
		cube([upper_width, upper_height+bevel_width, 1]);
	}

	module fillets() {
		// left
		translate([center_line-upper_width/2-2, lower_height, overall_depth-depth])
		difference() {
			cube([2, 2, depth]);
	
			translate([0, 2, 0])
			cylinder(h = depth, r = 2);
		}

		// right
		translate([center_line+upper_width/2, lower_height, overall_depth-depth])
		difference() {
			cube([2, 2, depth]);
	
			translate([2, 2, 0])
			cylinder(h = depth, r = 2);
		}
	}
}

module quad() {
	pillar_width=9;
	pillar_distance=75;

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
			cylinder(h=17, d=32);
	
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
}