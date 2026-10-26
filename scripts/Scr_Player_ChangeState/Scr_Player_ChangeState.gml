function Scr_Player_ChangeState(_new_state) {
	
	// ** Exit Previous State **
	if (state == PlayerState.TURN) {
	    is_turning = false;
	}
	
    if (state == _new_state) {
        return;
    }

    previous_state = state;
    state = _new_state;

    switch (state) {

        case PlayerState.IDLE:
            sprite_index = Spr_player_Idle;
            break;

        case PlayerState.RUN:
			audio_play_sound(foot_07_grass_04, 0, 1, 0,2, random_range(.5,1.5));
            sprite_index = Spr_Player_run;
            break;

        case PlayerState.TURN:
            is_turning = true;
            turn_direction = facing;
            sprite_index = Spr_Player_turn;
            break;

        case PlayerState.JUMP:
            sprite_index = Spr_Player_Jump;
            break;

        case PlayerState.FALL:
            sprite_index = Spr_Player_fall;
            break;

        case PlayerState.DEATH:
            is_dead = true;

            hsp = 0;
            vsp = 0;

            x_remainder = 0;
            y_remainder = 0;

            is_turning = false;

            sprite_index = Spr_Player_death;
            break;
		
		case PlayerState.DASH:
			
			dashed = false;
			tempo_dash = dash_duration;
	
			sprite_index = Spr_Player_Dash;
			break;
			
		case PlayerState.WIN:
			
			win = true;
			
			hsp = 0;
            vsp = 0;

            x_remainder = 0;
            y_remainder = 0;
			
			sprite_index = Spr_Player_win;
			
			break;
    }

    image_index = 0;
}