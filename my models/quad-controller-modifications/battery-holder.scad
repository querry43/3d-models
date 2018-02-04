$fn=10;



base();

module base() {
	width=62;
	height=40;
	depth=20;
	inner_width=42;
	inner_height=26;
	cap_depth=8;


	difference() {
		union() {
			body();
			screw_holes();

		}
		slots();
	}

	translate([0,0,8])
	rotate([180,0,0])
	cap();

	module body() {
		hull() {
			translate([3/2+6.5,3/2,0])
			cylinder(h=3, d=3);

			translate([3/2+6.5,height-3/2,0])
			cylinder(h=3, d=3);

			translate([width-3/2-6.5,3/2,0])
			cylinder(h=3, d=3);

			translate([width-3/2-6.5,height-3/2,0])
			cylinder(h=3, d=3);
		}

		translate([(width-inner_width)/2,(height-inner_height)/2,0])
		cube([inner_width,inner_height,depth]);
	}

	module cap() {
		translate([(width-inner_width)/2,(height-inner_height)/2,0])
		difference() {
			union() {
				cube([inner_width,inner_height,cap_depth]);
				translate([-1,-1,+2.5])
				cube([inner_width+2,inner_height+2,cap_depth-2.5]);
			}
			translate([1,1,-0.5])
			cube([inner_width-2,inner_height-2,cap_depth+1]);
		}
	}

	module screw_holes() {
		translate([3+3/2,height-9,0])
		screw_hole();

		translate([width-3-3/2,9,0])
		screw_hole();

		module screw_hole() {
			difference() {
				cylinder(h=3, d=9);
				translate([0,0,-0.5])
				cylinder(h=4, d=3);
			}
		}
	}



	module slots() {
		for (i = [2:10:32]) {
			translate([(width-42)/2+i,(height-24)/2,0])
			slot();
		}

		module slot() {
			translate([0,0,-0.5])
			cube([8,26-2,depth-1]);
		}
	}
}