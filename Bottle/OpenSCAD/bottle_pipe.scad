
$fa = 1;
$fs = 0.4;

bottle_height=195;
pipe_height=132;
pipe_thickness=4.2;
pipe_wall=1;

difference() {
    cylinder(h=pipe_height, d=pipe_thickness);
    translate([0,0,-1])
    cylinder(h=pipe_height+2, d=pipe_thickness - 2*pipe_wall);
}
