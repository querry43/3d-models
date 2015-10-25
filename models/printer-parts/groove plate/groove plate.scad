sensor_dia = 18;


groove_plate();

translate([30+25, 30])
sensor_plate();

translate([10, 35])
sensor_plate();

%translate([50+25, 50, -55])
sensor();


module sensor() {
    cylinder(d = sensor_dia, h = 70);
    translate([0, 0, 50])
    cylinder(d = 32, h = 5);
}

module sensor_plate() {
    length = 40;
    width = 40;
    height = 8;

    difference() {
        plate();
        sensor_hole();
        screw_holes();
    }

    module plate() {
        radius = 5;

        $fn = 8;

        hull() {
            translate([radius/2, radius/2])
            cylinder(d = radius, h = height);
            translate([length - radius/2, radius/2])
            cylinder(d = radius, h = height);
            translate([length - radius/2, width - radius/2])
            cylinder(d = radius, h = height);
            translate([radius/2, width - radius/2])
            cylinder(d = radius, h = height);
        }
    }

    module sensor_hole() {
        margin = 1;
        translate([width/2, length/2, -0.5])
        cylinder(d = sensor_dia + margin, h = height + 1);
    }

    module screw_holes() {
        margin = 3;
        dia = 4;

        $fn = 8;

        translate([margin + dia/2, margin + dia/2])
        screw_hole();

        translate([length - (margin + dia/2), margin + dia/2])
        screw_hole();

        translate([length - (margin + dia/2), width - (margin + dia/2)])
        screw_hole();

        translate([margin + dia/2, width - (margin + dia/2)])
        screw_hole();

        module screw_hole() {
            translate([0, 0, -0.5])
            cylinder(h = height + 1, d = dia);
        }
    }
}

module groove_plate() {
    length = 70;
    width = 30;
    height = 6;

    difference() {
        plate();
        slots();
        translate([length/2, width/2])
        groove();
    }

    module plate() {
        cube([length, width, height]);
    }

    module slots() {
        slot_length = 10.1;

        translate([10, width/2])
        slot();

        translate([length - 10 - slot_length, width/2])
        slot();

        module slot() {
            slot_width = 4.2;

            translate([0, 0, -0.5])
            hull() {
                translate([slot_width/2, 0])
                cylinder(h = height+1, d = slot_width);

                translate([slot_length-slot_width/2, 0])
                cylinder(h = height+1, d = slot_width);
            }
        }
    }

    module groove() {
        hotend_dia = 12.5;

        translate([0, 0, -0.5])
        hull() {
            cylinder(h = height+1, d = hotend_dia);
            translate([-hotend_dia/2, -20])
            cube([hotend_dia, 1, height+1]);
        }
    }
}