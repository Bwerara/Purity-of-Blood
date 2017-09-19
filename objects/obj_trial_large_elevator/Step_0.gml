/// @description Insert description here
// You can write your code in this editor

maxHeight=initialY-(blockHeight*64);

if (phase=="neutral")&&(place_meeting(x,y+3,obj_elevator_base))&&(global.forestLeverOne==true)
{
	phase="up";
}

if (phase=="up")&&(y+ySpd<=maxHeight)
{
	while y > maxHeight y--;
	phase="neutral";
	counting = 1;
	upTimer = -1;
}

if (phase=="down")&&(place_meeting(x,y+ySpd,obj_elevator_base))
{
	while !place_meeting(x,y,obj_elevator_base) y++;
	phase="neutral";
	counting = 1;
}

switch phase
{
	case "neutral": 
		ySpd = 0;
		if counting == 1 upTimer++;
		if counting ==1 && upTimer == 2*room_speed
		{
			phase = "down"
			upTimer = 0;
			counting = 0;
		}
		break;
	case "up": ySpd = upSpeed; break;
	case "down": ySpd = 2; break;
}

y+=ySpd;

scr_move_player_above();