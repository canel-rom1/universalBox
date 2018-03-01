/*
  Project name: Universal box
  File: box.scad
  Version: v0.1
  Create by: Rom1 <rom1@canel.ch> - CANEL - https://www.canel.ch
  Date: 01/03/2018
  License: GNU GENERAL PUBLIC LICENSE v3
  Programme: openscad
  Description: Box for different usages
*/

include <config.scad>;


module drilling(x, y, diameter, length, face=0, _mirror=1)
// face: base=0 front=1, right=2, left=3, back=4
{
    module _drilling(x, y, diameter, length)
    {
        translate([x,
                   y,
                  0])
            cylinder(length, d=diameter, $fn=36);
    }
    /* Base */
    if(face == 0)
        _drilling(x, y, diameter, length);
    /* Front */
    else if(face == 1)
        rotate([90, 0, 0]) translate([0, 0, -length]) 
            _drilling(x, y, diameter, length);
    /* Right */
    else if(face == 2)
        rotate([0, -90, 0]) translate([0, 0, -box_x])
            _drilling(y, x, diameter, length);
    /* Left */
    else if(face == 3)
        if(_mirror == 0)
            rotate([0, -90, 0]) translate([0, 0, -length])
                _drilling(y, x, diameter, length);
        else
            rotate([0, -90, 0]) translate([0, box_y, -length]) mirror([0, 1, 0])
                _drilling(y, x, diameter, length);
    /* Back */
    else if(face == 4)
        if(_mirror == 0)
            rotate([90, 0, 0]) translate([0, 0, -box_y])
                _drilling(x, y, diameter, length);
        else
            rotate([90, 0, 0]) translate([box_x, 0, -box_y]) mirror([1,0,0])
                _drilling(x, y, diameter, length);
}

module box()
{
    difference()
    {
        cube([box_x,
              box_y,
              box_z]);

        translate([box_thinkness,
                   box_thinkness,
                   box_thinkness])
            cube([box_inside_x,
                  box_inside_y,
                  box_inside_z]);

        translate([box_thinkness/2,
                   box_thinkness/2,
                   box_z - cover_z]) 
            cube([cover_x, cover_y, cover_z]);

        drilling_diagram();
    }
}

box();


// vim: ft=openscad tw=100 et ts=4 sw=4
