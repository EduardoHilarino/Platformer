// Makes the death don't start auto
if (!other.is_dead)
{	
	other.is_dead = true;
	
	// Makes the player respawn
	with (other) {
		Scr_Player_respawn(); 
	}
}