//draw self
draw_self();

//draw effect
if effectSpriteIndex != noone draw_sprite_ext(effectSpriteIndex,image_index,x,y,facing,1,0,c_white,1);

//hitbox (testing)
if GameManager.actorBoxVisuals draw_hitbox(c_purple);