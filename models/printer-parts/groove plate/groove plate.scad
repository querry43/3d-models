sensor_dia = 18;
$fn = 12;

groove_plate();

translate([-20, 30])
sensor_plate();

translate([25, 35])
scale([1,1,0.75])
sensor_plate();

%translate([0, 50, -11])
sensor();


module sensor() {
    cylinder(d = sensor_dia, h = 70);
    translate([0, 0, 20])
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
        $fn = 20;
        margin = 1;
        translate([width/2, length/2, -0.5])
        cylinder(d = sensor_dia + margin, h = height + 1);
    }

    module screw_holes() {
        margin = 3;
        dia = 4;

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

    translate([length, width+7])
    rotate([0, 0, 180])
    fan_mount();

    module plate() {
        cube([length, width, height]);
    }

    module slots() {
        slot_length = 16;

        translate([5, width/2])
        slot();

        translate([length - 5 - slot_length, width/2])
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
        $fn = 20;
        hotend_dia = 13;

        translate([0, 0, -0.5])
        hull() {
            cylinder(h = height+1, d = hotend_dia);
            translate([-hotend_dia/2, -20])
            cube([hotend_dia, 1, height+1]);
        }
    }

    module fan_mount() {
        slot_width = 15;
        rail_width = 4;
        rail_height = 10;
        rail_length = 11;

        difference() {
            fan_mount_rails();
            hole();
        }


        module fan_mount_rails() {
            mount_width = slot_width + 2*rail_width;
            union() {
                translate([0, width - rail_width])
                fan_mount_rail();
                translate([0, width - mount_width])
               fan_mount_rail();
            }

            module fan_mount_rail() {
                translate([rail_height/2-rail_length, 0, rail_height/2])
                rotate([-90])
                cylinder(h = rail_width, d = rail_height);

                translate([-rail_length, 0])
                cube([rail_length, rail_width, height]);
            }
        }

        module hole() {
            translate([rail_height/2-rail_length, 0, rail_height/2])
            rotate([-90])
            cylinder(h = width+1, d = 4);
        }
    }
}