
$fs = 0.5;
$fa = 0.5;
//---------------------------------------------------------------------------------------------------- 
// CloverPlus Carriage v2 by pbmax (mpeterson333/@/gmail.com)
//---------------------------------------------------------------------------------------------------- 
// This is a work in progress! :)
//
// By default the hotend mount is setup for E3D / E3D Lite.  J-head support is planned...
//---------------------------------------------------------------------------------------------------- 

//------------------------- 
// Variables
//------------------------- 

rod_spacing = 30.1;
rod_pass_d = 9;
ball_spacing = 0;
// How far above the bottom of the carriage the ball recesses start 
ball_z_offset = 1;
// How big the relief hole is (allows glue to escape if necessary for a better fit
ball_relief_hole_d = 5;

// Bearing diameter, length, extra diameter, total diameter, clamp thickness, and clamp height
bearing_d = 15;
bearing_l = 15.3;
bearing_extra = 0.2*0;
bearing_td = bearing_d+bearing_extra;
bearing_clamp_thick = 2;
bearing_clamp_h = bearing_l;

// Clamp screw block (actually a cylinder) thickness & diamter, screw hole diameter
clamp_screw_block_thick = 3;
clamp_screw_block_d = 12;
clamp_screw_hole_d = 3.6;

// Carriage base thickness, front y thickness, and front corner sphere radius
carriage_base_h = 3*0;
carriage_front_offset = 3;
carriage_corner_r = 3;

// Ball mount variables
ball_mount_front_thick = 4;
ball_mount_front_corner_radius = 3;
ball_mount_back_thick = 4;
ball_mount_length = 16;
ball_recess_big_d = 18;
ball_recess_small_d = 14;
ball_recess_depth = 4;

// Belt width, belt edge y offset from rod center, belt recess center x offset from carriage center
belt_w = 6.5;
belt_edge_y_off = 14.5;
belt_center_x_off = -5;
// Belt thickness (without teeth), additional tooth thickness, tooth width (z size), number of teeth
belt_recess = 0.8;
belt_tooth_recess = 0.5;
belt_tooth_w = 1;
num_teeth = 7;
// Calculated belt clamp block height
belt_block_h = num_teeth*belt_tooth_w*2+1;
// Belt clamp block width
belt_block_w = 5.5;
// Calculated belt block depth (Y size)
belt_block_depth = belt_edge_y_off-bearing_clamp_thick-bearing_td*0.5+belt_w;

// Flying extruder attach hole
flying_hole_d = 4;
flying_hole_offset = 3;

// Carriage width (without screw clamp blocks) and total carriage height
carriage_width = rod_spacing+bearing_td+bearing_clamp_thick*2;
carriage_h = carriage_base_h+bearing_clamp_h;

ff = 0.1;

ball_y_offset = -bearing_td*0.5-carriage_front_offset-ball_mount_length*0.5;

echo("rod to balljoint spacing", -ball_y_offset);

//------------------------- 
// Instantiation
//------------------------- 

mirror([ball_spacing?0:1,0,0])carriage();

//------------------------- 
// Module
//------------------------- 

module carriage()
{
  difference()
  {
    union()
    {
      // Carriage body
      translate([0,0,carriage_h*0.5])
        hull()
        {
          // Linear bearing + clamp thickness around both rods
          for(i = [-rod_spacing*0.5, rod_spacing*0.5])
            translate([i,0,0])
              cylinder(h=carriage_h, 
                       d=bearing_td+bearing_clamp_thick*2, center=true);
          // Block between balls and linear bearings
          /*translate([0,
                     -((bearing_td)*0.5+carriage_front_offset)*0.5, -carriage_h*0.25])
            cube([carriage_width, 
                  (bearing_td)*0.5+carriage_front_offset, 
                  carriage_h*0.5], center=true);*/
          // Sphere corners in front for a snazzy look
          translate([0,-(bearing_td)*0.5-carriage_front_offset+carriage_corner_r, carriage_h*0.5-carriage_corner_r])
            for(i = [-rod_spacing*0.5-bearing_td*0.5-bearing_clamp_thick+carriage_corner_r,
                     rod_spacing*0.5+bearing_td*0.5+bearing_clamp_thick-carriage_corner_r])
              translate([i,0,0])
                sphere(r=carriage_corner_r, center=true);
          translate([0,-(bearing_td)*0.5-carriage_front_offset+carriage_corner_r, -carriage_h*0.5+carriage_corner_r])
            for(i = [-rod_spacing*0.5-bearing_td*0.5-bearing_clamp_thick+carriage_corner_r,
                     rod_spacing*0.5+bearing_td*0.5+bearing_clamp_thick-carriage_corner_r])
              translate([i,0,0])
                sphere(r=carriage_corner_r, center=true);

          // Screw clamp blocks
          /*for(i = [-1,1])
          {
            translate([i*((rod_spacing+bearing_td)*0.5+bearing_clamp_thick+clamp_screw_block_thick*0.5), 
                       0,
                       carriage_h*0.5-bearing_l*0.5+carriage_base_h])
              rotate([0,90,0])
                cylinder(h=clamp_screw_block_thick, d=clamp_screw_block_d, center=true);
            translate([i*rod_spacing*0.5, 
                       bearing_td*0.5+bearing_clamp_thick+clamp_screw_block_thick*0.5, 
                       carriage_h*0.5-bearing_l*0.5+carriage_base_h])
              rotate([90,0,0])
                cylinder(h=clamp_screw_block_thick, d=clamp_screw_block_d, center=true);
          }*/
          // Ball mount
          for(i = [-ball_spacing*0.5, ball_spacing*0.5])
            translate([i,-(bearing_td)*0.5-carriage_front_offset, carriage_h*0.5])rotate([180+45,0,0])
              translate([0,ball_recess_big_d/2,0])
                cylinder(d=ball_recess_big_d);
        }

      // Ball mount
      /*hull()
      {
        translate([0,
                   -ball_mount_length-(bearing_td)*0.5-carriage_front_offset+ball_mount_front_corner_radius, 
                   ball_mount_front_thick*0.5])
          for(i = [-1,1])
            translate([i*(carriage_width*0.5-ball_mount_front_corner_radius),0,0])
              cylinder(h=ball_mount_front_thick, r=ball_mount_front_corner_radius, center=true);
        translate([0,
                   -(bearing_td)*0.5-carriage_front_offset+0.5, 
                   ball_mount_back_thick*0.5])
          cube([carriage_width, 1, ball_mount_back_thick], center=true);
      }*/

      // Belt block
      translate([belt_center_x_off, bearing_td*0.5+bearing_clamp_thick+belt_block_depth*0.5-0.05, belt_block_h*0.5])
        cube([belt_block_w, belt_block_depth, belt_block_h], center=true);
      

    } // end carriage body union

    for(i = [-rod_spacing*0.5, rod_spacing*0.5])
    {
      // Linear bearing recesses
      translate([i,0,carriage_base_h+bearing_clamp_h*0.5])
        cylinder(h=bearing_clamp_h+ff, d=bearing_td, center=true);
      // Hole to let the rod pass through
      translate([i,0,0])
        cylinder(h=bearing_clamp_h*2, d=rod_pass_d, center=true);
    }

    // Ball recesses
    for(i = [-ball_spacing*0.5, ball_spacing*0.5])
      translate([i,-(bearing_td)*0.5-carriage_front_offset, carriage_h])rotate([180+45,0,0])
        translate([0,ball_recess_big_d/2,0])
          sphere(d=ball_recess_small_d);
    // Tension cable
    translate([0,-(bearing_td)*0.5-carriage_front_offset, carriage_h])rotate([180+30,0,0])
        translate([0,ball_spacing?ball_recess_big_d/2:-1.5,-1])
          cylinder(d=3,h=2*carriage_h);
    
    /*for(i = [-ball_spacing*0.5, ball_spacing*0.5])
      translate([i,
                 ball_y_offset, 
                 ball_mount_back_thick-ball_recess_depth-ff*0.5])
        linear_extrude(height=ball_recess_depth+ff, scale = ball_recess_big_d/ball_recess_small_d)
          circle(d=ball_recess_small_d, center=true);

    // Flying Extruder attach hole
    translate([0, ball_y_offset - flying_hole_offset, carriage_base_h*0.5])
      cylinder(h=carriage_base_h*2, d=flying_hole_d, center=true);*/

    // Bearing screw clamp holes
    /*for(i = [-1,1])
    {
      translate([0,0,carriage_h-bearing_l*0.5+carriage_base_h])
      {
        translate([i*(rod_spacing+bearing_td+bearing_clamp_thick+clamp_screw_block_thick)*0.5, 0, 0])
          rotate([0,90,0])
            cylinder(h=clamp_screw_block_thick+bearing_clamp_thick+1, d=clamp_screw_hole_d, center=true);
        translate([i*rod_spacing*0.5, 
                 (bearing_td+bearing_clamp_thick+clamp_screw_block_thick)*0.5, 
                 0])
          rotate([90,0,0])
            cylinder(h=clamp_screw_block_thick+bearing_clamp_thick+1, d=clamp_screw_hole_d, center=true);
      }
    }*/

    // Belt clamp recess
    translate([belt_center_x_off-belt_recess*0.5, belt_edge_y_off, 0])
      for(i = [0:num_teeth])
      {
        translate([0,0,i*belt_tooth_w*2])
          cube([belt_recess,belt_w,belt_tooth_w]);
        translate([0,0,i*belt_tooth_w*2+belt_tooth_w])
          cube([belt_recess+belt_tooth_recess,belt_w,belt_tooth_w]);
        if (i == num_teeth)
          translate([0,0,(i+1)*belt_tooth_w*2])
            cube([belt_recess,belt_w,belt_tooth_w]);
      }
  }
}

