/*#################################################################################*\
   Revised Knob.scad
	-----------------------------------------------------------------------------

	Developed by:			Richard A. Milewski
	Description:            
   	

	Version:                1.0
	Creation Date:          
	Modification Date:      
	Email:                  richard+scad@milewski.org
	Copyright 				©2023 by Richard A. Milewski
    License - CC-BY-NC      https://creativecommons.org/licenses/by-nc/3.0/ 

\*#################################################################################*/


/*#################################################################################*\
    
    Notes

	Requires the BOSL2 library for OpenSCAD  https://github.com/revarbat/BOSL2/wiki

\*#################################################################################*/


/*#################################################################################*\
    
    CONFIGURATION

\*#################################################################################*/
include <BOSL2/std.scad>	// https://github.com/revarbat/BOSL2/wiki

module hide_variables () {}  // variables below hidden from Customizer

$fn = 72;               //openSCAD roundness variable
eps = 0.01;             //fudge factor to display holes properly in preview mode
$slop = 0.025;			//printer dependent fudge factor for nested parts
 
shaft = [10, undef, 15];
shaft_hole = [6, undef, 10.2];
knob = [16, undef, 10];
rib = [4, undef, 10];
ribs = 12;
round = 1;
/*#################################################################################*\
    
    Main

\*#################################################################################*/

spacer();

/*#################################################################################*\
    
    Modules

\*#################################################################################*/


module spacer() {
    move([-100,-100]) import("BASE.STL");
}


module knob() {
    diff() 
        cyl(h = knob.z, d = knob.x, rounding = round, anchor = BOT) {
            attach(BOT) cyl(h = shaft.z, d = shaft.x, anchor = TOP);
            up(eps + shaft.z - shaft_hole.z)
            tag("remove") attach(BOT) cyl(h = shaft_hole.z, d = shaft_hole.x, anchor = TOP);
        }
        zrot_copies(n = ribs, d = knob.x-rib.x/2) cyl(h = rib.z, d = rib.x, rounding = round, anchor = BOT);
}

module button() {    
    
        difference() {
            move([-100,-100,-7]) import("PUSHER.STL");
            #cuboid(20, anchor = TOP);
        }
}


module echo2(arg) {						// for debugging - puts space around the echo.
	echo(str("\n\n", arg, "\n\n" ));
}