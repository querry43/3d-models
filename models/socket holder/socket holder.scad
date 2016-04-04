sockets = [
    [11.6],
    [11.6, [6.7+(0*13.3), 11.5]],
    [11.6, [13.4, 0]],
    [11.6, [6.7+(1*13.3), 11.5]],
    [11.6, [26.7, 0]],
    [11.6, [6.7+(2*13.3), 11.5]],
    [11.7, [40.1, -0.5]],
    [11.7, [6.7+(3*13.3), 11.2]],
    [11.7, [53.5, -0.5]],
    [12.7, [60.5, 11.5]],
    [13.6, [67.9, -1.5]],
    [15.6, [76.3, 12.5]],
    [15.6, [84.2, -3]],
    [16.9, [94.3, 12.5]],
    [19.7, [103.6, -5.3], true],
    [21.6, [115.2, 13.9], true],
];

for (socket = sockets) {
    translate(socket[1])
    socket_holder(od = socket[0], large_shaft = socket[2]);
} 

module socket_holder(od, large_shaft = false, show_depth = true) {
    shaft_width = large_shaft ? 9.7 : 6.5;
    shaft_length = 8.5;
    
    socket_height = 20;
    socket_depth = socket_height - shaft_length;
    
    padding = 1;
    
    holder_wall_width = 0.8;
    
    %socket();
    holder();
    
    module socket() {
        od = od + padding;
        shaft_width = shaft_width - padding;
        translate([0, 0, 1])
        difference() {
            cylinder(d = od, h = socket_height);
            translate([-shaft_width/2, -shaft_width/2, -0.5])
            cube([shaft_width, shaft_width, shaft_length+0.5]);
            if (show_depth) {
                $fn = 6;
                translate([0, 0, shaft_length-0.5])
                cylinder(d = od-4, h = socket_depth+1);
            }
        }
    }
    
    module holder() {
        //od = od + 2;
        difference() {
            cylinder(d = od+padding+(2*holder_wall_width), h = shaft_length-1);
            translate([0,0,3])
            socket();
            translate([-100/2,-3.1/2,-0.5])
            cube([100, 3.1, 3]);
        }
    }
}