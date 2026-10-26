// Turn Animation
if (state == PlayerState.TURN && sprite_index == Spr_Player_turn) {

    is_turning = false;

	if (!place_meeting(x, y + 1, Obj_Solid)) {
    Scr_Player_ChangeState(PlayerState.FALL);
	}	
	
    else if (abs(hsp) > 0.10) {
        Scr_Player_ChangeState(PlayerState.RUN);
    }
	
    else {
        Scr_Player_ChangeState(PlayerState.IDLE);
    }
}

// Death Animation
if (state == PlayerState.DEATH && sprite_index == Spr_Player_death) {
    Scr_Player_respawn();
	audio_play_sound(Snd_revive,  0 ,0, 0.1, 0, random_range(0.7, 2))
    is_dead = false;
    is_turning = false;

    Scr_Player_ChangeState(PlayerState.IDLE);
}

if (state == PlayerState.WIN && sprite_index == Spr_Player_win) {

	image_speed = 0;
	image_index = 5;
	audio_play_sound(Snd_Victory_dingle, 0, 0, 0.2, 0)
	audio_play_sound(Snd_Victory_voice, 0, 0, 0.2, 0)
	hsp = 0;
}