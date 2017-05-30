tray();

module tray(size = [52, 52, 44]) {
    difference() {
        union() {
            tray_box(size = size);
            tray_lip(size = size);
        }
        tray_interior(size = size);
        translate([5, 5, 3])
        cylinder(h = size[2]-6, r = 3);
    }
    
    module rounded_rectangle(size, r = 4, interior = false, $fn = 20) {
        translations = [
            [r,         r,       , 0],
            [size[0]-r, r,       , 0],
            [size[0]-r, size[1]-r, 0],
            [r,         size[1]-r, 0]
        ];
    
        if (interior) {
            hull() {
                for (v = [translations[1], translations[2], translations[3]]) {
                    translate(v = v)
                    sphere(r = r);

                    translate(v = v)
                    cylinder(h = size[2], r = r);
                }
                    
                translate([7.3,7.3, size[2]/2-r])
                rotate([0, 0, 45])
                cube([0.1, 20, size[2]], center = true);
            }
        } else {
            hull() {
                for (v = translations) {
                    translate(v = v)
                    cylinder(h = size[2], r = r);
                }
            }
        }
    }
    
    module tray_box(size, r = 4, interior = false) {
        translate(v = [1, 1, 0])
        rounded_rectangle(size = [size[0]-2, size[1]-2, size[2]], r = r, interior = interior);
    }
    
    module tray_interior(size, margin = 1.5, r = 3.5) {
        translate(v = [margin/2, margin/2, margin + r])
        tray_box(size = [size[0]-margin, size[1]-margin, size[2]-1], r = r, interior = true);
    }
    
    module tray_lip(size, height = 4) {
        hull() {
            translate(v = [0, 0, size[2]-height])
            rounded_rectangle(size = [size[0], size[1], height], r = 5);
    
            translate(v = [1, 1, size[2]-height-2])
            rounded_rectangle(size = [size[0]-2, size[1]-2, 1]);
        }
    }
}