train_support(height=5);

module train_support(height) {
    difference() {
        translate([0,0,height-10])
        support(height=10, width=21, depth=13, edge=2);

        translate([-15,-15,-100])
        cube([30,30,100]);
    }

	difference() {
		pyramid(width=20, height=10);
		translate([-10,-10,height])
		cube([20,20,100]);
	}

	cylinder(h=height, r=7);

    module pyramid(width, height) {
        points = [
            [width/2,width/2,0],
            [width/2,-width/2,0],
            [-width/2,-width/2,0],
            [-width/2,width/2,0],
          [0,0,height]
        ];
        faces = [
            [0,1,4],[1,2,4],[2,3,4],[3,0,4],
                  [1,0,3],[2,1,3]
        ];
        polyhedron(points=points, faces=faces);
    }

    module support(height, width, depth, edge) {
        polyhedron(
            points = [
                [depth/2,0,0],
                [depth/2,width/2,height],
                [depth/2,-width/2,height],
                [-depth/2,0,0],
                [-depth/2,width/2,height],
                [-depth/2,-width/2,height]
            ],
            faces = [
                [0,1,2],
                [3,5,4],
                [3,0,2,5],
                [0,3,4,1],
                [1,4,5,2]
            ]
        );
        translate([-depth/2,width/2-edge,height])
        cube([depth,edge,edge]);
        translate([-depth/2,-width/2,height])
        cube([depth,edge,edge]);
    }
}
