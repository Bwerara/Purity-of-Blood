#region lock-on

if !canChangeTarget
{
	var h = InputManager.targetInputH;
	var v = InputManager.targetInputV;
	if h==0 && v==0 canChangeTarget = 1;
}

if lockOnType != lockOn.off && !instance_exists(lockOnTarget)
{
	lockOnType = lockOn.off;
	lockOnTarget = noone;
}

switch lockOnType
{
	case lockOn.off:
	case lockOn.soft:
		lockOnTarget = noone;
		var keepChecking = true;
		while keepChecking
		{
			lockOnTarget = instance_nearest(x,y,objEnemyParent);
			if distance_to_object(lockOnTarget) > softLockRange
			{
				lockOnTarget = noone;
				keepChecking = false;
				instance_activate_object(objEnemyParent);
			}
			else if lockOnTarget.actorType == actorTypes.corpse
			{
				instance_deactivate_object(lockOnTarget);
				lockOnTarget = noone;
			}
			else
			{
				keepChecking = false
			}
		}
		instance_activate_object(objEnemyParent);
		if distance_to_object(lockOnTarget) > softLockRange lockOnTarget = noone;
		if lockOnTarget != noone 
		{
			lockOnType = lockOn.soft;
			lockOnDir = sign(lockOnTarget.x-x);
			if lockOnDir = 0 lockOnDir = 1;
		}
		if InputManager.rsInput && lockOnType == lockOn.soft lockOnType = lockOn.hard;
		break;
	case lockOn.hard:
		lockOnDir = sign(lockOnTarget.x-x);
		if lockOnDir == 0 lockOnDir = 1;
		if distance_to_object(lockOnTarget) > hardLockRange || lockOnTarget.actorType == actorTypes.corpse
		{
			lockOnTarget = noone;
			lockOnType = lockOn.off;
		}		
		if gamepad_is_connected(0)
		{
			//target switch
			if lockOnType = lockOn.hard
			{
				var h = InputManager.targetInputH;
				var v = InputManager.targetInputV;
				if canChangeTarget && !(h==0&&v==0)
				{
					var minDist = -1;
					if h <= 0 && abs(h)>=abs(v) {var maxAngle = 225; var minAngle = 135;}
					else if h > 0 && abs(h)>=abs(v) {var maxAngle = 45; var minAngle = 315;}
					else if v < 0 && abs(v)>=abs(h) {var maxAngle = 135; var minAngle = 45;}
					else if v >= 0 && abs(v)>= abs(h) {var maxAngle = 315; var minAngle = 225;}
					with objEnemyParent
					{
						var searchAngle = point_direction(other.lockOnTarget.x,other.lockOnTarget.y,x,y)
						if other.lockOnTarget != id && ((searchAngle > minAngle && searchAngle < maxAngle)||(minAngle == 315 && (searchAngle < 45 || minAngle > 315))) && (distance_to_object(other.lockOnTarget)<minDist||minDist==-1) && distance_to_object(other) < other.hardLockRange
						{
							minDist = distance_to_object(other.lockOnTarget);
							other.potentialId = id;
						}
					}
					if minDist != -1
					{
						lockOnTarget = potentialId;
						canChangeTarget = 0;
					}
				}
			}
			if !canChangeTarget
			{
				if (InputManager.targetInputH==0&&InputManager.targetInputV==0) canChangeTarget = 1;
			}
		}
		else
		{
			if hardLockOn && InputManager.keyboardTargetChangeInput
			{
				var stopIt = 0;
				var targetList = [];
				var lockOnIndex = -4;
				with objEnemyParent
				{
					if distance_to_object(other) <= other.hardLockRange
					{
						for (var i = 0; i < array_length_1d(targetList); i++)
						{
							if targetList[i] == id
							{
								if id == other.lockOnTarget lockOnIndex = i
								stopIt = 1;
							}
						}
						if !stopIt
						{
							var newIndex = array_length_1d(targetList);
							other.targetList[newIndex] = id;		
							if id == other.lockOnTarget lockOnIndex = newIndex;
						}
					}
				}
				lockOnIndex++;
				if lockOnIndex >= array_length_1d(targetList)lockOnIndex = 0;
				lockOnTarget = targetList[lockOnIndex]
			}
		}
		if InputManager.rsInput lockOnType = lockOn.soft;
		break;
}

#endregion

#region passives
//this section will change somewhat to reflect the 
//needed code. Though at times multiple passive
//codes may be needed.

	#region maintain player light source
		if !instance_exists(objLightPlayer) instance_create_layer(x,y,"lay_lights",objLightPlayer)
		with objLightPlayer
		{
			x = other.x;
			y = other.y;
		}
	#endregion
	#region reset dropThroughPlatforms
if dropThroughPlatforms && !InputManager.aInputHeld dropThroughPlatforms = false;
	#endregion
	#region targets (only ropeshot atm, stuff will probably be added)
ropeShotTarget = noone;
switch PlayerStats.activeOffhandActivatableID
{
		//rope shot
	case 0:
		var nearestRopeShotTarget = instance_nearest(x,y,objGrappleParent);
		if lockOnType = lockOn.hard ropeShotTarget = [lockOnTarget.x,lockOnTarget.y]
		else if distance_to_object(nearestRopeShotTarget) <= ropeShotTargetRange ropeShotTarget = [nearestRopeShotTarget.x,nearestRopeShotTarget.y];
		else ropeShotTarget = noone;
		
		if ropeShotTarget != noone
		{
			if object_get_parent(object_index) == objGrappleParent ropeShotTargetType = 1;		//mount
			else ropeShotTargetType = 0;														//not mount
		}
		break;

}
	#endregion
	#region melee attack cooldown
if attackHardCooldownTimer != -1 && phase != state.attacking
{
	attackHardCooldownTimer++;
	if attackHardCooldownTimer >= round(attackHardCooldown*room_speed)
	{
		attackHardCooldownTimer = -1; //switch off
	}
}
	#endregion
	#region offhand attack cooldown
if offhandHardCooldownTimer != -1
{
	offhandHardCooldownTimer++;
	if offhandHardCooldownTimer >= round(offhandHardCooldown*room_speed)
	{
		offhandHardCooldownTimer = -1; //switch off
	}
}
	#endregion
	#region reset hitPhase
switch hitPhase
{
	case hitState.normal:
		//do nothing
		break;
	case hitState.blocking:
		if !(phase == state.blocking && subPhase == subState.performing) hitPhase = hitState.normal;
		break;
	case hitState.dodging:
		if !(phase == state.dodging) hitPhase = hitState.normal;
		break;
}
	#endregion

#endregion

#region State mechanisms

scr_actor_vStateMachine();
	
	#region Phase State Machine (nested subPhase)
switch phase
{
	case state.base:
		scr_player_base();
		break;
	case state.attacking:
		scr_player_attacking();
		break;
	case state.offhand:
		scr_player_offhand();
		break;
	case state.ability:
		scr_player_ability();
		break;
	case state.blocking:
		scr_player_blocking();
		break;
	case state.dodging:
		scr_player_dodging();
		break;
	case state.hitReaction:
		scr_player_hitReaction();
		break;
	case state.dying:
		scr_player_dying();
		break;
}
	#endregion
	
#endregion

scr_hitCheck();
scr_statusCheck();
scr_player_equipmentChange();
//scr_actor_moveWithCollisions();

	//addional properties
image_xscale = facing;