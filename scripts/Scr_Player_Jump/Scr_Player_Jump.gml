
function Scr_Player_Jump() {

    vsp = jump_speed;

    jump_buffer = 0;
    coyote_timer = 0;

    grounded = false;

    audio_play_sound(Snd_jump, 0, false, 0.1, 0, random_range(0.9, 1.1));

    Scr_Player_ChangeState(PlayerState.JUMP);
}
