// ** Particle Debug **

draw_set_color(c_white);
draw_set_alpha(1);

draw_text(
    10, 10,
    "Particles: " + string(instance_number(Obj_Particle))
);