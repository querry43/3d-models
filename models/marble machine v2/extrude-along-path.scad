module ramp(length = 1) {
	translate(v = [0, 0, 2.5])
	rotate(a = 90, v = [0, 0, 1])
	rotate(a = 90, v = [1, 0, 0])
	linear_extrude(height = length)
	difference() {
		circle(d = 5, $fn = 20);
		circle(d = 3, $fn = 20);
		translate(v = [-2.5, 0, 0])
		square(size = [5, 2.5]);
	}
}

module positioned_ramp(points, debug = false) {
	if(points[0][0] > points[1][0]) {
		_positioned_ramp(
			points = [
				points[1],
				points[0]
			],
			debug = debug
		);
	} else {
		_positioned_ramp(
			points = points,
			debug = debug
		);
	}
}

module _positioned_ramp(points, debug = false, fudge = 0.5) {
	length = sqrt(
		pow(points[0][0] - points[1][0], 2)
		+ pow(points[0][1] - points[1][1], 2)
		+ pow(points[0][2] - points[1][2], 2)
	) + fudge;

	y_angle = asin(
		(points[1][2] - points[0][2]) / length
	);

	z_angle = atan(
		(points[1][1] - points[0][1]) / (points[1][0] - points[0][0])
	);

	translate(v = points[0])
	rotate(a = z_angle, v = [0, 0, 1])
	rotate(a = y_angle, v = [0, -1, 0])
	translate(v = [fudge/-2, 0, 0])
	ramp(length = length);

	if (debug) {
		echo("length",  length);
		echo("y_angle", y_angle);
		echo("z_angle", z_angle);

		color([1, 0, 1])
		translate(v = points[0])
		translate(v = [0, 0, 5])
		cube(size = [0.25, 0.25, 10], center = true);
		
		color([1, 0, 1])
		translate(v = points[1])
		translate(v = [0, 0, 5])
		cube(size = [0.25, 0.25, 10], center = true);
	}
}

step = 10;
for (i = [0:step:300-step]) {
	positioned_ramp(
		points = [
			[10*cos(i), 10*sin(i), i/50],
			[10*cos(i+step), 10*sin(i+step), (i+step)/50],
		]
	);
}