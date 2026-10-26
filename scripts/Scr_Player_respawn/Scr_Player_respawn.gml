function Scr_Player_respawn(){

	// Comes back to respawn position
	x = respawn_x;
	y = respawn_y;
	
	// Reset the speed
	hsp = 0;
	vsp = 0;
	
	// Reset fractionary moviment
	x_remainer = 0;
	y_remainer = 0;
	
	// Reset timers
	coyote_timer = 0;
	jump_buffer = 0;
	
	// Reset States
	grounded = false
	is_dead = false
}