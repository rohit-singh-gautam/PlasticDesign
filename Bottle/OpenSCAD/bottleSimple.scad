include <BOSL/constants.scad>
use <BOSL/threading.scad>

$fa = 1;
$fs = 0.4;

cap_internal_diameter=42;
cap_thread_size=1.2;
cap_thread_pitch=3; // gap between threads
cap_height=39;
cap_internal_diameter_without_thread=cap_internal_diameter - cap_thread_size * 2;

bottle_wall_thickness=3;
bottle_head_thickness=bottle_wall_thickness;
bottle_head_thread_pitch=cap_thread_pitch;
bottle_head_thread_tooth_angle=30;
bottle_with_thread_diameter=cap_internal_diameter;
bottle_head_thread_size=cap_thread_size;
bottle_head_height=20;
bottle_head_thread_height=12;
bottle_head_without_thread=bottle_head_height-bottle_head_thread_height;
bottle_head_without_thread_diameter=bottle_with_thread_diameter - 2 * bottle_head_thread_size;
bottle_head_internal=bottle_head_without_thread_diameter - 2*bottle_head_thickness;
bottle_height=220;
bottle_height_without_head=bottle_height - bottle_head_height + bottle_head_thickness;
bottle_lower_height=160;
bottle_lower_top_width=140;
bottle_base_width=200;
bottle_twist_degrees=30;
bottle_sides=12;

// bottle upper
bottle_upper_thickness_compensation=3;
bottle_upper_height=bottle_height_without_head - bottle_lower_height;
bottle_top_bottom_upper_ratio=bottle_lower_top_width/bottle_head_without_thread_diameter;
bottle_top_bottom_upper_ratio_internal=(bottle_lower_top_width - bottle_wall_thickness*2*bottle_upper_thickness_compensation)/(bottle_head_without_thread_diameter - bottle_wall_thickness*2*bottle_upper_thickness_compensation);
bottle_upper_slice_resolution=bottle_upper_height/4;

// bottle lower
bottle_lower_thickness_compensation=1.5;
bottle_top_bottom_lower_ratio=bottle_base_width/bottle_lower_top_width;
bottle_top_bottom_lower_ratio_internal=(bottle_base_width - bottle_wall_thickness*2*bottle_lower_thickness_compensation)/(bottle_lower_top_width - bottle_wall_thickness*2*bottle_lower_thickness_compensation);
bottle_lower_slice_resolution=bottle_lower_height/4;

module outer_bottle(height_adjust) {
    union() {
        translate([0, 0, bottle_height_without_head - bottle_head_thickness])
            cylinder(h=bottle_head_height+height_adjust, d=bottle_head_without_thread_diameter);
        rotate_extrude($fn=bottle_sides)
            polygon([
                [0,0],
                [bottle_base_width/2, 0],
                [bottle_lower_top_width/2, bottle_lower_height],
                [bottle_head_without_thread_diameter/2, bottle_height_without_head]
            ]);
    }
}

difference() {
    outer_bottle(0);
    offset(r=-bottle_wall_thickness)
            outer_bottle(2);
}