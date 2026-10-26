	
	// ** 1. Player Input **

	var move = keyboard_check(ord("D")) - keyboard_check(ord("A"));

	var jump_pressed = keyboard_check_pressed(vk_space);
	var jump_held = keyboard_check(vk_space);
	
	var dash = keyboard_check_pressed(vk_shift);
	
	// ** 2. Verify Ground **

	grounded = place_meeting(x, y + 1, Obj_Solid);

		// Updates coyote time
		if (grounded) 
		{coyote_timer = coyote_frames;}
		
		else 
		{coyote_timer = max(0, coyote_timer - 1);}

		// Reset Dash
		if (grounded && state != PlayerState.DASH) 
		{dash_available = true;}

		// Start Dash
		if (dash && dash_available && !grounded && state != PlayerState.DEATH) 
		{
		    dash_available = false;
		    Scr_Player_ChangeState(PlayerState.DASH);
		}

	// ** 3. Jump Buffer **

	if (jump_pressed) 
	{jump_buffer = buffer_frames;}
	
	else 
	{jump_buffer = max(0, jump_buffer - 1);}


	// ** 4. Turn Detection with Memory **

		 // Put old direction in memory per some frames after the key is released
		 if (move == 0) 
		 {turn_grace_timer = max(0, turn_grace_timer - 1);}
		 
		 else if (move == last_move)
		 {turn_grace_timer = turn_grace_frames;}
		 
		 // Detects a new direction
		 var direction_changed = (move != 0 && last_move != 0 && move != last_move);

		 // Verify if still has momentum
		 var has_momentum = (move != 0 && abs(hsp) > 0.15 && sign(hsp) != move);

		 // Updates the direction in memory
		 if (move != 0) 
		 {
		     last_move = move;
		     turn_grace_timer = turn_grace_frames;
		 }


	// **  5. State Machine **
	
	switch (state) {

	    case PlayerState.IDLE:

	        if (jump_buffer > 0 && coyote_timer > 0)
			{Scr_Player_Jump();}
			
	        else if (direction_changed && has_momentum && turn_grace_timer > 0 && grounded)
			{Scr_Player_ChangeState(PlayerState.TURN);}
			
	        else if (!grounded)
			{Scr_Player_ChangeState(PlayerState.FALL);}
			
	        else if (move != 0 || abs(hsp) > 0.10)
			{Scr_Player_ChangeState(PlayerState.RUN);}
			
			
	        break;


	    case PlayerState.RUN:
			
			
	        if (jump_buffer > 0 && coyote_timer > 0)
			{Scr_Player_Jump();}
			
	        else if (direction_changed && has_momentum && turn_grace_timer > 0 && grounded) 
			{ Scr_Player_ChangeState(PlayerState.TURN);}
			
	        else if (!grounded) 
			{Scr_Player_ChangeState(PlayerState.FALL);}
			
	        else if (move == 0 && abs(hsp) <= 0.10) 
			{Scr_Player_ChangeState(PlayerState.IDLE);}

	        break;
			
			
	    case PlayerState.TURN:

		    // Makes the animation go until the end
		    // Horizontal physics still works

		    if (jump_buffer > 0 && coyote_timer > 0) 
			{Scr_Player_Jump();}
			
		    else if (!grounded)
			{is_turning = false; Scr_Player_ChangeState(PlayerState.FALL);}

		    break;

	    case PlayerState.JUMP:
		
	        if (vsp >= 0) 
			{Scr_Player_ChangeState(PlayerState.FALL);}
			
	        break;


		case PlayerState.FALL:

		    if (grounded)
			{

		        if (jump_buffer > 0)
				{Scr_Player_Jump();}
		       
				else if (abs(hsp) > 0.10)
				{Scr_Player_ChangeState(PlayerState.RUN);}
		       
				else {Scr_Player_ChangeState(PlayerState.IDLE);}
		    }

		    break;

					
		case PlayerState.DASH:

	    // Define dash direction only once
	    if (!dashed)
		{
	        var _left = keyboard_check(ord("A"));
	        var _right = keyboard_check(ord("D"));
	        var _down = keyboard_check(ord("S"));
	        var _up = keyboard_check(ord("W"));

	        var _input_x = _right - _left;
	        var _input_y = _down - _up;

	        // Use facing direction if no input
	        if (_input_x == 0 && _input_y == 0)
			{
	            _input_x = facing;
	        }

	        // Normalize diagonal movement
			var _length = (_input_x != 0 && _input_y != 0) ? 1.41421356 : 1;

			dash_dir_x = _input_x / _length;
			dash_dir_y = _input_y / _length;
			
			audio_play_sound(Snd_dash,  0 ,0, 0.1, 0, random_range(0.7, 2))
			
			instance_create_layer(x, y, "Entitys", Obj_shake);
			
	        dashed = true;
	        tempo_dash = dash_duration;
	    }

	    // Apply dash velocity
	    hsp = dash_dir_x * vel_dash;
	    vsp = dash_dir_y * vel_dash;

	    tempo_dash--;
		
		if(tempo_dash % 2 == 0)
		{
			
		var _rast = instance_create_layer(x, y, "Glow", Obj_rastro)

		_rast.image_xscale = image_xscale
		_rast.sprite_index = sprite_index
		_rast.image_index = image_index;
		_rast.image_speed = 0;	
		
		}
		
	    if (tempo_dash <= 0) 
		{
	        dashed = false;

	        if (!grounded) 
			{Scr_Player_ChangeState(PlayerState.FALL);}
			
	        else if (abs(hsp) > 0.10) 
			{Scr_Player_ChangeState(PlayerState.RUN); }
			
	        else
			{Scr_Player_ChangeState(PlayerState.IDLE);}
	    }
		
		

	    break;
			
	    case PlayerState.DEATH:

	        // Any moviment until animation is complete
	        exit;
		
		case PlayerState.WIN:
		
			sprite_index = Spr_Player_win;
			exit;
			
	}


	// ** 6. Horizontal Moviment **
	if (state != PlayerState.DASH)
	{
		var target_hsp = move * max_hsp;
		var rate = acceleration;

		if (move == 0) 
		{rate = deceleration;}
		
		else if (hsp != 0 && sign(hsp) != move) 
		{rate = turn_acceleration;}

			// Aproximates the speed with the target speed
			if (hsp < target_hsp) 
			{hsp = min(hsp + rate, target_hsp);}
			
			else if (hsp > target_hsp) 
			{hsp = max(hsp - rate, target_hsp);}
	}

	// ** 7. Executes Jump **

		// The jump is now done by the state machine


	// ** 8. Dynamic Gravity **
	
	if (state != PlayerState.DASH)
	{
		if (!grounded || vsp < 0) 
		{
		    if (vsp < 0) 
			{
		        if (jump_held) 
				{vsp += gravity_up;}
				
		        else 
				{vsp += gravity_cut; }
		    }
			
		    else
			{vsp += gravity_down;}
			
		    vsp = min(vsp, max_fall_speed);
		}
		
		else
		{vsp = 0;}
	}

	// ** 9. Horizontal Colisions **

		// Fractionary moviments
		x_remainder += hsp;

		// Get pixel perfects
		var move_x = floor(abs(x_remainder)) * sign(x_remainder);

		x_remainder -= move_x;

		// Aplicates moviment pixel per pixel
		repeat (abs(move_x)) 
		{
		    var dir_x = sign(move_x);

		    if (!place_meeting(x + dir_x, y, Obj_Solid)) 
			{x += dir_x;}
			
		    else
			{
		        hsp = 0;
		        x_remainder = 0;
		        break;
		    }
		}


	// ** 10. Vertical Colisions **

		// Fractionary moviments
		y_remainder += vsp;

		// Get pixel perfects
		var move_y = floor(abs(y_remainder))
		           * sign(y_remainder);

		y_remainder -= move_y;

		// Aplicates moviment pixel per pixel
		repeat (abs(move_y))
		{
		    var dir_y = sign(move_y);

		    if (!place_meeting(x, y + dir_y, Obj_Solid))
			{y += dir_y;}
			
		    else
			{
		        vsp = 0;
		        y_remainder = 0;
		        break;
		    }
		}

		// Update Ground After Collisions
		grounded = place_meeting(x, y + 1, Obj_Solid);
		
	// ** 11. Updates Animations **

		// Updates visual direction
		if (state == PlayerState.TURN) 
		{facing = turn_direction;}
		
		else if (move != 0)
		{facing = move;}

		image_xscale = facing;
