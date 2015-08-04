length=70;
width=30;
height=6;

slot_width=4.2;
slot_length=10.1;

neck_dia=12.5;
sensor_dia=19;

$fn=30;

groove_plate();
sensor_holder();

translate([-length/2,width+10])
sensor_holder();

module sensor_holder() {
	margin=4;
	width=width+(margin*2);

	translate([0,-margin])
	difference() {
		base();
		sensor_hole();
		screw_holes();
	}

	module base() {
		hull() {
			translate([length,2])
			cylinder(h=height, d=4);
			translate([length,width-2])
			cylinder(h=height, d=4);

			translate([100+4,2])
			cylinder(h=height, d=4);
			translate([100+4,width-2])
			cylinder(h=height, d=4);
		}
	}

	module sensor_hole() {
		$fn=50;
		translate([85+4,width/2,-0.5])
		union() {
			cylinder(h=height+1, d=sensor_dia);
			%cylinder(h=height+1, d=30);
		}
	}

	module screw_holes() {
		translate([length+2+4,margin,-0.5])
		cylinder(h=height+1,d=4);
		translate([length+28+4,margin,-0.5])
		cylinder(h=height+1,d=4);

		translate([length+2+4,width-margin,-0.5])
		cylinder(h=height+1,d=4);
		translate([length+28+4,width-margin,-0.5])
		cylinder(h=height+1,d=4);
	}
}

module groove_plate() {
	difference() {
		base();
		translate([10,width/2])
		slot();
		translate([length-10,width/2])
		slot();
		translate([length/2,width/2])
		groove();
	}

	module base() {
		hull() {
			translate([2,2])
			cylinder(h=height, d=4);
		
			translate([length-2,2])
			cylinder(h=height, d=4);
		
			translate([2,width-2])
			cylinder(h=height, d=4);
		
			translate([length-2,width-2])
			cylinder(h=height, d=4);
		}
	}

	module slot() {
		translate([slot_width/2-slot_length/2,0])
		hull() {
			translate([0,0,-0.5])
			cylinder(h=height+1, d=slot_width);

			translate([slot_length-slot_width,0,-0.5])
			cylinder(h=height+1, d=slot_width);
		}
	}

	module groove() {
		translate([0,1,-0.5])
		hull() {
			cylinder(h=height+1, d=neck_dia);
			translate([-neck_dia/2,-20])
			cube([neck_dia,1,height+1]);
		}
	}
}