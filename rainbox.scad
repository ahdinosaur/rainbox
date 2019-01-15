/*
rainbox_size_x = 40;
rainbox_size_y = 80;
rainbox_size_z = 40;
rainbox_thickness_xy = 4;
rainbox_thickness_z = 4;
rainbox_tie_thickness = 10;
rainbox_tie_corner_radius = 1;
rainbox_corner_radius = 5;
rainbox_barrier_thickness = 4;
rainbox_barrier_height = 20;
rainbox_barrier_tolerance = 0.8;
rainbox_barrier_corner_radius = 5;
*/

rainbox_size_x = 10;
rainbox_size_y = 10;
rainbox_size_z = 10;
rainbox_thickness_xy = 2;
rainbox_thickness_z = 2;
rainbox_tie_thickness = 4;
rainbox_tie_corner_radius = 1;
rainbox_corner_radius = 1;
rainbox_barrier_thickness = 2;
rainbox_barrier_height = 5;
rainbox_barrier_tolerance = 0.8;
rainbox_barrier_corner_radius = 1;

INFINITESIMAL = 0.01;
INFINITY = 100;

bottom();

translate(
  [
    rainbox_size_x * 2 + 2,
    0,
    0
  ]
)
top();

module top () {
  difference () {
    rounded_box(
      size = [
        rainbox_size_x + 2 * rainbox_thickness_xy + 2 * rainbox_barrier_thickness,
        rainbox_size_y + 4 * rainbox_thickness_xy + 4 * rainbox_barrier_thickness + 2 * rainbox_tie_thickness,
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
        rainbox_size_x + 2 * rainbox_barrier_thickness + rainbox_barrier_tolerance,
        rainbox_size_y + 2 * rainbox_barrier_thickness + rainbox_barrier_tolerance,
        rainbox_barrier_height + rainbox_thickness_z
      ],
      radius = rainbox_barrier_corner_radius
    );

    for (tie_side = [-1, 1]) {
      translate(
        [
          0,
          tie_side * (1/2 * (rainbox_size_y + 2 * rainbox_thickness_xy + 2 * rainbox_barrier_thickness + 2 * rainbox_tie_thickness) + rainbox_barrier_corner_radius),
          - INFINITESIMAL
        ]
      )
      rounded_box(
        size = [
          rainbox_size_x + 2 * rainbox_thickness_xy,
          rainbox_tie_thickness,
          rainbox_size_z
        ],
        radius = rainbox_tie_corner_radius
      );
    }
  }
}

module bottom () {
  difference () {
    union () {
      rounded_box(
        size = [
          rainbox_size_x + 2 * rainbox_thickness_xy + 2 * rainbox_barrier_thickness,
          rainbox_size_y + 4 * rainbox_thickness_xy + 4 * rainbox_barrier_thickness + 2 * rainbox_tie_thickness,
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
        radius = rainbox_barrier_corner_radius
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
      radius = rainbox_barrier_corner_radius
    );

    for (tie_side = [-1, 1]) {
      translate(
        [
          0,
          tie_side * (1/2 * (rainbox_size_y + 2 * rainbox_thickness_xy + 2 * rainbox_barrier_thickness + 2 * rainbox_tie_thickness) + rainbox_barrier_corner_radius),
          - INFINITESIMAL
        ]
      )
      rounded_box(
        size = [
          rainbox_size_x + 2 * rainbox_thickness_xy,
          rainbox_tie_thickness,
          rainbox_size_z
        ],
        radius = rainbox_tie_corner_radius
      );
    }
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

