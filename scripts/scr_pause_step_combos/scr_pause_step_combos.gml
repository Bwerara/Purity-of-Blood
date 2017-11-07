//scr_menu_navigate();
#region unique navigation

//prev
sXPrev = sX;
sYPrev = sY;
sExpYPrev = sExpY;

//checks
var absHInput = abs(InputManager.moveInputH);
var absVInput = abs(InputManager.moveInputV);
var horInputMoreThanVert = absHInput >= absVInput;

//move left / right / up / down
if  (moveTimer == 0) || 
	(moveTimer >= ceil(0.3 * room_speed) && moveTimer < ceil(1.0 * room_speed) && floor(moveTimer % (ceil(0.35 * room_speed))) == 0) ||
	(moveTimer >= ceil(1.0 * room_speed) && floor(moveTimer%(ceil((1 / 10) * room_speed))) == 0)
{
	if (absHInput > 0.5 && horInputMoreThanVert) {sX += sign(InputManager.moveInputH); movedH = 1;}
	else if InputManager.dRInput {sX++; movedH = 1;}
	else if InputManager.dLInput {sX--; movedH = 1;}
	
	if (sX < 0) sX = array_height_2d(current_menu_options) - 1; 
	else if (sX >= array_height_2d(current_menu_options)) sX = 0;

	if (sY >= array_length_2d(current_menu_options,sX) ) sY = array_length_2d(current_menu_options,sX) - 1;

	if (!slotExpanded)
	{
		if (absVInput > 0.5 && !horInputMoreThanVert) sY += sign(InputManager.moveInputV);
		else if InputManager.dDInput sY++;
		else if InputManager.dUInput sY--;
		
		if (sY < 0) sY = array_length_2d(current_menu_options,sX) - 1;
		else if (sY >= array_length_2d(current_menu_options,sX)) sY = 0;
	}
	else
	{
		if (InputManager.moveInputV > 0.5 && !horInputMoreThanVert) sExpY += sign(InputManager.moveInputV);
		else if InputManager.dDInput sExpY++;
		else if InputManager.dUInput sExpY--;
			
		if (sExpY >= array_length_1d(slot_options)) sExpY = 0;
		else if (sExpY < 0) sExpY = array_length_1d(slot_options) - 1;
		
		if (sX == 0)
		{
			slotExpanded = 0;
			current_menu_options = menu_combos;
		}
	}
}

if (absHInput > 0.5 || absVInput > 0.5 || InputManager.dLInput || InputManager.dRInput || InputManager.dUInput || InputManager.dDInput)
{
	moveTimer++;
}
else { moveTimer = 0 };

if sX != sXPrev || sY != sYPrev || sExpY != sExpYPrev audio_play_sound(snd_menu_navigate,10,0)

#endregion

#region gather new slot data on horizontal change
if (movedH && slotExpanded)
{		
	slot_options = [];
	slot_types = PlayerStats.activeComboSlotNumbers[sX-1];
					
	for(var i = 0; i < PlayerStats.comboSize; i++)
	{
		current_menu_options[i+1, sY] = i;
	}
					
	num = 0;
	for (var i = ds_map_find_first(ComboCache.attackTypes); i != ds_map_find_last(ComboCache.attackTypes); i = ds_map_find_next(ComboCache.attackTypes,i))
	{
		for (var j = 0; j < array_length_1d(slot_types); j++)
		{
			if ComboCache.attackTypes[? i] == slot_types[j]
			{
				slot_options[num] = i;
				num++;
				break;
			}
		}
	}
	for (var i = 0; i < array_length_1d(slot_options); i++)
	{
		if slot_options[i] = PlayerStats.activeComboIDs[sX-1]
		{
			sExpY = i;
			break;
		}
	}
	movedH = 0;
}
#endregion

//select
selection = current_menu_options[sX,sY];

#region (start)		Unpause

if (InputManager.startInput)
{
	instance_activate_all();
	InputManager.startInput = false;
	GameManager.pauseState = PauseState.normal;
	surface_free(GameManager.pauseSplash);
	instance_destroy();
}

#endregion
#region (A)			Select

if (InputManager.aInput == true)
{
	audio_play_sound(snd_menu_select,10,0);
	switch selection
	{
		case "weapon 1":
			slotExpanded = 1;
			sX++;
					
			slot_options = [];
			slot_types = PlayerStats.activeComboSlotNumbers[sX-1];
					
			for(var i = 0; i < PlayerStats.comboSize; i++)
			{
				current_menu_options[i+1, 0] = i;
			}
					
			num = 0;
			for (var i = ds_map_find_first(ComboCache.attackTypes); i != ds_map_find_last(ComboCache.attackTypes); i = ds_map_find_next(ComboCache.attackTypes,i))
			{
				for (var j = 0; j < array_length_1d(slot_types); j++)
				{
					if ComboCache.attackTypes[? i] == slot_types[j]
					{
						slot_options[num] = i;
						num++;
						break;
					}
				}
			}
			for (var i = 0; i < array_length_1d(slot_options); i++)
			{
				if slot_options[i] = PlayerStats.activeComboIDs[sX-1]
				{
					sExpY = i;
					break;
				}
			}
			break;
		case "weapon 2":
			slotExpanded = 1;
			sX++;
					
			slot_options = [];
			slot_types = PlayerStats.activeComboSlotNumbers[sX-1];
					
			for(var i = 0; i < PlayerStats.comboSize; i++)
			{
				current_menu_options[i+1, 1] = i;
			}
					
			num = 0;
			for (var i = ds_map_find_first(ComboCache.attackTypes); i != ds_map_find_last(ComboCache.attackTypes); i = ds_map_find_next(ComboCache.attackTypes,i))
			{
				for (var j = 0; j < array_length_1d(slot_types); j++)
				{
					if ComboCache.attackTypes[? i] == slot_types[j]
					{
						slot_options[num] = i;
						num++;
						break;
					}
				}
			}
			for (var i = 0; i < array_length_1d(slot_options); i++)
			{
				if slot_options[i] = PlayerStats.activeComboIDs[sX-1]
				{
					sExpY = i;
					break;
				}
			}
			break;
	}
	if slotExpanded && movedH == 0
	{
		scr_set_combo(sX-1,slot_options[sExpY])
	}
}

#endregion
#region (B)			Cancel

if InputManager.bInput == true
{
	audio_play_sound(snd_menu_back,10,0);
	if slotExpanded
	{
		slotExpanded = 0;
		current_menu_options = menu_combos;
	}
	else
	{
		menu = menuCurrent.main;
		current_menu_options = menu_main;
		sX = 0;
		sY = 0;
	}
}

#endregion