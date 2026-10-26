// ============================================================
// OBJ_LIGHTSOURCE - CREATE V1.1
// ============================================================

// ** General Settings **
light_enabled = true;

// ** Light Appearance **
light_radius = 110;
light_intensity = 0.15;
light_color = make_color_rgb(160, 195, 255);

// ** Light Shape **
light_scale_x = 1.0;
light_scale_y = 1.0;

// ** Falloff Settings **
light_falloff = 1.2;
light_core_size = 0.05;

// ============================================================
// ANIMATION
// ============================================================

// ** Flickering **
light_flicker = false;
light_flicker_amount = 0.05;

// ** Pulsation **
light_pulse = false;
light_pulse_speed = 2.0;
light_pulse_amount = 0.08;

// ** Animation Timer **
light_time = 0;
light_phase = random(100);

// ============================================================
// TRANSITIONS
// ============================================================

// ** Fade Speed **
light_fade_speed = 8;

// ** Current Render Values **
light_current_intensity = 0;
light_current_radius = light_radius;

// ============================================================
// FOLLOW SYSTEM
// ============================================================

// ** Instance To Follow **
light_follow = noone;

// ** Follow Offset **
light_offset_x = 0;
light_offset_y = 0;





  