rainbox_size_x = 99;
rainbox_size_y = 93;
rainbox_size_z = 35;
rainbox_thickness_xy = 3.3;
rainbox_thickness_z = 3.3;
rainbox_tie_thickness = 6;
rainbox_corner_radius = 1;
rainbox_barrier_height = rainbox_size_z / 2;
rainbox_barrier_tolerance = 0.6;
rainbox_hole_size_y = 20;
rainbox_hole_size_z = 14;
rainbox_hole_margin_z = 1;

INFINITESIMAL = 0.01;
INFINITY = 100;

bottom();

/*
translate(
  [
    rainbox_size_x + 4 * rainbox_thickness_xy + 2 * rainbox_barrier_tolerance + 4 * rainbox_corner_radius,
    0,
    0
  ]
)
top();
*/

module top () {
  difference () {
    rounded_box(
      size = [
        rainbox_size_x + 4 * rainbox_thickness_xy + 2 * rainbox_barrier_tolerance,
        rainbox_size_y + 6 * rainbox_thickness_xy + 2 * rainbox_barrier_tolerance + 2 * rainbox_tie_thickness + 2 * rainbox_corner_radius,
        rainbox_size_z + rainbox_thickness_z - rainbox_barrier_height
      ],
      radius = rainbox_corner_radius
    );

    translate(
      [
        0,
        0,
        rainbox_thickness_z
      ]
    )
    rounded_box(
      size = [
        rainbox_size_x + 2 * rainbox_thickness_xy + rainbox_barrier_tolerance,
        rainbox_size_y + 2 * rainbox_thickness_xy + rainbox_barrier_tolerance,
        rainbox_barrier_height + rainbox_thickness_z
      ],
      radius = rainbox_corner_radius
    );

    for (tie_side = [-1, 1]) {
      translate(
        [
          0,
          tie_side * (1/2 * rainbox_size_y + 2 * rainbox_thickness_xy + 1/2 * rainbox_tie_thickness + 2 * rainbox_corner_radius),
          - INFINITESIMAL
        ]
      )
      rounded_box(
        size = [
          rainbox_size_x + 2 * rainbox_thickness_xy,
          rainbox_tie_thickness,
          rainbox_size_z
        ]
      );
    }
  }
}

module bottom () {
  difference () {
    union () {
      rounded_box(
        size = [
          rainbox_size_x + 4 * rainbox_thickness_xy + 2 * rainbox_barrier_tolerance,
          rainbox_size_y + 6 * rainbox_thickness_xy + 2 * rainbox_barrier_tolerance + 2 * rainbox_tie_thickness + 2 * rainbox_corner_radius,
          rainbox_size_z + rainbox_thickness_z - rainbox_barrier_height
        ],
        radius = rainbox_corner_radius
      );

      translate(
        [
          0,
          0,
          rainbox_size_z + rainbox_thickness_z - rainbox_barrier_height
        ]
      )
      rounded_box(
        size = [
          rainbox_size_x + 2 * rainbox_thickness_xy,
          rainbox_size_y + 2 * rainbox_thickness_xy,
          rainbox_barrier_height
        ],
        radius = rainbox_corner_radius
      );
    }

    translate(
      [
        0,
        0,
        rainbox_thickness_z
      ]
    )
    rounded_box(
      size = [
        rainbox_size_x,
        rainbox_size_y,
        rainbox_size_z + rainbox_barrier_height
      ],
      radius = rainbox_corner_radius
    );

    for (tie_side = [-1, 1]) {
      translate(
        [
          0,
          tie_side * (1/2 * rainbox_size_y + 2 * rainbox_thickness_xy + 1/2 * rainbox_tie_thickness + 2 * rainbox_corner_radius),
          - INFINITESIMAL
        ]
      )
      rounded_box(
        size = [
          rainbox_size_y + 2 * rainbox_thickness_xy,
          rainbox_tie_thickness,
          rainbox_size_z
        ]
      );
    }

    translate(
      [
        - (1/2 * rainbox_size_x + rainbox_thickness_xy),
        0,
        rainbox_thickness_z + rainbox_hole_margin_z
      ]
    )
    rounded_box(
      size = [
        rainbox_size_x,
        rainbox_hole_size_y,
        rainbox_hole_size_z
      ]
    );
  }
}

module rounded_box (size, radius = 0.1) {
  width = size[0];
  height = size[1];
  depth = size[2];

  translate([(-1/2) * width, (-1/2) * height])
  linear_extrude(height = depth)
  translate([-1/2 * radius, -1/2 * radius])
  hull () {
    translate([0, 0])
    circle(r = radius);

    translate([width + radius, 0])
    circle(r = radius);

    translate([0, height + radius])
    circle(r = radius);

    translate([width + radius, height + radius])
    circle(r = radius);
  }
}

