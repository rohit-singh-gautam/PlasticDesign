use <threads-scad/threads.scad>

$fa = 1;
$fs = 0.4;

cap_internal_diameter=42;
cap_thread_size=1;
cap_thread_pitch=3; // gap between threads
cap_size=39;
cap_internal_diameter_without_thread=cap_internal_diameter - cap_thread_size * 2;

bottle_head_thickness=1;
bottle_head_thread_pitch=cap_thread_pitch;
bottle_with_thread_diameter=cap_internal_diameter;
bottle_head_thread_size=cap_thread_size;
bottle_head_height=25;
bottle_head_thread_height=12;
bottle_head_without_thread_diameter=bottle_with_thread_diameter - 2 * bottle_head_thread_size;
bottle_head_internal=bottle_head_without_thread_diameter - 2*bottle_head_thickness;

//RodStart(bottle_with_thread_diameter, bottle_head_height, thread_len=bottle_head_thread_height, thread_diam=bottle_head_without_thread_diameter, thread_pitch=bottle_head_thread_pitch);

difference() {
    union() {
        cylinder(h=bottle_head_height-bottle_head_thread_height+1, d=bottle_head_without_thread_diameter);
        translate([0, 0, bottle_head_height-bottle_head_thread_height])
            ScrewThread(bottle_with_thread_diameter, bottle_head_thread_height, bottle_head_thread_pitch, tooth_height=bottle_head_thread_size, tooth_angle=30);
    }
    translate([0, 0, -1])
    cylinder(h=bottle_head_height+4, d=bottle_head_internal);
}


module RodStart11(diameter, height, thread_len=0, thread_diam=0, thread_pitch=0) {
  // A reasonable default.
  thread_diam = (thread_diam==0) ? 0.75*diameter : thread_diam;
  thread_len = (thread_len==0) ? 0.5*diameter : thread_len;
  thread_pitch = (thread_pitch==0) ? ThreadPitch(thread_diam) : thread_pitch;

  cylinder(r=diameter/2, h=height, $fn=24*diameter);

  translate([0, 0, height])
    ScrewThread(thread_diam, thread_len, thread_pitch,
      tip_height=thread_pitch, tip_min_fract=0.75);
}
