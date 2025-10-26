use <threads-scad/threads.scad>
use <smooth-prim/smooth_prim.scad>

$fa = 1;
$fs = 0.4;

cap_internal_diameter=42;
cap_thread_size=1.2;
cap_thread_pitch=3; // gap between threads
cap_size=39;
cap_internal_diameter_without_thread=cap_internal_diameter - cap_thread_size * 2;

bottle_wall_thickness=2;
bottle_head_thickness=bottle_wall_thickness;
bottle_head_thread_pitch=cap_thread_pitch;
bottle_head_thread_tooth_angle=45;
bottle_with_thread_diameter=cap_internal_diameter;
bottle_head_thread_size=cap_thread_size;
bottle_head_height=20;
bottle_head_thread_height=12;
bottle_head_without_thread_diameter=bottle_with_thread_diameter - 2 * bottle_head_thread_size;
bottle_head_internal=bottle_head_without_thread_diameter - 2*bottle_head_thickness;
bottle_size=220;
bottle_size_without_head=bottle_size - bottle_head_height + bottle_head_thickness;
bottle_bottom_size=200;
bottle_twist_degrees=30;
bottle_slice_resolution=100;
bottle_sides=12;
bottle_top_bottom_ratio=bottle_bottom_size/bottle_head_without_thread_diameter;
bottle_top_bottom_ratio_internal=(bottle_bottom_size - bottle_wall_thickness*2)/(bottle_head_without_thread_diameter - bottle_wall_thickness*2);

difference() {
    union() {
        rotate([0, 180, 0]) {
            linear_extrude(
                height = bottle_size_without_head,
                twist = bottle_twist_degrees,
                slices = bottle_slice_resolution,
                scale = bottle_top_bottom_ratio,
                center = true // Centers the object along the Z-axis
            ) {
                circle(d=bottle_head_without_thread_diameter, $fn=bottle_sides);
            }
        }
        translate([0, 0, bottle_size_without_head/2]) {
            union() {
                translate([0, 0, -bottle_head_thread_height])
                cylinder(h=bottle_head_height+1, d=bottle_head_without_thread_diameter);
                translate([0, 0, bottle_head_height-bottle_head_thread_height])
                    ScrewThread(bottle_with_thread_diameter, bottle_head_thread_height, pitch=bottle_head_thread_pitch, tooth_height=bottle_head_thread_size, tooth_angle=bottle_head_thread_tooth_angle);
            }
        }
    }
    translate([0, 0, bottle_size_without_head/2]) {
        cylinder(h=bottle_head_height + bottle_wall_thickness, d=bottle_head_internal);
    }
    translate([0, 0, bottle_wall_thickness]) {
        rotate([0, 180, 0]) {
            linear_extrude(
                height = bottle_size_without_head,
                twist = bottle_twist_degrees,
                slices = bottle_slice_resolution,
                scale = bottle_top_bottom_ratio_internal,
                center = true // Centers the object along the Z-axis
            ) {
                circle(d=bottle_head_without_thread_diameter - bottle_wall_thickness*2, $fn=bottle_sides);
            }
        }
    }
}
