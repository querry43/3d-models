difference() {
    $fn = 10;
    cylinder(h = 11, d = 9.5);

    translate([-5, 4, -0.5])
    cube([10, 10, 12]);

    translate([-7.5/2, -3.5/2, -1])
    cube([7.5, 3.5, 8]);
}

translate([-5.5/2, -5.5/2, 11])
cube([5.5, 5.5, 8]);