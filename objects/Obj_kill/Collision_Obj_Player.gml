if (other.state != PlayerState.DEATH) {
	audio_play_sound(Snd_death, 0, 0, 0.2, 0,random_range(0.5, 1.5))
    with (other) {
        Scr_Player_ChangeState(PlayerState.DEATH);
    }
}