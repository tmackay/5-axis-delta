
$fs = 0.5;
$fa = 0.5;
//---------------------------------------------------------------------------------------------------- 
// CloverPlus Top and Bottom frame parts by pbmax (mpeterson333/@/gmail.com)
//---------------------------------------------------------------------------------------------------- 
// This is a work in progress! :)
//
// Many variables are used "globally" inside the modules; this may or may not be fixed in the
// future.
//---------------------------------------------------------------------------------------------------- 

//------------------------- 
// Variables
//------------------------- 

// Slightly bigger spacing than the carriages to allow for screws to secure from the sides
rod_spacing = 30.1;
// Rod diameter
rod_d = 8;
rod_extra = 0.2*0;
// How deep the rods recess into the design
rod_hole_depth = 10;
// Rod offsets with respect to center (don't change)
rod_hole_x_offset = rod_spacing/2;
rod_hole_y_offset = 0;

// Rod clamp screw hole diameter (tight M5)
rod_secure_hole_d = 4.7*0;

// Idler pulley screw hole diameter (M5)
idler_pulley_hole_d = 4.85;
// Straight belt path with 608ZZ bearing requires an offset
idler_pulley_x_offset = 7;

// Original was 45, but the bottom needed to be bigger to accomodate slightly larger NEMA17 motors
base_length = 46;
// Matches original
base_width = 22;
// Original was 17, adding 1mm to make it a bit tougher
top_base_thick = 18;
// Original was 13
bottom_base_thick = 14;

// This matches original
leg_length = 85;

// Sizing for the male/female couplers on the ends of the arms
leg_coupler_length_male = 8;
leg_coupler_width_male = 6;
leg_coupler_length_female = 8.1;
leg_coupler_width_female = 6.2;
leg_coupler_height = 6;

// Sizing for the lege edges that extend up to the connectors on both sides of each leg
leg_edge_thick = 2.5;  // Slightly thicker than original
leg_edge_start_inner_top = 35;
leg_edge_start_outer = 10;
leg_edge_start_inner_bottom = 45;

// Sizing for the M5 connectors on either side of the leg ends
leg_connector_thick = 4;
leg_connector_width = 11;
leg_connector_hole_d = 5.4;
leg_connector_far_height = 60;//28;

// Sizing and placement for the endstop switch (omron SS-5 plunger style)
// M2.5 screw size
leg_switch_hole_d = 2.2;
leg_switch_hole_depth = 12;
leg_switch_hole_spacing = 9.5;
// Distance from top (bottom when assembled) edge
leg_switch_hole_z_offset = 7.5;
leg_switch_hole_y_offset = 27;

// Y offset to start of curved cutout
leg_cutout_start = 21;
// This has to accomodate the M4 screw traps
leg_cutout_curve_radius = 4;

// Controller, extruder, and bed clamp mounting holes with nut traps (M4)
leg_hole_d = 4.5;
leg_hole_x_offset = 0;
leg_hole_y_offset = 14;
leg_nuttrap_d = 8.3;
leg_nuttrap_depth = 2;

// Leg wire guide ziptie holes
leg_wire_guide_hole_d = 3;
leg_wire_guide_hole_y_offset = leg_connector_thick+9;
leg_wire_guide_top_z_offset = -4;
leg_wire_guide_bottom_z_offset = 2;

// Nema 17 motor mount shaft and screw holes, plate size, placement offset (for proper belt path)
motor_mount_hole_d = 24;
motor_mount_screw_hole_d = 3.2;
motor_mount_screw_spacing = 31;
motor_mount_size = 46;
motor_mount_thick = 4;
motor_mount_x_offset = -0.25;

calc_arm_t_len = leg_length + (base_length*0.5)/sin(30);

calc_tip_to_base_len = (base_length*0.5)/tan(30);

calc_tip_to_center_len = calc_arm_t_len/cos(30);

rod_to_center_len = calc_tip_to_center_len - calc_tip_to_base_len-base_width*0.5;

echo("rod to center distance", rod_to_center_len);

// Set this to 1 to enable a single piece top and bottom if you're a ROCK SUPER-STAR
// and LIFE LARGE :)
one_piece_top_and_bottom = 1;

//------------------------- 
// Part Instantiation (comment / uncomment for top / bottom)
//------------------------- 

if (one_piece_top_and_bottom)
{
  /*for(i = [0, 120, 240])
    rotate([0,0,i])
      translate([0,-rod_to_center_len,0])
        top_piece();

  translate([rod_to_center_len*3, 0, 0])*/
    for(i = [0, 120, 240])
      rotate([0,0,i])
        translate([0,-rod_to_center_len,0])
          bottom_piece();
}
else
{
  top_piece();

  translate([0,-80,0])
    bottom_piece();
}

//------------------------- 
// Modules
//------------------------- 

// Top Piece
module top_piece()
{
  difference()
  {
    union()
    {
      // Frame body
      cube([base_length, base_width, top_base_thick], center=true);
  
      // Left leg
      leg(top_base_thick, leg_edge_start_inner_top, leg_edge_start_outer, 0, 0,
          leg_wire_guide_top_z_offset, right=false, switch=true, noconnects = one_piece_top_and_bottom, top = true);
      // Right leg
      leg(top_base_thick, leg_edge_start_inner_top, leg_edge_start_outer, 0, 0,
          leg_wire_guide_top_z_offset, right=true, switch=true, noconnects = one_piece_top_and_bottom, top = true);
    }

    // Rod holes
    for (i = [-rod_hole_x_offset, rod_hole_x_offset])
      translate([i, rod_hole_y_offset, top_base_thick*0.5-rod_hole_depth*0.5])
        cylinder(h=rod_hole_depth, d=rod_d+rod_extra, center=true);
  
    // Rod secure holes
    for (i = [-base_length*0.5, base_length*0.5])
      translate([i, rod_hole_y_offset, top_base_thick*0.5-rod_hole_depth*0.5])
        rotate([0,90,0])
          cylinder(h=(base_length*0.5-rod_hole_x_offset)*2, d=rod_secure_hole_d, center=true);
  
    // Idler Pulley hole
    translate([-idler_pulley_x_offset, 0, 0])
      rotate([90,0,0])
        cylinder(h=base_width+0.2, d=idler_pulley_hole_d, center=true);
  
  }
}

// Bottom Piece
module bottom_piece()
{
  difference()
  {
    union()
    {
      // Frame body
      cube([base_length, base_width, bottom_base_thick], center=true);
  
      // Left leg
      leg(bottom_base_thick, leg_edge_start_inner_bottom, 0, 0, motor_mount_size, 
          leg_wire_guide_bottom_z_offset, right=false, switch=false, noconnects = one_piece_top_and_bottom);
      // Right leg
      leg(bottom_base_thick, leg_edge_start_inner_bottom, 0, 0, motor_mount_size, 
          leg_wire_guide_bottom_z_offset, right=true, switch=false, noconnects = one_piece_top_and_bottom);
  
      // Motor mount
      translate([0, -base_width*0.5+motor_mount_thick*0.5, motor_mount_size*0.5+bottom_base_thick*0.5])
        motor_mount(motor_mount_size, motor_mount_thick, motor_mount_hole_d, 
                    motor_mount_screw_hole_d, motor_mount_screw_spacing,
                    motor_mount_x_offset);
  
    }
  
    // Rod holes
    for (i = [-rod_hole_x_offset, rod_hole_x_offset])
      translate([i, rod_hole_y_offset, -top_base_thick*0.5+rod_hole_depth*0.5])
        cylinder(h=rod_hole_depth, d=rod_d+rod_extra, center=true);

    // Rod secure holes
    for (i = [-base_length*0.5, base_length*0.5])
      translate([i, rod_hole_y_offset, -bottom_base_thick*0.5+rod_hole_depth*0.5])
        rotate([0,90,0])
          cylinder(h=(base_length*0.5-rod_hole_x_offset)*2, d=rod_secure_hole_d, center=true); 
    
    // Idler Pulley hole
    translate([-idler_pulley_x_offset, 0, 0])
      rotate([90,0,0])
        cylinder(h=base_width+0.2, d=idler_pulley_hole_d, center=true);
    
  }
}

// Leg (2 per piece, a right and a !right)
module leg(base_thick, edge_start_inner, edge_start_outer, edge_near_height_inner, 
           edge_near_height_outer, wire_guide_hole_z_offset, right = false, switch = true,
           noconnects = false, top = false)
{
    translate([right ? base_length*0.5 : -base_length*0.5,-base_width*0.5,-base_thick*0.5])
      rotate([0,0,right ? -30 : 30])
        translate([right ? -base_width : 0,0,0])
          difference()
          {
            union()
            {
              // Leg body
              cube([base_width, leg_length, base_thick]);
  
              // Edges rise to connectors
              leg_edges(base_thick, edge_start_inner, edge_start_outer, edge_near_height_inner, 
                        edge_near_height_outer, right, noconnects);

              // Left and right connectors
              if (!noconnects && !top && !right)
                translate([0, leg_length-leg_connector_thick, 0])
                  leg_connector(leg_connector_far_height, leg_connector_width, leg_connector_thick, 
                                leg_edge_thick, leg_connector_hole_d, right=false);
              if (!noconnects && !top && right)
                translate([base_width, leg_length-leg_connector_thick, 0])
                  leg_connector(leg_connector_far_height, leg_connector_width, leg_connector_thick, 
                                leg_edge_thick, leg_connector_hole_d, right=true);
  
              // Male coupler
              if (!right && !noconnects)
                translate([base_width*0.5-leg_coupler_width_male*0.5, leg_length, 0])
                  cube([leg_coupler_width_male, leg_coupler_length_male, leg_coupler_height]);
            }
  
            if (right)
            {

              // Female coupler end
              if (!noconnects)
                translate([base_width*0.5-leg_coupler_width_female*0.5, leg_length-leg_coupler_length_female, 0])
                  cube([leg_coupler_width_female, leg_coupler_length_female, leg_coupler_height*10]);
  
              // Switch holes
              if (switch)
                translate([0, leg_switch_hole_y_offset, base_thick-leg_switch_hole_z_offset])
                  switch_holes(leg_switch_hole_d, leg_switch_hole_depth+0.2, leg_switch_hole_spacing);
            }
  
            // Hollow out the leg
            translate([leg_edge_thick, leg_cutout_start, leg_coupler_height])
              leg_hollow(leg_cutout_curve_radius, leg_length, base_width-leg_edge_thick*2, 100);
  
            // Controller / extruder mount holes with nut traps
            translate([base_width*0.5+leg_hole_x_offset, leg_length-leg_hole_y_offset, 0])
              translate([0,0,leg_coupler_height])
                rotate([180,0,0])
                  nuttrap(leg_hole_d, base_thick+0.2, leg_nuttrap_d, leg_nuttrap_depth);

            // Wire guide hole
            translate([(leg_edge_thick+0.2)*0.5, leg_length-leg_wire_guide_hole_y_offset,
                       leg_connector_far_height+wire_guide_hole_z_offset])
              rotate([0,90,0])
                cylinder(h=leg_edge_thick+0.2, d=leg_wire_guide_hole_d, center=true);
          }
 
}

// Leg edges that extend from base and then up or down to connector ends
module leg_edges(base_thick, edge_start_inner, edge_start_outer, edge_near_height_inner, edge_near_height_outer, right = false, noconnects = 0)
{
  for(i = [0, base_width-leg_edge_thick])
    if (!noconnects || ((right && i) || (!right && !i)))
    hull()
    {
      translate([i, leg_length-leg_connector_thick, leg_connector_far_height-1])
        cube([leg_edge_thick, leg_connector_thick, 1]);
      translate([i, leg_length-leg_connector_thick, base_thick-1])
        cube([leg_edge_thick, leg_connector_thick, 1]);
      translate([i, ((right && i == 0) || (!right && i)) ? edge_start_inner : edge_start_outer, 
        ((right && i == 0) || (!right && i)) ? edge_near_height_inner+base_thick-1 : edge_near_height_outer+base_thick-1])
        cube([leg_edge_thick, leg_connector_thick, 1]);
      translate([i, ((right && i == 0) || (!right && i)) ? edge_start_inner : edge_start_outer, base_thick-1])
        cube([leg_edge_thick, leg_connector_thick, 1]);
    }
}

// Curved leg cutout
module leg_hollow(edge_radius, length, width, height)
{
  rotate([90,0,0])
    translate([width*0.5,edge_radius,-height])
      linear_extrude(h=length)
      {
        for(i = [-width*0.5+edge_radius, width*0.5-edge_radius])
          translate([i,0,0])
            circle(r=edge_radius, center=true);
        square([width-edge_radius*2, edge_radius*2], center=true);
        translate([0, (height-edge_radius)*0.5,0])
          square([width, height-edge_radius], center=true);
      }
}

// Connector ends with screw holes
module leg_connector(height, size, thick, edge_thick, hole_d, right = false)
{
  difference()
  {
    hull()
    {
      translate([right ? -edge_thick : -size, 0, height-size])
        cube([size+edge_thick, thick, size]);
      translate([right ? -edge_thick : 0, 0, 0])
        cube([edge_thick, thick, size]);
    }
    translate([right ? size*0.5 : -size*0.5, thick*0.5, height - size*0.5])
    rotate([90,0,0])
      cylinder(h=thick+0.2, d=hole_d, center=true);
  }
}

// Motor mount plate with holes
module motor_mount(size, thick, mount_d, screw_d, spacing, x_offset)
{

  difference()
  {
    // Motor mount plate
    cube([size,thick,size], center=true);
    // x offset for holes allows for belt path adjustment
    translate([x_offset,0,0])
    {
      // Motor shaft hole
      rotate([90,0,0])
        cylinder(h=thick+0.2, d=mount_d, center=true);
      // Motor screw holes
      for (i = [-spacing*0.5,spacing*.5])
        for (j = [-spacing*0.5,spacing*.5])
          translate([i,0,j])
            rotate([90,0,0])
              cylinder(h=thick+0.2, d=screw_d, center=true);
    }
  }
}

// Holes for endstop switch
module switch_holes(hole_d, depth, spacing)
{
  translate([depth*0.5+0.1, 0, 0])
    rotate([0,90,0])
      cylinder(h=depth+0.2, d=hole_d, center=true);
  translate([depth*0.5+0.1, spacing, 0])
    rotate([0,90,0])
      cylinder(h=depth+0.2, d=hole_d, center=true);
}


// Nuttrap with bottom at z 0
module nuttrap(hole_d, hole_h, trap_d, trap_h)
{ 
  //linear_extrude(height=trap_h)
  //  circle(d=trap_d, $fn=6, center=true);
  translate([0,0,trap_h*0.5])
  cylinder(d=trap_d, $fn=6, h=trap_h, center=true);
  translate([0,0,hole_h*0.5+trap_h])
    cylinder(d=hole_d, h=hole_h, center=true);
}
