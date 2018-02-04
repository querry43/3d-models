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

gear_wheel();
translate(v = [55, 0, 0])
pinion();