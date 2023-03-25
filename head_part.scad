include <bosl2/std.scad>
include <bosl2/bottlecaps.scad>


//    $fn=360;

module head() {
    difference() {
        sp_cap(48, 400, 2);
        arc_copies(
            d=25, 
            n=5
        )
        cube([15, 3, 15], center=true);
    }
}



head();