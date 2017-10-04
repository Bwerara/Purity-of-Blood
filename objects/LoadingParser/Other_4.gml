if room == loading
{
	switch type
	{
		case loadType.newGame:
			instance_create_depth(0,0,0,NewGameLoader);
			break;
		case loadType.arena:
			instance_create_depth(0,0,0,ArenaGameLoader);
			break;
	}

	room_goto(roomTo);
}
else
{
	if (!layer_exists("Controllers")) layer_create(-1, "Controllers");
	switch type
	{
		case loadType.newGame:
			instance_create_layer(52,368,"lay_player",objPlayer);
			with instance_create_layer(objPlayer.x,objPlayer.y,"Controllers",Camera) phase = cameraState.player;
			instance_destroy(NewGameLoader);
			break;
		case loadType.arena:
			instance_create_layer(48,128,"lay_player",objPlayer);
			with instance_create_layer(objPlayer.x,objPlayer.y,"Controllers",Camera) phase = cameraState.player;
			instance_destroy(ArenaGameLoader);
			break;
	}
	instance_destroy();
}