//get needed data
var IE = instance_exists(InputManager)
if IE var moveH = InputManager.moveInputH;
else var moveH = 0;
if IE var moveV = InputManager.moveInputV;
else var moveV = 0;
if IE && InputManager.xInput xInputQueue = 1;
if IE && InputManager.yInput yInputQueue = 1;
if IE && InputManager.aInput aInputQueue = 1;
if IE && InputManager.bInput bInputQueue = 1;

phaseTimer++;
subPhaseTimer++;

if lockOnType != lockOn.off facing = lockOnDir;
else if moveH != 0 && vPhase == vState.grounded facing = sign(moveH);

	//Sub states
#region sub States

switch PlayerStats.activeOffhandID
{	
	//Crossbow
	case 0:	
		switch vPhase
		{
			case vState.grounded:
				#region ground offhand
				switch subPhase
				{
					case subState.pre:
						if subPhaseTimer >= round(crossbowDurationPre*room_speed)
						{ 
							if IE && InputManager.yInputHeld
							{
								subPhase = subState.aim;
								subPhaseTimer = 0;
							}
							else
							{
									//double check lockOn data
								if lockOnType != lockOn.off && !instance_exists(lockOnTarget)
								{
									lockOnType = lockOn.off;
									lockOnTarget = noone;
								}
								if lockOnType == lockOn.off aimAngle = (facing==1)? 0:180;
								else {aimAngle = point_direction(x,y,lockOnTarget.x,lockOnTarget.y)}
								scr_player_fireCrossbow(aimAngle);
								subPhase = subState.fire;
								subPhaseTimer = 0;
							}
							reset_queue();
						}
							//xSpd
						if moveH != 0 xSpd = PlayerStats.moveSpeed/2*sign(moveH);
						else xSpd -= xSpd/4;
							//Sprite
						if sign(moveH) == facing var newSprite = sprPlayerBodyDefaultCrossbowPreTowards;							
						else if sign(moveH) == -facing var newSprite = sprPlayerBodyDefaultCrossbowPreAway;	
						else var newSprite = sprPlayerBodyDefaultCrossbowPre;
						update_sprite(newSprite,-crossbowDurationPre);
							//this is commented out because of how the sprites currently work, currently the arm is merged with the body sprite for this subphase
						//auxSpriteIndex = sprPlayerAuxSwordCrossbowPre;
						break;
		
					case subState.fire:
						if subPhaseTimer >= round(crossbowDurationFire*room_speed)
						{
							subPhase = subState.holding;
							subPhaseTimer = 0;
						}
							//double check lockOn data
						if lockOnType != lockOn.off && !instance_exists(lockOnTarget)
						{
							lockOnType = lockOn.off;
							lockOnTarget = noone;
						}
						if lockOnType == lockOn.off aimAngle = (facing==1)? 0:180;
						else {aimAngle = point_direction(x,y,lockOnTarget.x,lockOnTarget.y)}
							//Sprite
						if sign(moveH) == facing var newSprite = sprPlayerBodyDefaultCrossbowFireTowards;
						else if sign(moveH) == -facing var newSprite = sprPlayerBodyDefaultCrossbowFireAway;	
						else var newSprite = sprPlayerBodyDefaultCrossbowFire;
						update_sprite(newSprite,-crossbowDurationFire);
						auxSpriteIndex = sprPlayerAuxDefaultCrossbowFire;
							//xSpd
						if moveH != 0 xSpd = PlayerStats.moveSpeed/2*sign(moveH);
						else xSpd -= xSpd/4;
						break;
		
					case subState.aim:
						var h = InputManager.moveInputH;
						var v = InputManager.moveInputV;
						if !(h==0 && v==0) aimAngle = point_direction(0,0,h,v);
						facing = (aimAngle<90||aimAngle>270)? 1:-1;
						if !IE || !InputManager.yInputHeld
						{
							scr_player_fireCrossbow(aimAngle);
							subPhase = subState.fire
							subPhaseTimer = 0;
						}
							//Sprite
						if sign(moveH) == facing var newSprite = sprPlayerBodyDefaultCrossbowAimTowards;							
						else if sign(moveH) == -facing var newSprite = sprPlayerBodyDefaultCrossbowAimAway;	
						else var newSprite = sprPlayerBodyDefaultCrossbowAim;
						update_sprite(newSprite,1);
						auxSpriteIndex = sprPlayerAuxDefaultCrossbowAim;
							//xSpd
						xSpd -= xSpd/4;
						break;
		
					case subState.holding:
						if yInputQueue
						{
							if !IE || !InputManager.yInputHeld
							{
								reset_queue();
								if lockOnType != lockOn.off 
								{
									facing = lockOnDir
									aimAngle = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
								}
								else aimAngle = (facing==1)? 0:180;
								scr_player_fireCrossbow(aimAngle);
								subPhase = subState.fire;
								subPhaseTimer = 0;
							}
							else if subPhaseTimer == round(crossbowDurationHolding*room_speed)
							{
								reset_queue();
								subPhase = subState.aim;
								subPhaseTimer = 0;
							}
						}
						else if subPhaseTimer == round(crossbowDurationPost*room_speed)
						{
							reset_queue();
							subPhase = subState.post;
							subPhaseTimer = 0;
						}
							//Sprite
						if sign(moveH) == facing var newSprite = sprPlayerBodyDefaultCrossbowHoldingTowards;							
						else if sign(moveH) == -facing var newSprite = sprPlayerBodyDefaultCrossbowHoldingAway;	
						else var newSprite = sprPlayerBodyDefaultCrossbowHolding;
						update_sprite(newSprite,-crossbowDurationHolding);
						auxSpriteIndex = sprPlayerAuxDefaultCrossbowHolding;
							//xSpd
						if moveH != 0 xSpd = PlayerStats.moveSpeed/2*sign(moveH);
						else xSpd -= xSpd/4;
						break;
		
					case subState.post:
						if subPhaseTimer == round(0.3*room_speed)
						{
							phase = state.base;
							phaseTimer = 0;
							scr_player_base_subPhaseDeterminer();
						}
							//Sprite
						if sign(moveH) == facing var newSprite = sprPlayerBodyDefaultCrossbowPostTowards;							
						else if sign(moveH) == -facing var newSprite = sprPlayerBodyDefaultCrossbowPostAway;	
						else var newSprite = sprPlayerBodyDefaultCrossbowPost;
						update_sprite(newSprite,-crossbowDurationPost);
							//these are commented out because of how the sprites currently work, currently the arm is merged with the body sprite for this subphase
						//auxSpriteIndex = sprPlayerAuxSwordCrossbowPost;
							//xSpd
						if moveH != 0 xSpd = PlayerStats.moveSpeed/2*sign(moveH);
						else xSpd -= xSpd/4;
						break;
				}
				#endregion
				break;
			case vState.jumping:
			case vState.midAir:
				#region aerial offhand
				switch subPhase
				{
					case subState.pre:
						if subPhaseTimer >= round(crossbowDurationAerialPre*room_speed)
						{
							reset_queue();
							if lockOnType == lockOn.off aimAngle = (facing==1)? 0:180;
							else {aimAngle = point_direction(x,y,lockOnTarget.x,lockOnTarget.y); facing = lockOnDir;}
							scr_player_fireCrossbow(aimAngle);
							subPhase = subState.fire;
							subPhaseTimer = 0;
							ySpd = 2*crossbowAerialBounce;
						}
							//Sprite
						update_sprite(sprPlayerBodyDefaultCrossbowAerialPre,-crossbowDurationAerialPre);
							//this is commented out because of how the sprites currently work, currently the arm is merged with the body sprite for this subphase
						//auxSpriteIndex = sprPlayerAuxSwordCrossbowPre;
							//xSpd
						if moveH != 0 xSpd = clamp(xSpd+moveH*PlayerStats.moveSpeed/15,-PlayerStats.moveSpeed/2,PlayerStats.moveSpeed/2);
						else xSpd -= xSpd/20;
							//ySpd
						ySpd -= GameManager.grav*(1/2);		//1/2 G
						break;
						
					case subState.fire:
						if subPhaseTimer >= round(crossbowDurationAerialFire*room_speed)
						{
								reset_queue();
								subPhase = subState.holding;
								subPhaseTimer = 0;
						}
							//Sprite
						update_sprite(sprPlayerBodyDefaultCrossbowAerialFire,-crossbowDurationAerialFire);
						auxSpriteIndex = sprPlayerAuxDefaultCrossbowFire;
						if moveH != 0 xSpd = clamp(xSpd+moveH*PlayerStats.moveSpeed/15,-PlayerStats.moveSpeed/2,PlayerStats.moveSpeed/2);
						else xSpd -= xSpd/20;
							//ySpd
						ySpd -= GameManager.grav*(1/4);		//3/4 G
						break;

					case subState.holding:
						if yInputQueue
						{
							reset_queue();
							if lockOnType == lockOn.off aimAngle = (facing==1)? 0:180;
							else {aimAngle = point_direction(x,y,lockOnTarget.x,lockOnTarget.y); facing = lockOnDir;}
							scr_player_fireCrossbow(aimAngle);
							subPhase = subState.fire;
							subPhaseTimer = 0;
							ySpd = crossbowAerialBounce;
						}
						else if subPhaseTimer == round(crossbowDurationAerialHolding*room_speed)
						{
							phase = state.base;
							phaseTimer = 0;
							scr_player_base_subPhaseDeterminer();
						}
							//Sprite
						update_sprite(sprPlayerBodyDefaultCrossbowAerialHolding,-crossbowDurationAerialHolding);
						auxSpriteIndex = sprPlayerAuxDefaultCrossbowHolding;
							//xSpd
						if moveH != 0 xSpd = clamp(xSpd+moveH*PlayerStats.moveSpeed/15,-PlayerStats.moveSpeed/2,PlayerStats.moveSpeed/2);
						else xSpd -= xSpd/20;
							//ySpd
						ySpd -= GameManager.grav*(1/4);		//3/4 G
						break;
												
				}				
				#endregion
				break;
		}
		break;
}
		
#endregion

	//aux sprite data
auxSpriteXOffset = 5;
auxSpriteYOffset = -3;
auxSpriteXScale = 1;
//auxSpriteYScale = 1;			//base
auxSpriteRotation = aimAngle;

if facing == -1
{
	auxSpriteRotation -= 180;
	auxSpriteXScale = -1;
}