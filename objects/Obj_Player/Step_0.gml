	
	// ** 1. Player Input **

	var move = keyboard_check(ord("D")) - keyboard_check(ord("A"));

	var jump_pressed = keyboard_check_pressed(vk_space);
	var jump_held = keyboard_check(vk_space);
	
	var dash = keyboard_check_pressed(vk_shift);
	
	// ** 2. Verify Ground **

	grounded = place_meeting(x, y + 1, Obj_Solid);

		// Updates coyote timer
		if (grounded) 
		{coyote_timer = coyote_frames;}
		
		else 
		{coyote_timer = max(0, coyote_timer - 1);}

		// Reset Dash
		if (grounded && state != PlayerState.DASH) 
		{dash_available = true;}

		// Start Dash
		if (dash && dash_available && !grounded && state != PlayerState.DEATH && state != PlayerState.WIN) 
		{
		    dash_available = false;
		    Scr_Player_ChangeState(PlayerState.DASH);
		}

	// ** 3. Jump Buffer **

	if (jump_pressed) 
	{jump_buffer = buffer_frames;}
	
	else 
	{jump_buffer = max(0, jump_buffer - 1);}

	// ** 4. Wall Detection **
	
		// Check horizontal walls
		var wall_left = place_meeting(x - 1, y, Obj_Solid);
		var wall_right = place_meeting(x + 1, y, Obj_Solid);
		
		// Reset wall direction
		wall_dir = 0;
		
		// Left wall
		if (wall_left && !wall_right)
		{
			wall_dir = -1;
		}
		
		// Right wall
		else if (!wall_left && wall_right)
		{
			wall_dir = 1;
		}
		
		// Both walls
		
		else if (wall_left && wall_right)
		{
			if (move != 0)
			{
				wall_dir = move;
			}
			
			else if (last_wall_dir != 0)
			{
				wall_dir = last_wall_dir;
			}
			
			else
			{
				wall_dir = facing;
			}
		}
	
	// ** 5. Wall Coyote Time **
	
	if (grounded)
	{
		// Reset wall jump on ground
		wall_coyote_timer = 0;
		wall_jump_lock_timer = 0;
		wall_sliding = false;
	}
	
	else 
	{
		// Update wall jump control lock
		if (wall_jump_lock_timer > 0)
		{ 
			wall_jump_lock_timer--;
		}
		
		// Save wall contact
		if (wall_dir != 0 && wall_jump_lock_timer <= 0 && state != PlayerState.DASH)
		{
				wall_coyote_timer = wall_coyote_frames;
				last_wall_dir = wall_dir;
		}
		
		else
		{
			wall_coyote_timer = max(0, wall_coyote_timer - 1);
		}
	}
	
	// ** 6. Turn Detection with Memory **

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

	
	// ** 7. Wall Jump Execution **
	
		// Check wall jump conditions
		var can_wall_jump = (!grounded &&
		jump_buffer > 0 &&
		coyote_timer <= 0 &&
		wall_coyote_timer > 0 &&
		wall_jump_lock_timer <= 0 &&
		last_wall_dir != 0 &&
		state != PlayerState.WIN &&
		state != PlayerState.DASH &&
		state != PlayerState.DEATH);
		
		if (can_wall_jump)
		{
			// Push away from wall
			hsp = -last_wall_dir * wall_jump_hsp;
			
			// Vertical Jump Impulse
			vsp = wall_jump_vsp;
			
			// Reset Fractionary Moviment
			x_remainder = 0;
			y_remainder = 0;
			
			// Lock Horizontal Steering
			wall_jump_lock_timer = wall_jump_lock_frames;
			
			// Consume jump buffer
			jump_buffer = 0;
			
			// Consume Wall coyote time
			wall_coyote_timer = 0;
			
			// Stop Wall Sliding
			wall_sliding = false;
			
			// Face jump direction
			facing = -last_wall_dir;
			
			// Change state
			Scr_Player_ChangeState(PlayerState.JUMP);
		}
	
	// **  8. State Machine **
	
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

		        if (jump_buffer > 0 && coyote_timer > 0)
				{Scr_Player_Jump();}
		       
				else if (grounded)
				{
					if (abs(hsp) > 0.10)
					{Scr_Player_ChangeState(PlayerState.RUN);}
					
					else 
					{Scr_Player_ChangeState(PlayerState.IDLE);}
				}
				
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
				
				// Dash Particles
				// Create dash particle burst
				repeat(10)
				{
					// Random spawn offset
					var _px = x + random_range(-8, 8);
					var _py = y + random_range(-8, 8);
					
					// Create Particle
					var _particle = instance_create_layer( _px, _py, "Glow", Obj_Particle);
					
					// ** Dash Particle Debug **
					show_debug_message(
					    "Dash Particle Created: X="
					    + string(_particle.x)
					    + " Y="
					    + string(_particle.y)
					);
					
					// Particle type
					_particle.particle_type = 1;
					
					// Random spread
					var _spread = random_range(-0.3, 0.3);
					var _speed = random_range(0.5, 1);
					
					// Move opposite to dash
					_particle.hsp = dash_dir_x* _speed + (-dash_dir_y * _spread);
					_particle.vsp = dash_dir_y * _speed + (-dash_dir_x * _spread);
					
					// Lifetime
					_particle.life = irandom_range(90, 120);
					_particle.max_life = _particle.life;
					
					// Appareance
					_particle.particle_color = c_white;
					_particle.particle_alpha = 1;
					
					// Slow down
					_particle.friction_amount = 0.97;
				}				
			
				audio_play_sound(Snd_dash,  0 ,0, 0.3, 0, random_range(0.7, 2))
			
				instance_create_layer(x, y, "Entitys", Obj_shake);
			
		        dashed = true;
		        tempo_dash = dash_duration;
		    }

		    // Apply dash velocity
		    hsp = dash_dir_x * vel_dash;
		    vsp = dash_dir_y * vel_dash;

		    tempo_dash--;
		
			if(tempo_dash % 3 == 0)
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


	// ** 9. Horizontal Moviment **
	if (state != PlayerState.DASH && wall_jump_lock_timer <= 0)
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

	// ** 10. Executes Jump **

		// The jump is now done by the state machine


	// ** 11. Dynamic Gravity **

	if (state != PlayerState.DASH)
	{
	    if (!grounded || vsp < 0)
	    {
	        // Escolhe a gravidade que você já utiliza.
	        var _gravity;

	        if (vsp < 0)
	        {
	            _gravity = jump_held ? gravity_up : gravity_cut;
	        }
	        else
	        {
	            _gravity = gravity_down;
	        }

	        // Ajustes iniciais para testar.
	        var _apex_threshold = 0.75;
	        var _apex_multiplier = 0.6;

	        // Reduz a gravidade perto do topo do pulo.
	        var _normal_jump =
	            state == PlayerState.JUMP ||
	            state == PlayerState.FALL;

	        if (_normal_jump
	            && jump_held
	            && !wall_sliding
	            && abs(vsp) < _apex_threshold)
	        {
	            _gravity *= _apex_multiplier;
	        }

	        vsp += _gravity;
	        vsp = min(vsp, max_fall_speed);
	    }
	    else
	    {
	        vsp = 0;
	    }
	}
	
	
	// ** 12. Horizontal Colisions **

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


	// ** 13. Wall slide **
		
		// Update Wall Detection After Horizontal Movement 
		wall_left = place_meeting(x - 1, y, Obj_Solid);
		wall_right = place_meeting(x + 1, y, Obj_Solid);

		wall_dir = 0;

		if (wall_left && !wall_right)
		{
		    wall_dir = -1;
		}
		else if (wall_right && !wall_left)
		{
		    wall_dir = 1;
		}
		else if (wall_left && wall_right)
		{
		    wall_dir = (move != 0) ? move : facing;
		}
		
		// Reset wall sliding
		wall_sliding = false;
		
		// Verify wall slide condition
		var can_wall_slide = ( 
		!grounded &&
		wall_dir != 0 &&
		move == wall_dir &&
		vsp > 0 &&
		wall_jump_lock_timer <= 0 &&
		state != PlayerState.WIN &&
		state != PlayerState.DEATH &&
		state != PlayerState.DASH);
		
		if (can_wall_slide)
		{
			// Limit Falling speed
			vsp = min(vsp, wall_slide_speed);
			
			// Enable wall sliding
			wall_sliding = true;
		}
		
		
	// ** 14. Vertical Colisions **

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
		
	// ** 15. Updates Animations **

		// Updates visual direction
		if (state == PlayerState.TURN) 
		{facing = turn_direction;}
		
		else if (wall_coyote_timer > 0)
		{
			// Facing was defined when the wall jump started.
		}
		
		else if (move != 0)
		{facing = move;}

		image_xscale = facing;
