// ** Dash **
	vel_dash = 4;
	dash_duration = 8;
	tempo_dash = 0;

	dashed = false;

// ** Dash Control **
	dash_available = true;
	dash_dir_x = 0;
	dash_dir_y = 0;

// ** Horizontal Movement **
	hsp = 0;
	max_hsp = 1.8;

	acceleration = 0.10;
	deceleration = 0.055;
	turn_acceleration = 0.22;

// ** Vertical Movement **
	vsp = 0;

	jump_speed = -4.2;
	gravity_up = 0.24;
	gravity_down = 0.36;
	gravity_cut = 0.60;
	max_fall_speed = 4.5;

// ** Coyote Time **
	coyote_frames = 6;
	coyote_timer = 0;

// ** Jump Buffer **
	buffer_frames = 6;
	jump_buffer = 0;

// ** Fractionary Movement **
	x_remainder = 0;
	y_remainder = 0;

// ** Ground **
	grounded = false;

// ** Position **
	x = round(x);
	y = round(y);

// ** Direction **
	facing = 1;
	image_xscale = facing;

// ** Turn Animation **
	is_turning = false;
	turn_direction = 1;

	last_move = 0;
	turn_grace_frames = 8;
	turn_grace_timer = 0;

// ** Death System **
	is_dead = false;

// ** State Machine **
	state = PlayerState.IDLE;
	previous_state = PlayerState.IDLE;

// ** Checkpoint **
	respawn_x = x;
	respawn_y = y;
	
// ** Collision Mask **
	mask_index = Spr_player_Idle;
	
// ** Camera **
	if (!instance_exists(obj_player_pixel))
	{
		instance_create_layer(x, y, "Camera", obj_player_pixel);
	
	}
	
// ** Win **
	win = false;
	
	
	// ============================================================
// PLAYER - CREATE
// ATTACHED LIGHT
// ============================================================

// ** Create Player Light **
player_light = instance_create_layer(
    x,
    y,
    "Instances_Lighting",
    Obj_LightSource
);

// ** Follow Player **
player_light.light_follow = id;

// ** Light Offset **
player_light.light_offset_x = 0;
player_light.light_offset_y = -4;

// ** Light Settings **
player_light.light_radius = 45;
player_light.light_intensity = 0.12;

player_light.light_color = make_color_rgb(
    180,
    210,
    255
);

// ** Soft Light **
player_light.light_falloff = 1.5;
player_light.light_core_size = 0.12;