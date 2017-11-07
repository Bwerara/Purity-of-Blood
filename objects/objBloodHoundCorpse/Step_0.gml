switch vPhase
{
	case vState.grounded:
		#region Grounded
			//kill zone
		if zoneTouchID != noone
		{
			instance_destroy(zoneTouchID);
			zoneTouchID = noone;
		}
			//transition
		var isGrounded = false;
		with obj_block_parent
		{
			if !place_meeting(x,y,other) && place_meeting(x,y-1,other)
			{
				isGrounded = true;
				if object_is_ancestor(object_index,obj_platform_parent) other.onPlatform = true;
				else other.onPlatform = false;
				break;
			}
		}
		if !isGrounded
		{
			vPhase = vState.midAir;
			onPlatform = false
		}
			//xSpd
		xSpd-=xSpd/4;
			//no ySpd change
			//sprite
		update_sprite_enemy(sprBloodHoundCorpseBodyIdle,0);
		#endregion
		break;
	case vState.midAir:
		#region Airborne
			//damageZone
		if zoneTouchID == noone
		{
			actorType = actorTypes.enemy;
			zoneTouchID = scr_enemy_attack(zoneTouchFrameData,zoneTouchFollow,zoneTouchDuration,zoneTouchDamageType,zoneTouchDamage,zoneTouchStagger,zoneTouchKnockBack,zoneTouchStatusType,zoneTouchStatusValue,zoneTouchPierce,zoneTouchAnimation,zoneTouchHitSoundID);
			actorType = actorTypes.corpse;
		}
			//transition
		var isGrounded = false;
		if sign(ySpd) != -1
		{
			with obj_block_parent
			{
				if !place_meeting(x,y,other) && place_meeting(x,y-1,other)
				{
					isGrounded = true;
					other.vPhase = vState.grounded;
					if object_is_ancestor(object_index,obj_platform_parent) other.onPlatform = true;
					else other.onPlatform = false;
					break;
				}
			}
		}
			//ySpd
		if !isGrounded ySpd += GameManager.grav;
		if ySpd > maxFallSpeed ySpd = maxFallSpeed;
			//sprite
		update_sprite_enemy(sprBloodHoundCorpseBodyAirborne,0)
		#endregion
		break;
}

scr_actor_moveWithCollisions();

	//addional properties
image_xscale = facing;