//delete if no longer in arena
if room != rmArena1 && room != rmArena2 && room != rmArena3 && room != rmArena4
{
	instance_destroy();
	instance_destroy(ArenaSettingsManager);
}

//Enemy Name & object list
for (var i = 0; i < numberOfEnemies; i++)
{
	if arenaStats[0] = enemyValues[i,0]
	{
		enemy = enemyValues[i,4];
		break;
	}
	else enemy = noone;
}

//Enemy Number
if !instance_exists(ArenaSettingsManager) && !instance_exists(PauseController)
{
	var count = 0;
	if enemy != noone
	{
		with enemy if actorType != actorTypes.corpse count++;
		if count < arenaStats[1] && spawnTimer == -1
		{
			if room == rmArena1 || room == rmArena4 {var spawnX = 160+random_range(-25,25); var spawnY = -32;}
	   else if room == rmArena2 || room == rmArena3 {var spawnX = 2176+random_range(-225,225); var spawnY = -160;}
	   else {var spawnX = 0; var spawnY = 0;}
			instance_create_layer(spawnX,spawnY,layer_get_id("lay_entities"),enemy);
			spawnTimer = 0;
		}
		if spawnTimer != -1 spawnTimer++;
		if spawnTimer == room_speed*0.5 spawnTimer = -1;
	}
	while count > arenaStats[1] 
	{
		with enemy
		{
			if phase != "dying"
			{
				instance_destroy();
			}
		}
		var count = 0;
		with enemy if phase != "dying" count++;
	}
}

//Enemy Maximum Hp
with enemy hpMax = other.arenaStats[2];

//Enemy Physical Strength
with enemy physicalPower = other.arenaStats[3];

//Enemy Invulnerability
with enemy isInvulnerable = other.arenaStats[4];

//Player Maximum Hp
PlayerStats.hpMax = other.arenaStats[5];

//Player Physical Strength
PlayerStats.physicalPower = other.arenaStats[6];

//Player Invulnerability
PlayerStats.isInvulnerable = other.arenaStats[7];

//Arena Number
switch arenaStats[8]
{
	case "Manor: Small":
		dest = rmArena1;
		break;
	case "Dungeon: Large":
		dest = rmArena2;
		break;
	case "Forest: Large with pitfalls":
		dest = rmArena3;
		break;
	case "Town: Small, Flat and borderless":
		dest = rmArena4;
		break;
}
if room != dest
{
		global.roomTrans = instance_create_depth(player.x,player.y,0,objRoomTransition)
		with global.roomTrans
		{
			roomFrom = room;
			roomTo = other.dest;
		}
}

//Arena platforms
switch arenaStats[9]
{
	case "off":
		instance_deactivate_object(obj_platform_parent);
		layer_set_visible("Tiles_arena_platforms",0)
		break;
	case "on":
		instance_activate_object(obj_platform_parent);
		layer_set_visible("Tiles_arena_platforms",1)
		break;
}

//Arena hook points
switch arenaStats[10]
{
	case "off":
		instance_deactivate_object(obj_grapple_parent);
		layer_set_visible("Tiles_arena_hookPoints",0)
		break;
	case "on":
		instance_activate_object(obj_grapple_parent);
		layer_set_visible("Tiles_arena_hookPoints",1)
		break;
}