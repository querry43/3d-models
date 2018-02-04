ladder();

//clamp();
//rotate([0,0,180])
//translate([-100,0,0])
//clamp();


translate([-40,-5,15/2])
rotate([90,0,0])
clamp();

translate([-40,30,15/2])
rotate([90,0,0])
clamp();

module clamp() {
	height=20;
	width=15;
	thickness=7;

	difference() {
		hook();
		hole();
	}

	module hole() {
		translate([0,0,-0.5])
		cylinder(d=5, h=thickness+1);
	}

	module hook() {
		translate([-15/2,-width/2,0])
		cube([20,width,thickness]);

		translate([6,-width/2,0])
		cube([thickness,width,height]);

		translate([6,-width/2,height])
		cube([20,width,thickness]);
	}
}

module ladder() {
	height=20;

	rungs();
	sides();
	supports();

	module rungs() {
		for (i = [0:100/3:100]) {
			translate([i,0,0])
			rung();
		}

		for (i = [0:100/3:100]) {
			translate([i,0,0])
			rotate([0,0,180])
			rung();
		}
	}

	module sides() {
		translate([-5,10,0])
		cube([110,3,height]);

		translate([-5,-13,0])
		cube([110,3,height]);
	}

	module supports() {
		translate([15,-25/2,0])
		cube([3,25,height]);

		translate([100-15-3,-25/2,0])
		cube([3,25,height]);

		translate([35,-25/2,0])
		cube([3,25,height]);

		translate([100-35-3,-25/2,0])
		cube([3,25,height]);
	}
}

module rung() {
	length=60;
	height=3;
	width=10;
	support_height=2;
	support_width=2;

	translate([-width/2,10,0])
	cube([width,50,height]);

	hull() {
		translate([-10,length,0])
		cylinder(d=width, h=height);
		translate([10,length,0])
		cylinder(d=width, h=height);
	}

	hull() {
		translate([-10,length,height])
		cylinder(d=support_width, h=support_height);

		translate([10,length,height])
		cylinder(d=support_width, h=support_height);

		translate([-10,length,height+support_height])
		sphere(d=support_width);

		translate([10,length,height+support_height])
		sphere(d=support_width);
	}

	hull() {
		translate([0,length,height])
		cylinder(d=support_width, h=support_height);

		translate([0,11,height])
		cylinder(d=support_width, h=support_height);

		translate([0,length,height+support_height])
		sphere(d=support_width);

		translate([0,11,height+support_height])
		sphere(d=support_width);
	}
}

module footprint() {
	height=7;
	difference() {
		hull() {
			cylinder(d=25, h=height);

			translate([100,0,0])
			cylinder(d=25, h=height);
		}

		translate([0,0,-0.5])
		cylinder(d=5, h=height+1);

		translate([100,0,-0.5])
		cylinder(d=5, h=height+1);
	}
}