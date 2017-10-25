/*
Template for an enemy

most of the code in this object is re-usable
accross all objects and is intended to be so.
Any code or initializers followed by "//$$//"
are template code and should have their values
and/or code altered in accordnace.

*/

//base behaviour data
actorType = actorTypes.enemy;
aggroPhase = enemyAggroState.passive;
phase = state.base;
subPhase = subState.idle;
vPhase = vState.midAir;
hitPhase = hitState.normal;

phaseTimer = 0;
subPhaseTimer = 0;
baseSpriteIndex = sprite_index;
effectSpriteIndex = noone;
maxFallSpeed = 5;
xSpd = 0;
ySpd = 0;
facing = irandom(1);
if facing == 0 facing = -1;
phased = false;
flying = false;
dropThroughPlatforms = false;
tempBodySprite = noone;

bboxDefaultLeft = sprite_get_bbox_left(sprite_index);
bboxDefaultRight = sprite_get_bbox_right(sprite_index);
bboxDefaultTop = sprite_get_bbox_top(sprite_index);
bboxDefaultBottom = sprite_get_bbox_bottom(sprite_index);

bboxLeft = bboxDefaultLeft;
bboxRight = bboxDefaultRight;
bboxTop = bboxDefaultTop;
bboxBottom = bboxDefaultBottom;

if !layer_exists("lay_caches") layer_create(0,"lay_caches");
statCache = instance_create_layer(0,0,"lay_caches",actorStats)
with statCache
{
	hpMax = 20;											//$$//
	mpMax = 0;											//$$//
	
	damagePower = 7;									//$$//
	staggerPower = 3;									//$$//
	
	physicalToughness = 1;								//$$//
	magicalToughness = 1;								//$$//
	
	moveSpeed = 0.5;									//$$//
	defaultMoveSpeed = moveSpeed;
	
	hitEffectType = "blood";
	hitEffectColour = "dark red";
	
		//Damage type resistances (as percentage; 1 = 100%)
	damageResistances[0] = 1;			//Slash			//$$//
	damageResistances[1] = 1;			//Blunt			//$$//
	damageResistances[2] = 1;			//Pierce		//$$//
	damageResistances[3] = 1;			//Fire			//$$//
	damageResistances[4] = 1;			//Ice			//$$//
	damageResistances[5] = 1;			//Lightning		//$$//
	damageResistances[6] = 1;			//Arcane		//$$//
	damageResistances[7] = 1;			//Light			//$$//
	damageResistances[8] = 1;			//Dark			//$$//
	damageResistances[9] = 1;			//X damage		//$$//

	//Special Damage initializers
	specialDamage[0] = 0;				//Bleed

	//Special resistances (100 is considered normal)
	specialResist[0] = 100;				//Bleed			//$$//
	
	hp = hpMax;
	mp = mpMax;
	
	isInvulnerable = false;
}

//drives
driveJump = false;
driveAction = 0;
driveMove = 0;

//base checks
actionHardCooldownTimer = -1;
hasDeflected = false;
canChangeVState = true;
isDead = false;
hasBeenHit = false;
lastHitType = -1;

//variables
aggroRange = 16*7;										//$$//
actionHardCooldown = 3;									//$$//
landingDuration = 0.7;									//&&//

staggeredDuration = 0.5;								//$$//
proneDuration = 0.6;									//$$//
deathDuration = 1;										//$$//
deathFadeDuration = 2;									//$$//

//ai data
attack1Range = 16*2.5;									//$$//

//action data
	//action1: general attack				the number in between "/**/#/**/" below indicates the sprite number, starting at 0 for timings
attack1Animation = sprZombieBodyAction1													//$$//
attack1Duration = 2;																	//$$//
attack1HitStart = attack1Duration*(/**/5/**//sprite_get_number(attack1Animation))		//$$//
attack1HitDuration = attack1Duration*(/**/3/**//sprite_get_number(attack1Animation))	//$$//
attack1MoveBurst = 3;																	//$$//
attack1Move = 0;																		//$$//
attack1MoveStart = attack1Duration*(/**/4/**//sprite_get_number(attack1Animation))		//$$//
attack1MoveDuration = attack1Duration*(/**/2/**//sprite_get_number(attack1Animation))	//$$//
attack1XOffset = 16;																	//$$//
attack1YOffset = -6;																	//$$//
attack1Width = 4;																		//$$//
attack1Height = 18;																		//$$//
attack1DamageType = 2;																	//$$//
attack1Damage = 1;																		//$$//
attack1Stagger = 1;																		//$$//
attack1Knockback = 12;																	//$$//
attack1StatusType = -1;																	//$$//
attack1StatusValue = 0;																	//$$//
attack1Pierce = false;																	//$$//