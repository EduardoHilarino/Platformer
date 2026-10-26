
 if (!Activated) 
 {
	 // Save the player position on respawn
	 other.respawn_x = other.x;
	 other.respawn_y = other.y;

	 // Marks as activated
	 Activated = true; 
	 
	 show_debug_message("Checkpoint Actived")
 }