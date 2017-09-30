plug1();

translate([30, 0])
plug2();

translate([60, 0])
plug3();

module plug1() {
    rotate([0, 0, -25])
    tentacle(0.9);

    translate([1.5, -0.25, -11])
    plug();
}

module plug2() {
    difference() {
        translate([0, 0, -32])
        rotate([0, 0, -120])
        tentacle(1.5);
        
        translate([-50/2, -50/2, -100])
        cube([50, 50, 100]);
    }

    translate([-1.5, 1.5, -11])
    plug();
}

module plug3() {
    difference() {
        translate([0, 0, -29])
        rotate([0, -20, 180])
        tentacle(1.5);
        
        translate([-50/2, -50/2, -100])
        cube([50, 50, 100]);
    }

    translate([11, 2, -11])
    plug();
}


// from https://www.thingiverse.com/thing:8727
module tentacle(scale = 1.0) {
    large=5*scale;
    height=30*scale;

    steps=80;

    maxScale=1;
    minScale=0.2;

    function scaleFunction(i)=maxScale*((1-minScale)*abs(cos(i/(steps-1)*90))+minScale);

    maxXrot=10;
    maxYrot=10;
    maxZrot=10;

    function XrotFunction(i)=maxXrot*sin(i/(steps-1)*90);
    function YrotFunction(i)=maxYrot*sin(i/(steps-1)*90);
    function ZrotFunction(i)=maxZrot*sin(i/(steps-1)*720);

    radius=0.3*large;

    function XtranFunction(i)=radius*cos(i/(steps-1)*360);
    function YtranFunction(i)=radius*sin(i/(steps-1)*360);
    function ZtranFunction(i)=height*i/(steps-1);

    module functionPlace()
    {
        union()
        {
            for (i=[0:steps-1])
            {
                translate([XtranFunction(i),YtranFunction(i),ZtranFunction(i)])
                rotate([XrotFunction(i),YrotFunction(i),ZrotFunction(i)])
                scale(scaleFunction(i))
                children(0);
            }
        }
    }

    module shape()
    {
        sphere(large);
    }

    module sideShape()
    {
        translate([large,0,0])
        rotate([0,72,0])
        rotate_extrude(convexity = 10, $fn = 40)
        translate([2*scale, 0, 0])
        circle(r = 1*scale, $fn = 40);
    }


    for (i=[10,26,42,55,65,72,77])
    {
        translate([XtranFunction(i),YtranFunction(i),ZtranFunction(i)])
        rotate([XrotFunction(i),YrotFunction(i),ZrotFunction(i)])
        scale(scaleFunction(i))
        sideShape();
    }

    intersection()
    {
        functionPlace()
        shape();

        translate([0,0,height])
        cube(2*height,true);
    }
}

module plug() {
    difference() {
        $fn = 10;
        cylinder(h = 11, d = 9.5);

        translate([-5, 4, -0.5])
        cube([10, 10, 12]);

        translate([-7.5/2, -3.5/2, -1])
        cube([7.5, 3.5, 8]);
    }

    *translate([-5.5/2, -5.5/2, 11])
    cube([5.5, 5.5, 8]);
}