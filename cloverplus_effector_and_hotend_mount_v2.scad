
$fs = 0.5;
$fa = 0.5;
//---------------------------------------------------------------------------------------------------- 
// CloverPlus Effector and Hotend mount by pbmax (mpeterson333/@/gmail.com)
//---------------------------------------------------------------------------------------------------- 
// This is a work in progress! :)
//
// By default the hotend mount is setup for E3D with external push-fit.
//   Comment / Uncomment "Hotend-specific Variables" sections below
//   for E3D collet-mount and J-head mount.  Note that the j-head mount does not
//   presently provide enough clearance for a fan.
//---------------------------------------------------------------------------------------------------- 

//------------------------- 
// Effector Variables
//------------------------- 

// The ball mount recess (cone-shaped)
ball_recess_big_d = 18;
ball_recess_small_d = 14;
ball_recess_depth = 4;

// How far down into the effector the ball recesses go
ball_inset = 3;
// How big the relief hole is (allows glue to escape if necessary for a better fit
ball_relief_hole_d = 5;

effector_d = 72;
ball_spacing = 30;
// How far out the ball pairs are from the center
ball_pair_radius = 23;
effector_thick = 4;

// rotated cutout diameter and max radius
cutout_d = 35;
cutout_center_offset = 21;

// Hex-shaped center cutout to square off the edges
center_cutout_d = 34;

//------------------------- 
// Shared Variables
//------------------------- 

hotend_mount_r = 19;
hotend_nuttrap_d = 6.6;
hotend_nuttrap_depth = 2;
hotend_m3_hole_d = 3.4;
hotend_mount_d = 6;
hotend_mount_h = 2;
hotend_nuttrap_bridge_thick = 0.31;
hotend_m3_hole_depth = effector_thick - hotend_nuttrap_depth + hotend_mount_h;

//------------------------- 
// Hotend Mount Variables
//------------------------- 

hm_stud_recess_d = hotend_mount_d + 0.4;
hm_stud_recess_h = hotend_mount_h + 0.5;
hm_stud_block_size = hotend_mount_d + 5;
hm_stud_block_height = 5;
hm_stud_taper_thick = 2;
hm_stud_block_bridge_gap = 0.32;

//------------------------- 
// Hotend-specific Variables
//------------------------- 
// J-head off by default
hm_jhead = false;

// E3D v6 collet-mount variables
/*
hm_height = 16;
hm_center_height = 14;
// This is how far up into the mount body the hotend recesses
hm_hotend_recess_h = 11.7;
hm_hotend_recess_d = 16.4;
hm_secure_screw_offset_from_top = 5.0;
hm_hotend_tube_d = 9;
// End of E3D variables
*/

// E3D with external M5 push-fit variables

hm_height = 16.7;
hm_center_height = 16.7;
// This is how far up into the mount body the hotend recesses
hm_hotend_recess_h = 11.7;
hm_hotend_recess_d = 16.4;
hm_secure_screw_offset_from_top = 5.0;
hm_hotend_tube_d = 4.9;
// End of E3D variables

// J-Head variables
/*
hm_height = 18;
hm_center_height = 16;
// This is how far up into the mount body the hotend recesses
hm_hotend_recess_h = 9.6;
hm_hotend_recess_d = 16.3;
hm_secure_screw_offset_from_top = 6.1;
hm_hotend_tube_d = 5;
hm_jhead_nuttrap_d = 8.4;
hm_jhead_nuttrap_h = 6;
hm_jhead_nuttrap_offset_from_top = 3;
hm_jhead = true;
// End of j-head variables
*/

hm_stud_taper_height = hm_height-hm_stud_block_height;
hm_secure_screw_spacing = 14.5;
hm_secure_screw_d = 3.2;
// This is how far from the top of the recess the secure screw centers are

ff = 0.1;

echo("balljoint to center spacing", ball_pair_radius);

//------------------------- 
// Instantiations
//------------------------- 
effector();

// Hotend is printed upside down
//translate([0,55,0])
//  rotate([0,180,0])
//    hotend_mount();


//------------------------- 
// Modules
//------------------------- 
module effector()
{
  difference()
  {
    // Effector
    hull()
    {
      //cylinder(h=4, d=effector_d, center=true);
      // Hotend mount studs
      /*for(i = [0,120,240])
        rotate([0,0,i])
          translate([0,hotend_mount_r,effector_thick*0.5+hotend_mount_h*0.5])
            cylinder(h=hotend_mount_h, d=hotend_mount_d, center=true);*/
      // Ball mount
      for(i = [0,120,240])
        rotate([0,0,i])
          for(i = [-ball_spacing*0.5, ball_spacing*0.5])
            translate([i,ball_pair_radius,0])rotate([-45,0,0])
              translate([0,-ball_recess_big_d/2,0])
                cylinder(d=ball_recess_big_d,h=1);
    }
  
    // Center cutout
    difference(){
      translate([0,0,effector_thick])union(){
        translate([0,0,cutout_d/2])sphere(d=cutout_d);
        cylinder(h=ball_recess_big_d*sqrt(2)-effector_thick, d=10);
      }
      cylinder(h=ball_recess_big_d*sqrt(2)-effector_thick, d=6, center=true);
    }
    cylinder(h=ball_recess_big_d/sqrt(2), d=3);
    
    // Ball recesses
    for(i = [0,120,240])
        rotate([0,0,i])
          for(i = [-ball_spacing*0.5, ball_spacing*0.5])
            translate([i,ball_pair_radius,0])rotate([-45,0,0])
              translate([0,-ball_recess_big_d/2,1])
          sphere(d=ball_recess_small_d);
    for(i = [0,120,240])
        rotate([0,0,i])
          translate([0,ball_pair_radius,0])rotate([-45,0,0])
              translate([0,-ball_recess_big_d/2,-ball_recess_big_d+2])
                cylinder(d=3,h=ball_recess_big_d);


    /*for(i = [0,120,240])
    {
      rotate([0,0,i])
      {
        // Ball recesses
        translate([0,ball_pair_radius,effector_thick*0.5-ball_recess_depth-ff*0.5])
          for(j = [-ball_spacing*0.5, ball_spacing*0.5])
            translate([j,0,0])
              linear_extrude(height=ball_recess_depth+ff, scale = ball_recess_big_d/ball_recess_small_d)
                circle(d=ball_recess_small_d, center=true);
  
        translate([0,hotend_mount_r,0])
        {
          // Nuttraps
          translate([0,0,-effector_thick*0.5+hotend_nuttrap_depth*0.5-ff])
            cylinder(h=hotend_nuttrap_depth+ff, d=hotend_nuttrap_d, center=true, $fn=6);
          // Screw holes
          translate([0,0,hotend_m3_hole_depth*0.5+effector_thick*0.5-(effector_thick-hotend_nuttrap_depth)+hotend_nuttrap_bridge_thick])
            cylinder(h=hotend_m3_hole_depth, d=hotend_m3_hole_d, center=true);
        }
      }
      // Cutouts
      rotate([0,0,i+60])
        hull()
        {
          cylinder(h=effector_thick+0.2, d=cutout_d, center=true);
          translate([0,cutout_center_offset-cutout_d*0.5,0])
            cylinder(h=effector_thick+0.2, d=cutout_d, center=true);
        }
    }*/
  }
}

/*module hotend_mount()
{

    translate([0,0,effector_thick*0.5-hm_height])
      difference()
      {
        union()
        {
          // Mount blocks
          for(i = [0,120,240])
            rotate([0,0,i])
            {
              translate([0,hotend_mount_r,hm_stud_block_height*0.5])
              {
                // Stud blocks
                cube([hm_stud_block_size, hm_stud_block_size, hm_stud_block_height], center=true);
                // Stud block tapers
                for(j =  [-hm_stud_block_size*0.5+hm_stud_taper_thick*0.5, hm_stud_block_size*0.5-hm_stud_taper_thick*0.5])
                  translate([j,0,0])
                    hull()
                    {
                      translate([0,0,hm_stud_block_height*0.5-0.5])
                        cube([hm_stud_taper_thick, hm_stud_block_size, 1], center=true);
                      translate([0,(-hm_stud_block_size*0.5-0.5),(hm_stud_block_height*0.5+hm_stud_taper_height*0.5)])
                        cube([hm_stud_taper_thick, 1, hm_stud_taper_height], center=true);
                    }
               }

            }
          // Mount body
          hull()
          {
            for(i = [0,120,240])
              rotate([0,0,i])
                translate([0, hotend_mount_r-hm_stud_block_size*0.5-0.5, hm_center_height*0.5+(hm_height-hm_center_height)])
                  cube([hm_stud_block_size, 1, hm_center_height], center=true);
          }
        }
        // Mount stud recess and mount screw holes
        for(i = [0,120,240])
          rotate([0,0,i])
          {
            translate([0,hotend_mount_r,0])
            {
              // Stud recess
              translate([0,0,hm_stud_recess_h*0.5-ff])
                cylinder(h=hm_stud_recess_h+ff, d=hm_stud_recess_d, center=true);
              // M3 screw hole
              translate([0,0,hm_stud_block_height*0.5-hm_stud_block_bridge_gap])
                cylinder(h=hm_stud_block_height, d=hotend_m3_hole_d, center=true);
            }
          }

        // Hotend recess
        translate([0,0, hm_hotend_recess_h*0.5+(hm_height-hm_center_height)-ff])
          cylinder(h=hm_hotend_recess_h+ff, d=hm_hotend_recess_d, center=true);
        // Pass-through for bowdent tube and tube collet
        cylinder(h=hm_height*3, d=hm_hotend_tube_d, center=true);
        // Hotend securing screw holes
        for(i = [-hm_secure_screw_spacing*0.5,hm_secure_screw_spacing*0.5])
          translate([i,0,hm_hotend_recess_h-hm_secure_screw_offset_from_top+(hm_height-hm_center_height)])
            rotate([90,0,0])
              cylinder(h=effector_d, d=hm_secure_screw_d, center=true);
        if (hm_jhead)
          translate([0,0, -hm_jhead_nuttrap_h*0.5+(hm_height-hm_jhead_nuttrap_offset_from_top)])
            cylinder(h=hm_jhead_nuttrap_h, d=hm_jhead_nuttrap_d, $fn = 6, center=true);
    
      }
          
}*/
