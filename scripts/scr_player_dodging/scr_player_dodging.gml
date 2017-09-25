//get needed data
var IE = instance_exists(inputManager)
if IE && inputManager.xInput xInputQueue = 1;
if IE && inputManager.yInput yInputQueue = 1;
if IE && inputManager.aInput aInputQueue = 1;
if IE && inputManager.bInput bInputQueue = 1;

phaseTimer++;
subPhaseTimer++;

blocking = 0;

	//Sprite
var newImageSpeed = sprite_get_number(sprPlayerBodySwordDodging)/(dodgeDurationPerforming+dodgeDurationPost);
update_sprite(sprPlayerBodySwordDodging,newImageSpeed);

	//Sub states
#region states

switch subPhase
{
	case subState.performing:
		dodging = 1;
		if subPhaseTimer >= round(room_speed*dodgeDurationPerforming)
		{
			subPhase = subState.post;
			subPhaseTimer = 0;
		}
			//xSpd
		xSpd = facing*dodgeDistance/(room_speed*dodgeDurationPerforming);
			//ySpd
		ySpd += global.g;
		break;
		
	case subState.post:
		if subPhaseTimer >= round(room_speed*dodgeDurationPost)
		{
			phase = state.base;
			phaseTimer = 0;
			subPhaseTimer = 0;
			scr_player_base_subPhaseDeterminer();
		}
			//xSpd
		xSpd -= xSpd/4;
			//ySpd
		ySpd += global.g;
		break;
}
		
#endregion
	
	//addional properties
image_xscale = facing;