//get needed data
var moveH = InputManager.moveInputH;
var moveV = InputManager.moveInputV;
if InputManager.xInput xInputQueue = 1;
if InputManager.yInput yInputQueue = 1;
if InputManager.aInput aInputQueue = 1;
if InputManager.bInput bInputQueue = 1;

#region do things
phaseTimer++;
subPhaseTimer++;
	
	//get combo size data
var wepClass = weapon_get_stat(PlayerStats.currentWeaponID,weaponStats.type);
var groundComboSize = PlayerStats.GCS[? wepClass];
var groundFinisherSize = PlayerStats.GFS[? wepClass];
var aerialComboSize = PlayerStats.ACS[? wepClass];
var aerialFinisherSize = PlayerStats.AFS[? wepClass];

	//visuals
switch attackName
{
	case "Burst":
		if phaseTimer == round(attackMoveStart*room_speed)
		{
			var feetX = x;
			var feetY = y+(sprite_get_bbox_bottom(sprite_index)-sprite_get_yoffset(sprite_index));
			with create_effect(false,feetX,feetY,-1,sprDustL,0.4,facing,1)
			{
				image_alpha = 0.7;
			}
		}
		break;
}
		//check if alt, if it is use alternative sprite
var comboType = noone
switch vPhase
{
	case vState.grounded:
		comboType = weaponClassStats.groundComboDefault;
		break;
	case vState.jumping:
	case vState.midAir:
		comboType = weaponClassStats.aerialComboDefault;
		break;
}
var compareID = class_get_stat(wepClass,comboType);
if vPhase = vState.grounded var comboSizeToCheck = groundComboSize;
else comboSizeToCheck = aerialComboSize;
var animToUse = attackAnimation;
if attackID == compareID && comboSizeToCheck%2 == attackNum%2 && attackNum < comboSizeToCheck
{
	animToUse = asset_get_index(sprite_get_name(animToUse)+"Alt");
}
	//update sprite
update_sprite(animToUse,-(attackDuration+attackCooldown));

	//attack Effect
for(var i = 0; i < ds_list_size(ComboCache.attackHitStarts[? attackID]); i++)
{
	if phaseTimer == round(ds_list_find_value(ComboCache.attackHitStarts[? attackID], i)*room_speed)
	{
		scr_player_createAttackEffect(attackID,i,true);
	}
}

switch vPhase
{
	case vState.grounded:
			//xspd
		if phaseTimer >= round(attackMoveStart*room_speed) && phaseTimer <= round((attackMoveStart+attackMoveDuration)*room_speed)
		{
			xSpd = facing*(attackMoveDistanceX/((attackMoveDuration)*room_speed));
		}
		else xSpd -= xSpd/4;
			//ySpd
		if phaseTimer >= round(attackMoveStart*room_speed) && phaseTimer <= round((attackMoveStart+attackMoveDuration)*room_speed)
		{
			ySpd = attackMoveDistanceY/((attackMoveDuration)*room_speed);
		}
		break;

	case vState.jumping:
	case vState.midAir:
			//xspd
		if phaseTimer >= round(attackMoveStart*room_speed) && phaseTimer <= round((attackMoveStart+attackMoveDuration)*room_speed)
		{
			if aerialTargetX != -4
			{
				xSpd = (aerialTargetX-x)/8;
			}
			else xSpd = facing*(attackMoveDistanceX/((attackMoveDuration)*room_speed));
		}
		else xSpd -= xSpd/4;
			//ySpd
		if phaseTimer >= round(attackMoveStart*room_speed) && phaseTimer <= round((attackMoveStart+attackMoveDuration)*room_speed)
		{
			if aerialTargetY != -4 
			{
				ySpd = (aerialTargetY-y)/8;
			}
			else ySpd = attackMoveDistanceY/((attackMoveDuration)*room_speed);
		}
		else
		{
			ySpd -= GameManager.grav*(3/4); //1/4 G
			ySpd = clamp(ySpd,-aerialYSpdCap,aerialYSpdCap);
		}
		break;
}

#endregion

#region change states & substates
	if lastVState != vPhase && subPhaseTimer != 1 && vChangeBreak
	{
		canChangeVState = true;
		vChangeBreak = true;
		lastAttackHasHit = false;
		aerialTargetX = -4;
		aerialTargetY = -4;	
		hasDeflected = false;
		phased = 0;
		phase = state.base;
		phaseTimer = 0;
		attackNum = -1;
		scr_player_base_subPhaseDeterminer();
	}
	else
	{
					//get deflected
		if hasDeflected
		{
			canChangeVState = false;
			vChangeBreak = true;
			lastAttackHasHit = false;
			hasDeflected = false;
			phase = state.hitReaction;
			phaseTimer = 0;
			subPhase = subState.deflected;
			subPhaseTimer = 0;
		}
		else switch subPhase
		{
			case subState.performing:
				if subPhaseTimer >= round(attackDuration*room_speed)
				{
					subPhase = subState.post;
					subPhaseTimer = 0;
				}
				break;
			case subState.post:
				switch vPhase
				{
					case vState.grounded:
						#region ground attack
							#region keep attacking? (ground combo)
						if xInputQueue && attackNum+1 != groundComboSize+groundFinisherSize && lastAttackHasHit
						{
							canChangeVState = true;
							vChangeBreak = true;
							lastAttackHasHit = false;
							switch lockOnType
							{
								case lockOn.soft: if distance_to_object(lockOnTarget) <= attackGroundTrackDistance facing = lockOnDir; break;
								case lockOn.hard: facing = lockOnDir; break;							
							}
							phased = 0;
							attackNum++;
							reset_queue();
							scr_player_beginAttack(attack_get_id(attackNum,vState.grounded));
							phaseTimer = 0;							//reset for properties
							subPhase = subState.performing;
							subPhaseTimer = 0;
						}
							#endregion
							#region perform uppercut? (mid ground combo using weapon)
						else if yInputQueue && attackNum+1 < groundComboSize+groundFinisherSize-1 && lastAttackHasHit
						{
							canChangeVState = true;
							vChangeBreak = false;
							lastAttackHasHit = false;
							switch lockOnType
							{
								case lockOn.soft: if distance_to_object(lockOnTarget) <= attackGroundTrackDistance facing = lockOnDir; break;
								case lockOn.hard: facing = lockOnDir; break;							
							}
							phased = 0;
							attackNum++;
							reset_queue();
							scr_player_beginAttack(-1);
							phaseTimer = 0;							//reset for properties
							subPhase = subState.performing;
							subPhaseTimer = 0;
						}
							#endregion
							#region jump? (mid ground combo/subsequent jump)
						else if aInputQueue
						{
							canChangeVState = true;
							vChangeBreak = true;
							lastAttackHasHit = false;
							reset_queue();
							phased = 0;		
							ySpd = -PlayerStats.jumpPow;
							jumpNum++;
							phase = state.base;
							phaseTimer = 0;
							attackNum = -1;
							scr_player_base_subPhaseDeterminer();
						}
							#endregion
							#region block/dodge
						else if bInputQueue
						{
							canChangeVState = true;
							vChangeBreak = true;
							lastAttackHasHit = false;
							reset_queue();
							phased = 0;
							attackNum = -1;
							if moveH == 0
							{
								phase = state.blocking;
								phaseTimer = 0;
								subPhase = subState.pre;
								subPhaseTimer = 0;
							}
							else
							{
								facing = sign(moveH);
								phased = 1;
								phase = state.dodging;
								phaseTimer = 0;
								subPhase = subState.performing;
								subPhaseTimer = 0;
							}
						}
							#endregion
							#region end
						else if subPhaseTimer >= round(attackCooldown*room_speed)
						{
							canChangeVState = true;
							vChangeBreak = true;
							aerialTargetX = -4;
							aerialTargetY = -4;	
							lastAttackHasHit = false;
							hasDeflected = false;
							phased = 0;
							phase = state.base;
							phaseTimer = 0;
							if attackName != "Uppercut" attackHardCooldownTimer = 0; //switch on
							attackName = noone;
							attackNum = -1;
							scr_player_base_subPhaseDeterminer();
						}
							#endregion
						#endregion
						break;
			
					case vState.jumping:
					case vState.midAir:
						#region air attack
							#region keep aerial attacking?
						if xInputQueue && attackNum+1 != aerialComboSize+aerialFinisherSize && lastAttackHasHit
						{
							canChangeVState = false;
							vChangeBreak = false;
							lastAttackHasHit = false;
							if lockOnType != lockOn.off && abs(lockOnTarget.x-x) <= attackTrackXDistance && abs(lockOnTarget.y-y) <= attackTrackYDistance
							{
								var dirToPlayer = sign(x-lockOnTarget.x);
								var enemyBBoxWidth = lockOnTarget.bbox_right-lockOnTarget.bbox_left;
								aerialTargetX = lockOnTarget.x+dirToPlayer*(enemyBBoxWidth/2+10);
								aerialTargetY = lockOnTarget.y;
							}
							else
							{
								aerialTargetX = -4;
								aerialTargetY = -4;	
							}
							attackNum++;
							reset_queue();
							scr_player_beginAttack(attack_get_id(attackNum,vState.midAir));
							phaseTimer = 0;							//reset for properties
							subPhase = subState.performing;
							subPhaseTimer = 0;
							if aerialTargetX == -4 && aerialTargetY == -4 ySpd = aerialAttackVertBoost;
							else facing = lockOnDir
						}
							#endregion
							#region end
						else if subPhaseTimer >= round(attackCooldown*room_speed)
						{
							canChangeVState = true;
							vChangeBreak = true;
							lastAttackHasHit = false;
							hasDeflected = false;
							aerialTargetX = -4;
							aerialTargetY = -4;	
							phase = state.base;
							phaseTimer = 0;
							attackName = noone;
							attackNum = -1;
							attackHardCooldownTimer = 0; //switch on
							if (place_meeting(x,y+1,objBlockParent)&&!place_meeting(x,y,objBlockParent)) vPhase = vState.grounded;
							scr_player_base_subPhaseDeterminer();
						}
							#endregion
						#endregion
						break;
				}
				break;
		}
	}
#endregion