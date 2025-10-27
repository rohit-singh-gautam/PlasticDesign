include <BOSL2/std.scad>

$fa = 1;
$fs = 0.4;

// Card parameter is only for reference not used.
// card_height=54;
// card_width=86;
// card_thick=1;

holder_internal_height=100;
holder_internal_width=55;
holder_internal_thick=2;
material_thick=1.8;
holder_side_thick=4;
holder_width=holder_internal_width + holder_side_thick * 2;
holder_height=holder_internal_height+holder_side_thick;
holder_thick=holder_internal_thick + material_thick*2;
notch_width=15;
notch_height=5;
notch_cube_width=notch_width - notch_height;
notch_from_top=4.6;
pullout_width=13;
pullout_height=28;
pullout_cube_height=pullout_height - pullout_width;
pullout_from_internal_bottom=10;

difference() {
    cuboid([holder_width, holder_thick, holder_height], rounding=holder_thick/2);
    translate([0, 0, holder_side_thick])
        cube([holder_internal_width, holder_internal_thick, holder_internal_height], center = true);
    
    translate([0, (holder_internal_thick+material_thick)/2, -(holder_internal_height-pullout_height)/2 + holder_side_thick + pullout_from_internal_bottom])
    union() {
        cube([pullout_width, material_thick + 0.02, pullout_cube_height], center=true);
        translate([0, 0, pullout_cube_height/2])
            rotate([90, 0, 0])
            cylinder(h=material_thick + 0.02, d=pullout_width, center=true);
        translate([0, 0, -pullout_cube_height/2])
            rotate([90, 0, 0])
            cylinder(h=material_thick + 0.02, d=pullout_width, center=true);
    }
    translate([0, (holder_internal_thick+material_thick)/2, (holder_internal_height-notch_height)/2 - notch_from_top])
    union() {
        cube([notch_cube_width, material_thick + 0.02, notch_height], center=true);
        translate([notch_cube_width/2, 0, 0])
            rotate([90, 0, 0])
            cylinder(h=material_thick + 0.02, d=notch_height, center=true);
        translate([-notch_cube_width/2, 0, 0])
            rotate([90, 0, 0])
            cylinder(h=material_thick + 0.02, d=notch_height, center=true);
    }
}