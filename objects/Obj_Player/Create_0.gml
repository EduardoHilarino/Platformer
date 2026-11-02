// ** Dash **
	vel_dash = 4.8;
	dash_duration = 9;
	tempo_dash = 0;
	dashed = false;

// ** Dash Control **
	dash_available = true;
	dash_dir_x = 0;
	dash_dir_y = 0;

// ** Horizontal Movement **
	hsp = 0;
	max_hsp = 1.8;

	acceleration = 0.40;
	deceleration = 0.45;
	turn_acceleration = 0.55;

// ** Vertical Movement **
	vsp = 0;

	jump_speed = -3.6;
	gravity_up = 0.20;
	gravity_down = 0.30;
	gravity_cut = 0.65;
	max_fall_speed = 3.2;

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

// ** Wall Jump System **
	wall_dir = 0;
	last_wall_dir = 0;

	wall_coyote_frames = 6;
	wall_coyote_timer = 0;

	wall_jump_hsp = 2.6;
	wall_jump_vsp = jump_speed;

	wall_jump_lock_frames = 6;
	wall_jump_lock_timer = 0;

// ** Wall Slide **
	wall_slide_speed = 0.7;
	wall_sliding = false;