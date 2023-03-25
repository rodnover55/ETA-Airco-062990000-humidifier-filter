use <bottom_part.scad>
use <head_part.scad>

if (!$preview) {
    $fn=360;
}


bottom_part(
    water_out_diameter=28,
    wall=1.5
);

up(80)
mirror([0,0,1])
color("GreenYellow")
head();