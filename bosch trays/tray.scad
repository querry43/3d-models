module rounded_rectangle(size, r = 4, $fn = 20) {
	translations = [
		[r,         r,         0],
		[size[0]-r, r,         0],
		[size[0]-r, size[1]-r, 0],
		[r,         size[1]-r, 0]
	];

	hull() {
		for (v = translations) {
			translate(v = v)
			cylinder(h = size[2], r = r);
		}
	}
}

module tray_box(size, r = 4) {
	translate(v = [1, 1, 0])
	rounded_rectangle(size = [size[0]-2, size[1]-2, size[2]], r = r);
}

module tray_interior(size) {
	translate(v = [1.5, 1.5, 1.5])
	tray_box(size = [size[0]-3, size[1]-3, size[2]-1], r = 2.7);
}

module tray_lip(size, height = 4) {
	hull() {
		translate(v = [0, 0, size[2]-height])
		rounded_rectangle(size = [size[0], size[1], height], r = 5);
	
		translate(v = [1, 1, size[2]-height-2])
		rounded_rectangle(size = [size[0]-2, size[1]-2, 1]);
	}
}

module tray(size = [52, 52, 44], center = false) {
	translate(v = [
		center ? -size[0]/2 : 0,
		center ? -size[1]/2 : 0,
		center ? -size[2]/2 : 0
	])
	difference() {
		union() {
			tray_box(size = size);
			tray_lip(size = size);
		}
		tray_interior(size = size);
	}
}

tray();