use <MCAD/involute_gears.scad>

bore_diameter = 5.5;
gear_thickness = 6;

// dia = (number_of_teeth + 2) / (180 / 500)
module flat_gear(number_of_teeth, thickness = gear_thickness) {
	gear(
		circular_pitch = 500,
		number_of_teeth = number_of_teeth,
		gear_thickness = thickness,
		rim_thickness = thickness,
		hub_thickness = thickness,
		bore_diameter = bore_diameter
	);
}

module gear_wheel(holes = 9) {
	difference() {
		union() {
			// dia = ?
			color([1, 0, 1])
			flat_gear(
				number_of_teeth = 27
			);
		}
	
		for (i = [0 : 360 / holes : 359]) {
			rotate(a = i)
				translate(v = [0, 28, -1])
				cylinder(h = 11, r = 6);
		}
	}
}

module ring(inner_r, outer_r, h) {
	difference() {
		cylinder(h = h, r = outer_r);
		translate(v = [0, 0, -0.5])
		cylinder(h = h+1, r = inner_r);
	}
}

module inverse_gear_wheel(holes = 3) {
	translate(v = [0, 0, gear_thickness])
	color([0, 1, 0])
	flat_gear(
		number_of_teeth = 9,
		thickness = gear_thickness+1
	);

	color([0, 1, 0])
	difference() {
		cylinder(h = gear_thickness, r = 35);

		cylinder(h = gear_thickness, r = bore_diameter/2);

		translate(v = [0, 0, -0.5])
		ring(inner_r = 21, outer_r = 26, h = gear_thickness-1);

		for (i = [0 : 360 / holes : 359]) {
			rotate(a = i + 180)
				translate(v = [0, 23, -1])
				cylinder(h = 11, r = 7);
		}
	}
}

module gear_wheel_backer() {
	cylinder(h = gear_thickness+2, r = bore_diameter/2-0.5);
	difference() {
		cylinder(h = 1, r = 35);
		translate(v = [0, 51, -0.5])
		cylinder(h = 2, r = 37);
	}
}

module wedge(height, width, length) {
	polyhedron(
		points = [
			[0, 0, 0],
			[length, 0, height],
			[length, 0, 0],

			[0, width, 0],
			[length, width, height],
			[length, width, 0],
		],
		faces = [
			[0, 1, 2],
			[5, 4, 3],
			[1, 4, 5, 2],
			[4, 1, 0, 3],
			[0, 2, 5, 3],
		]
	);
}

module inverse_gear_wheel_backer() {
	cylinder(h = 1, r = 35);

	cylinder(h = (gear_thickness*2)+3, r = bore_diameter/2-0.5);

	translate(v = [-3, 22.5, 0])
	wedge(
		height = gear_thickness,
		width = 2,
		length = 6
	);

	translate(v = [-5, -56, 0])
	cube(size = [10, 30, 1]);

	translate(v = [-5, -56, 0])
	cube(size = [10, 10, gear_thickness+1]);
}


rotate(a = $t * 40, v = [0, 0, 1])
gear_wheel();

translate(v = [0, 0, -2])
gear_wheel_backer();

translate(v = [0, 51, -gear_thickness-1])
rotate(a = ($t * -40 * 3), v = [0, 0, 1])
inverse_gear_wheel();

translate(v = [0, 51, -gear_thickness-3])
inverse_gear_wheel_backer();