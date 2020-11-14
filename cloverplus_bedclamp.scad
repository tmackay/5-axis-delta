$fs = 0.5;
$fa = 0.5;

//---------------------------------------------------------------------------------------------------- 
// CloverPlus Bed Clamp by pbmax (mpeterson333/@/gmail.com)
//---------------------------------------------------------------------------------------------------- 
// This is designed to secure a glass plate of about 2mm thickness to the CloverPlus 3D printer.
//
//---------------------------------------------------------------------------------------------------- 

base_mount_hole_d = 4.4;
slot_length = 8;
outer_slot_d = base_mount_hole_d + 4;
outer_slot_depth = 4.1;

base_mount_thick = 3 + outer_slot_depth;
base_mount_hole_spacing = 28;
base_mount_length = base_mount_hole_spacing + 30;
base_mount_width = 20;

glass_thick = 2;
clamp_spacing = 48;
clamp_width_offset = 0;
clamp_d = 10;
clamp_screw_d = 3;

clamp_tab_length = 6;
clamp_tab_thick = 3;
clamp_tab_width = clamp_d;
clamp_tab_hole_d = 3.5;
clamp_tab_bump_thick = 0.5;

ff = 0.1;

// Bed mount
*difference()
{
  union()
  {
    // base shape with rounded corners
    hull()
    {
      for (i = [-1,1])
        for (j = [-1,1])
          translate([i*(base_mount_length/2-base_mount_width/4), j*base_mount_width/4, 0])
            cylinder(d=base_mount_width/2, h=base_mount_thick);
    }
  
    // clamp mounts
    for (i = [-1,1])
      translate([i*clamp_spacing/2, clamp_width_offset, base_mount_thick])
        cylinder(h=glass_thick, d=clamp_d);
  }

  for (i = [-1,1])
  {
    // Slots
    translate([i*base_mount_hole_spacing/2, 0, 0])
    {
      translate([0,0,base_mount_thick-outer_slot_depth+ff])
        mount_slot(outer_slot_d, outer_slot_depth+ff, slot_length);
      mount_slot(base_mount_hole_d, base_mount_thick+1, slot_length);
    }
    // clamp holes
    translate([i*clamp_spacing/2, clamp_width_offset, -0.5])
      cylinder(h=glass_thick+base_mount_thick+1, d=clamp_screw_d);
  }

}

// Clamp tabs
translate([0, base_mount_width, 0])
{
  for (i = [-1,1])
    translate([i*clamp_tab_width*2,0,0])
      difference()
      {
        // Clamp tab with bump to grip the glass better
        hull()
        {
          mount_slot(clamp_tab_width, clamp_tab_thick, clamp_tab_length);
          translate([0,clamp_tab_length*0.5,clamp_tab_thick])
            cylinder(h=clamp_tab_bump_thick, d=clamp_tab_width*0.65);
        }
        // Clamp tab screw hole
        translate([0,-clamp_tab_length/2,-0.5])
          cylinder(d=clamp_tab_hole_d, h=clamp_tab_thick+1);
        // Clamp mount should not interfere with clamp tab bump
        translate([-clamp_tab_width*0.5,-clamp_tab_length*0.5-clamp_tab_width+clamp_d*0.55,clamp_tab_thick])
          cube([clamp_tab_width, clamp_tab_width, clamp_tab_thick]);
      }
}

module mount_slot(hole_d, height, length)
{
  hull()
  {
    for (i = [-1,1])
    translate([0, i*length/2, -ff])
      cylinder(h=height, d=hole_d);
  }
}
