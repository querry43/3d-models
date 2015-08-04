use <button.scad>
use <header.scad>
use <proto-board.scad>

$fn=15;

//printer_controller();

translate([0,0,5])
lower_shell();

translate([0,82,12])
rotate([180,0,0])
upper_shell();


length=75;
lower_shell_thickness=10;
upper_shell_thickness=7;
height=33.5+10;

outer_shell_d=5;
inner_shell_d=4;

module upper_shell() {
	difference() {
		outer_shell();
		inner_shell();
		button_holes();
		cable_slot();
		indicators();
	}
	pegs();

	module outer_shell() {
		d=outer_shell_d;
		translate([-3,-3,5])
		hull() {
			translate([0,0,0])
			cylinder(h=upper_shell_thickness, d=d);
			translate([0,height-4,0])
			cylinder(h=upper_shell_thickness, d=d);
			translate([length-4,0,0])
			cylinder(h=upper_shell_thickness, d=d);
			translate([length-4,height-4,0])
			cylinder(h=upper_shell_thickness, d=d);
		}
	}

	module inner_shell() {
		d=inner_shell_d;
		translate([-3,-3,4])
		hull() {
			translate([2,2,0])
			cylinder(h=upper_shell_thickness, d=d);
			translate([2,height-4-2,0])
			cylinder(h=upper_shell_thickness, d=d);
			translate([length-4-2,2,0])
			cylinder(h=upper_shell_thickness, d=d);
			translate([length-4-2,height-4-2,0])
			cylinder(h=upper_shell_thickness, d=d);
		}
	}

	module pegs() {
		translate([4.25,4.25,1.5])
		supported_pin();

		translate([4.25,29.25,1.5])
		rotate([0,0,-90])
		supported_pin();

		translate([49.75,4.25,1.5])
		rotate([0,0,90])
		supported_pin();

		translate([49.75,29.25,1.5])
		rotate([0,0,-180])
		supported_pin();
	}

	module supported_pin() {
		peg(9.5);
		translate([-8,-1,5])
		cube([5,2,5]);
		translate([-1,-8,5])
		cube([2,5,5]);
	}

	module button_holes() {
		d=13.5;
		translate([7.5,15.5,10])
		cylinder(h=3, d=d);
		translate([22.75,15.5,10])
		cylinder(h=3, d=d);
		translate([38,15.5,10])
		cylinder(h=3, d=d);
	}

	module cable_slot() {
		translate([67,height/2-5,6])
		rotate([0,90,0])
		hull() {
			translate([0,0,0])
			cylinder(h=4, d=3);
			translate([0,-3/2,0])
			cube([3,3,4]);
		}
	}

	module indicators() {
		translate([7.5,29,11.5])
		cylinder(h=1, d=7);

		translate([22.75,29,11.5])
		union() {
			hull() {
				translate([2,2,0])
				cylinder(h=1, d=1);
				translate([-2,-2,0])
				cylinder(h=1, d=1);
			}
			hull() {
				translate([-2,2,0])
				cylinder(h=1, d=1);
				translate([2,-2,0])
				cylinder(h=1, d=1);
			}
		}
		

		translate([38,29,11.5])
		difference() {
			cylinder(h=1, d=7);
			cylinder(h=1, d=6);
		}
	}
}

module lower_shell() {
	difference() {
		outer_shell();
		inner_shell();
		screw_holes();
	}
	pegs();

	module outer_shell() {
		d=outer_shell_d;
		translate([-3,-3,-5])
		hull() {
			translate([0,0,0])
			cylinder(h=lower_shell_thickness, d=d);
			translate([0,height-4,0])
			cylinder(h=lower_shell_thickness, d=d);
			translate([length-4,0,0])
			cylinder(h=lower_shell_thickness, d=d);
			translate([length-4,height-4,0])
			cylinder(h=lower_shell_thickness, d=d);
		}
	}

	module inner_shell() {
		d=inner_shell_d;
		translate([-3,-3,-4])
		hull() {
			translate([2,2,0])
			cylinder(h=lower_shell_thickness, d=d);
			translate([2,height-4-2,0])
			cylinder(h=lower_shell_thickness, d=d);
			translate([length-4-2,2,0])
			cylinder(h=lower_shell_thickness, d=d);
			translate([length-4-2,height-4-2,0])
			cylinder(h=lower_shell_thickness, d=d);
		}
	}


	module pegs() {
		translate([4.25,4.25,-5])
		peg(4.9);

		translate([4.25,29.25,-5])
		peg(4.9);

		translate([49.75,4.25,-5])
		peg(4.9);

		translate([49.75,29.25,-5])
		peg(4.9);
	}

	module screw_holes() {
		translate([4.25,4.25,-8])
		cylinder(h=6, d=4);

		translate([4.25,29.25,-8])
		cylinder(h=6, d=4);

		translate([49.75,4.25,-8])
		cylinder(h=6, d=4);

		translate([49.75,29.25,-8])
		cylinder(h=6, d=4);
	}
}

module peg(h) {
	difference() {
		cylinder(h=h, d=7);
		translate([0,0,-0.5])
		cylinder(h=h+1, d=4);
	}
}

module bounding_box() {
	%translate([-5,-5,-5])
	cube([75,33.5+10,17]);
}

module printer_controller() {
	proto_board();
	buttons();
	header();
}

module buttons() {
	translate([1.6,9.3,-1.4])
	button();

	translate([16.75,9.3,-1.4])
	button();

	translate([32,9.3,-1.4])
	button();
}

module header() {
	translate([50.5,11.5,-1.3])
	right_angle_header(4);
}