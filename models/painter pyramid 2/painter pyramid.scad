plane();
rotate([0,0,60]) plane();
rotate([0,0,120]) plane();


translate([0,0,-1])
cylinder(h=1, r=15);

module plane() {
    width=1;
    difference() {
        translate([width/2,0])
        rotate([0,-90])
        linear_extrude(height=width)
        polygon([[0,-15], [0,15], [30,0]]);
        
        translate([0,0,33.25])
        cube([10,10,10], center=true);
    }
}