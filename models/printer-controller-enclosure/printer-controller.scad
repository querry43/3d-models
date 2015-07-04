use <button.scad>
use <header.scad>
use <proto-board.scad>

$fn=10;

proto_board();
buttons();
header();


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