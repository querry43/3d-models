use <MCAD/involute_gears.scad>

// dia = (number_of_teeth + 2) / (180 / 500)
module flat_gear(number_of_teeth) {
	gear(
		circular_pitch = 500,
		number_of_teeth = number_of_teeth,
		gear_thickness = 4,
		rim_thickness = 4,
		hub_thickness = 4,
		bore_diameter = 2
	);

}

module gear_wheel() {
	difference() {
		union() {
			// dia = 80.56
			flat_gear(
				number_of_teeth = 27
			);
	
			translate(v = [0, 0, 4])
			difference() {
				cylinder(h = 5, r = 35);
				cylinder(h = 5, r = 1);
			}
		}
	
		for (i = [0 : 36 : 359]) {
			rotate(a = i)
				translate(v = [0, 25, 0])
				cylinder(h = 9, r = 6);
		}
	}
}

module pinion() {
	// dia = 25
	flat_gear(
		number_of_teeth = 7
	);
	
	translate(v = [8, 0, 2])
	cylinder(h = 15, r = 2);
}

module ball_channel(length, diverter = false, endcap = false, mask = false) {
	translate(v = [-(16/2), -(length/2), (8/2)])
	rotate(a = -90, v = [1, 0, 0])
	union() {
		difference() {
			cube(
				size = [16, 8, length]
			);
			
			translate(v = [8, 0, 0])
			cylinder(
				h = length,
				r = 6,
				$fn = 100
			);
	
			if (diverter) {
				polyhedron(
					points = [
						[0, 0, 0],
						[16, 0, 0],
						[16, 8, 0],
						[0, 8, 0],
						[0, 0, 16],
						[0, 8, 16]
					],
					faces = [
						[0, 1, 2, 3],
						[0, 4, 1],
						[3, 2, 5],
						[0, 3, 5, 4],
						[1, 4, 5, 2]
					]
				);
	
				translate(v = [8, 0, 0])
				cube(
					size = [8, 6, 25]
				);
			}
		}

		if (mask && diverter) {
			translate(v = [8, 0, sqrt(2*2+2*2)])
			cube(
				size = [8*2, 6, 25]
			);
		}
	
		if (diverter) {
			difference() {
				translate(v = [0, 0, 16])
				rotate(a = 45, v = [0, 1, 0])
				cube(
					size = [sqrt(16*16+16*16), 8, 2]
				);
	
				translate(v = [16, 0, 0])
				cube(size = [2, 8, 3]);
			}
		}

		if (endcap) {
				translate(v = [0, 0, length])
				cube(
					size = [16, 8, 2]
				);

		}
	}
}

module position_ball_channel(angle, level = 0) {
	translate(v = [16*level, 0, 8*level])
	rotate(a = angle, v = [1, 0, 0])
	children();
}


module ball_ladder() {
	position_ball_channel(angle = 3, level = 3)
	translate(v = [0, 2.5, 0])
	mirror([1, 0, 0])
	ball_channel(length = 80, diverter = true);
	
	difference() {
		position_ball_channel(angle = -3, level = 2)
		translate(v = [0, -5, 0])
		rotate(a = 180, v = [0, 0, 1])
		ball_channel(length = 75, diverter = true, endcap = true);
	
		position_ball_channel(angle = 3, level = 3)
		translate(v = [0, 2.5, 0])
		mirror([1, 0, 0])
		ball_channel(length = 80, diverter = true, mask = true);
	}
	
	difference() {
		position_ball_channel(angle = 3, level = 1)
		mirror([1, 0, 0])
		ball_channel(length = 75, diverter = true, endcap = true);
	
		position_ball_channel(angle = -3, level = 2)
		translate(v = [0, -5, 0])
		rotate(a = 180, v = [0, 0, 1])
		ball_channel(length = 75, diverter = true, endcap = true, mask = true);
	}
	
	difference() {
		position_ball_channel(angle = -3)
		translate(v = [0, 25/2, 0])
		mirror([0, 1, 0])
		ball_channel(length = 85+25, endcap = true);
	
		position_ball_channel(angle = 3, level = 1)
		mirror([1, 0, 0])
		ball_channel(length = 75, diverter = true, endcap = true, mask = true);
	}
}

module ball_ladder_support() {
	polyhedron(
		points = [
			// back points
			[16*3+8, 80/2+2.6, 8*3-1.5],
			[16*3+8, 80/2+2.6, -28.5],
			[16*3-8, 80/2+2.6, 8*3-1.5],
			[16*3-8, 80/2+2.6, -28.5],

			// front points
			[16*3+8, -80/2+18.5, 8*3-5],
			[16*3+8, -80/2+18.5, -28.5],
			[16*3-8, -80/2+3, 8*3-6],
			[16*3-8, -80/2+3, -28.5],
		],
		faces = [
			[0, 2, 3, 1],
			[6, 4, 5, 7],
			[4, 0, 1, 5],
			[2, 6, 7, 3],
			[1, 3, 7, 5],
			[6, 2, 0, 4]
		]
	);

	polyhedron(
		points = [
			// back points
			[16*2+8, 75/2-21.5, 8*2-4.5],
			[16*2+8, 75/2-21.5, -28.5],
			[16*2-8, 75/2-5, 8*2-5.5],
			[16*2-8, 75/2-5, -28.5],

			// front points
			[16*2+8, -75/2-7.2, 8*2-1.5],
			[16*2+8, -75/2-7.2, -28.5],
			[16*2-8, -75/2-7.2, 8*2-1.5],
			[16*2-8, -75/2-7.2, -28.5],
		],
		faces = [
			[0, 2, 3, 1],
			[6, 4, 5, 7],
			[4, 0, 1, 5],
			[2, 6, 7, 3],
			[1, 3, 7, 5],
			[6, 2, 0, 4]
		]
	);

	polyhedron(
		points = [
			// back points
			[16*1+8, 75/2+2, 8*1-1.75],
			[16*1+8, 75/2+2, -28.5],
			[16*1-8, 75/2+2, 8*1-1.75],
			[16*1-8, 75/2+2, -28.5],

			// front points
			[16*1+8, -75/2+16.5, 8*1-5],
			[16*1+8, -75/2+16.5, -28.5],
			[16*1-8, -75/2, 8*1-6],
			[16*1-8, -75/2, -28.5],
		],
		faces = [
			[0, 2, 3, 1],
			[6, 4, 5, 7],
			[4, 0, 1, 5],
			[2, 6, 7, 3],
			[1, 3, 7, 5],
			[6, 2, 0, 4]
		]
	);

	polyhedron(
		points = [
			// back points
			[16*0+8, 80/2+27.25, 8*0-7.25],
			[16*0+8, 80/2+27.25-10, -28.5],
			[16*0-8, 80/2+27.25, 8*0-7.25],
			[16*0-8, 80/2+27.25-10, -28.5],

			// front points
			[16*0+8, -80/2-4.7, 8*0-1.5],
			[16*0+8, -80/2-4.7, -28.5],
			[16*0-8, -80/2-4.7, 8*0-1.5],
			[16*0-8, -80/2-4.7, -28.5],
		],
		faces = [
			[0, 2, 3, 1],
			[6, 4, 5, 7],
			[4, 0, 1, 5],
			[2, 6, 7, 3],
			[1, 3, 7, 5],
			[6, 2, 0, 4]
		]
	);
}

//gear_wheel();
//translate(v = [55, 0, 0])
pinion();

//ball_ladder();
//color([0, 1, 1])
//ball_ladder_support();

//color([1, 0, 1])
//translate(v = [16*0+8, -80/2-4.5, 8*0-1.5])
//cube(size=[0.5, 0.5, 0.5], center = true);