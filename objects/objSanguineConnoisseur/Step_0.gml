#region passives

	//melee attack cooldown
scr_enemy_actionHardCooldown();

#endregion

scr_sanguineConnoisseur_ai();

#region State machines
	
		//vPhase
	scr_actor_vStateMachine();
	
		//phase (nested subPhase)
	switch phase
	{
		case state.base:
			scr_enemy_ground_base();
			break;
		case state.action1:
			scr_sanguineConnoisseur_action1();
			break;
		case state.action2:
			scr_sanguineConnoisseur_action2();
			break;
		case state.hitReaction:
			scr_enemy_ground_hitReaction();
			break;
		case state.dying:
			scr_enemy_ground_dying();
			break;
	}
	
#endregion

scr_hitCheck();
scr_statusCheck();

	//addional properties
image_xscale = facing;