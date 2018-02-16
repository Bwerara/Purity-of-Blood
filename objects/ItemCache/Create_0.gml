#region enum initializers
	//weapons enumerators
enum weaponClass {sword, spear}
enum weaponClassStats {name, groundComboLength, groundFinisherLength, aerialComboLength, aerialFinisherLength, groundComboDefault, groundFinisherDefault, aerialComboDefault, aerialFinisherDefault, counter, downwards, forwards, backwards};
enum weaponStats {name, type, damage, strMod, dexMod, stagger, range, specialType, specialValue, uniqueAttack, misc};
enum weaponComboTypes {groundCombo, groundFinisher, aerialCombo, aerialFinisher, extra};
enum extraComboTypes {upwards};

	//items enumerators
enum itemType {item, weapon, equipment, accessory, key, alchemy};
enum itemStats {icon, name, usable, description};
enum itemItem 
{
	
};
enum weaponItem
{
/* Swords */		gladius,
/* Spears */		hastam
};
enum equipmentItem 
{
	bomb, arrow, grappling_hook, shovel
};
enum accessoryItem
{
	
};
enum keyItem
{
	summon_stone, wooden_key, hearthstone
};
enum alchemyItem
{
	
};
#endregion

//weapon class initializer	(will have to add clauses for initialization of DSs later on if we implement base combo tweaking)
weaponClassData = ds_map_create();
scr_set_weaponCategoriesData(weaponClass.sword);
scr_set_weaponCategoriesData(weaponClass.spear);

//type subCache initializer
	//enum itemType {item, weapon, equipment, accessory, key, alchemy};
item = ds_map_create();
item[? itemType.item] = ds_map_create();
item[? itemType.weapon] = ds_map_create();
item[? itemType.equipment] = ds_map_create();
item[? itemType.accessory] = ds_map_create();
item[? itemType.key] = ds_map_create();
item[? itemType.alchemy] = ds_map_create();

#region all items
	#region items - not done
var itemCache = item[? itemType.item];
	#endregion
	#region weapons
var weaponCache = item[? itemType.weapon]
		#region swords
			#region gladius (average)
weaponCache[? weaponItem.gladius] = ds_map_create();
var gladiusCache = weaponCache[? weaponItem.gladius];
gladiusCache[? weaponStats.name] = "Gladius";
gladiusCache[? weaponStats.type] = weaponClass.sword;
gladiusCache[? weaponStats.damage] = 3;
gladiusCache[? weaponStats.strMod] = 0.10;
gladiusCache[? weaponStats.dexMod] = 0.05;
gladiusCache[? weaponStats.stagger] = 1;
gladiusCache[? weaponStats.range] = 1;
gladiusCache[? weaponStats.specialType] = -1;
gladiusCache[? weaponStats.specialValue] = 0;
gladiusCache[? weaponStats.uniqueAttack] = 7;
gladiusCache[? weaponStats.misc] = noone;
			#endregion
			#region glaphyra (mega cool)
weaponCache[? weaponItem.glaphyra] = ds_map_create();
var glaphyraCache = weaponCache[? weaponItem.glaphyra];
glaphyraCache[? weaponStats.name] = "Glaphyra";
glaphyraCache[? weaponStats.type] = weaponClass.sword;
glaphyraCache[? weaponStats.damage] = 5;
glaphyraCache[? weaponStats.strMod] = 0.20;
glaphyraCache[? weaponStats.dexMod] = 0.9;
glaphyraCache[? weaponStats.stagger] = 1;
glaphyraCache[? weaponStats.range] = 1;
glaphyraCache[? weaponStats.specialType] = -1;
glaphyraCache[? weaponStats.specialValue] = 0;
glaphyraCache[? weaponStats.uniqueAttack] = 7;
glaphyraCache[? weaponStats.misc] = noone;
			#endregion
			#region voltaire (mega cool)
weaponCache[? weaponItem.voltaire] = ds_map_create();
var voltaireCache = weaponCache[? weaponItem.voltaire];
voltaireCache[? weaponStats.name] = "Voltaire";
voltaireCache[? weaponStats.type] = weaponClass.sword;
voltaireCache[? weaponStats.damage] = 6;
voltaireCache[? weaponStats.strMod] = 0.15;
voltaireCache[? weaponStats.dexMod] = 0.1;
voltaireCache[? weaponStats.stagger] = 1;
voltaireCache[? weaponStats.range] = 1;
voltaireCache[? weaponStats.specialType] = -1;
voltaireCache[? weaponStats.specialValue] = 0;
voltaireCache[? weaponStats.uniqueAttack] = 7;
voltaireCache[? weaponStats.misc] = noone;
			#endregion
			#region chipped_sword (bellow average)
weaponCache[? weaponItem.chipped_sword] = ds_map_create();
var chipped_swordCache = weaponCache[? weaponItem.chipped_sword];
chipped_swordCache[? weaponStats.name] = "Chipped Sword";
chipped_swordCache[? weaponStats.type] = weaponClass.sword;
chipped_swordCache[? weaponStats.damage] = 2;
chipped_swordCache[? weaponStats.strMod] = 0.05;
chipped_swordCache[? weaponStats.dexMod] = 0.02;
chipped_swordCache[? weaponStats.stagger] = 1;
chipped_swordCache[? weaponStats.range] = 1;
chipped_swordCache[? weaponStats.specialType] = -1;
chipped_swordCache[? weaponStats.specialValue] = 0;
chipped_swordCache[? weaponStats.uniqueAttack] = 7;
chipped_swordCache[? weaponStats.misc] = noone;
			#endregion
			#region wallace_sword (above average)
weaponCache[? weaponItem.wallace_sword] = ds_map_create();
var wallace_swordCache = weaponCache[? weaponItem.wallace_sword];
wallace_swordCache[? weaponStats.name] = "Wallace Sword";
wallace_swordCache[? weaponStats.type] = weaponClass.sword;
wallace_swordCache[? weaponStats.damage] = 4;
wallace_swordCache[? weaponStats.strMod] = 0.11;
wallace_swordCache[? weaponStats.dexMod] = 0.07;
wallace_swordCache[? weaponStats.stagger] = 1;
wallace_swordCache[? weaponStats.range] = 1;
wallace_swordCache[? weaponStats.specialType] = -1;
wallace_swordCache[? weaponStats.specialValue] = 0;
wallace_swordCache[? weaponStats.uniqueAttack] = 7;
wallace_swordCache[? weaponStats.misc] = noone;
			#endregion
		#endregion
		#region spears
			#region hastam (average)
weaponCache[? weaponItem.hastam] = ds_map_create();
var hastamCache = weaponCache[? weaponItem.hastam];
hastamCache[? weaponStats.name] = "Hastam";
hastamCache[? weaponStats.type] = weaponClass.spear;
hastamCache[? weaponStats.damage] = 4;
hastamCache[? weaponStats.strMod] = 0.05;
hastamCache[? weaponStats.dexMod] = 0.15;
hastamCache[? weaponStats.stagger] = 1.1;
hastamCache[? weaponStats.range] = 1.5;
hastamCache[? weaponStats.specialType] = -1;
hastamCache[? weaponStats.specialValue] = 0;
hastamCache[? weaponStats.uniqueAttack] = 15;
hastamCache[? weaponStats.misc] = noone;
			#endregion
			#region bent_spear (bellow average)
weaponCache[? weaponItem.bent_spear] = ds_map_create();
var bent_spearCache = weaponCache[? weaponItem.bent_spear];
bent_spearCache[? weaponStats.name] = "Bent Spear";
bent_spearCache[? weaponStats.type] = weaponClass.spear;
bent_spearCache[? weaponStats.damage] = 2.5;
bent_spearCache[? weaponStats.strMod] = 0.02;
bent_spearCache[? weaponStats.dexMod] = 0.10;
bent_spearCache[? weaponStats.stagger] = 1.1;
bent_spearCache[? weaponStats.range] = 1.25;
bent_spearCache[? weaponStats.specialType] = -1;
bent_spearCache[? weaponStats.specialValue] = 0;
bent_spearCache[? weaponStats.uniqueAttack] = 15;
bent_spearCache[? weaponStats.misc] = noone;
			#endregion
			#region areadbhar (above average)
weaponCache[? weaponItem.areadbhar] = ds_map_create();
var areadbharCache = weaponCache[? weaponItem.areadbhar];
areadbharCache[? weaponStats.name] = "Areadbhar";
areadbharCache[? weaponStats.type] = weaponClass.spear;
areadbharCache[? weaponStats.damage] = 4;
areadbharCache[? weaponStats.strMod] = 0.07;
areadbharCache[? weaponStats.dexMod] = 0.18;
areadbharCache[? weaponStats.stagger] = 1.1;
areadbharCache[? weaponStats.range] = 1.75;
areadbharCache[? weaponStats.specialType] = -1;
areadbharCache[? weaponStats.specialValue] = 0;
areadbharCache[? weaponStats.uniqueAttack] = 15;
areadbharCache[? weaponStats.misc] = noone;
			#endregion
			#region spear_of_assal (mega cool)
weaponCache[? weaponItem.spear_of_assal] = ds_map_create();
var spear_of_assalCache = weaponCache[? weaponItem.spear_of_assal];
spear_of_assalCache[? weaponStats.name] = "Spear of Assal";
spear_of_assalCache[? weaponStats.type] = weaponClass.spear;
spear_of_assalCache[? weaponStats.damage] = 5;
spear_of_assalCache[? weaponStats.strMod] = 0.10;
spear_of_assalCache[? weaponStats.dexMod] = 0.20;
spear_of_assalCache[? weaponStats.stagger] = 1.1;
spear_of_assalCache[? weaponStats.range] = 2;
spear_of_assalCache[? weaponStats.specialType] = -1;
spear_of_assalCache[? weaponStats.specialValue] = 0;
spear_of_assalCache[? weaponStats.uniqueAttack] = 15;
spear_of_assalCache[? weaponStats.misc] = noone;
			#endregion
			#region spear_of_lugh (mega cool)
weaponCache[? weaponItem.spear_of_lugh] = ds_map_create();
var spear_of_lughCache = weaponCache[? weaponItem.spear_of_lugh];
spear_of_lughCache[? weaponStats.name] = "Spear of Lugh";
spear_of_lughCache[? weaponStats.type] = weaponClass.spear;
spear_of_lughCache[? weaponStats.damage] = 6;
spear_of_lughCache[? weaponStats.strMod] = 0.07;
spear_of_lughCache[? weaponStats.dexMod] = 0.20;
spear_of_lughCache[? weaponStats.stagger] = 1.1;
spear_of_lughCache[? weaponStats.range] = 2;
spear_of_lughCache[? weaponStats.specialType] = -1;
spear_of_lughCache[? weaponStats.specialValue] = 0;
spear_of_lughCache[? weaponStats.uniqueAttack] = 15;
spear_of_lughCache[? weaponStats.misc] = noone;
			#endregion
		#endregion
	#endregion
	#region equipments
var equipmentCache = item[? itemType.equipment];
			#region Bomb
equipmentCache[? equipmentItem.bomb] = ds_map_create();
var cache = equipmentCache[? equipmentItem.bomb];
cache[? itemStats.name] = "Bomb";
cache[? itemStats.icon] = spr_icon_item_equipment_bomb;
cache[? itemStats.description] = "i go BOOOOOOOOOM";
			#endregion
			#region Arrow
equipmentCache[? equipmentItem.arrow] = ds_map_create();
var cache = equipmentCache[? equipmentItem.arrow];
cache[? itemStats.name] = "Arrow";
cache[? itemStats.icon] = spr_icon_item_equipment_arrow;
cache[? itemStats.description] = "if used right, im sharp and pointy";
			#endregion
			#region Grappling Hook
equipmentCache[? equipmentItem.grappling_hook] = ds_map_create();
var cache = equipmentCache[? equipmentItem.grappling_hook];
cache[? itemStats.name] = "Grappling Hook";
cache[? itemStats.icon] = spr_icon_item_equipment_grappling_hook;
//cache[? itemStats.description] = "when using me don't go weeeeeeeeeeee";
			#endregion
			#region Shovel
equipmentCache[? equipmentItem.shovel] = ds_map_create();
var cache = equipmentCache[? equipmentItem.shovel];
cache[? itemStats.name] = "Shovel";
cache[? itemStats.icon] = spr_icon_item_equipment_shovel;
cache[? itemStats.description] = "i'm pretty much useless... sorry. ajsdlka jhsdklJH SADLKWJBE FKA W NDBCLSK XJGHCLIASDJHGM. abns dkAJSHD; Kajhd;kJDS HK;D FBN.bsd LK.ASJ GHDLKasjhd.";
			#endregion
	#endregion
	#region accessories - not done
var accessoryCache = item[? itemType.accessory];
	#endregion
	#region keys
var keyCache = item[? itemType.key];
		#region Summon Stone
keyCache[? keyItem.summon_stone] = ds_map_create();
var cache = keyCache[? keyItem.summon_stone];
cache[? itemStats.name] = "Summon Stone";
cache[? itemStats.usable] = true;
cache[? itemStats.icon] = spr_icon_item_key_summon_stone;
cache[? itemStats.description] = "A stone that does some summoning or something.";
		#endregion
		#region Wooden Key
keyCache[? keyItem.wooden_key] = ds_map_create();
var cache = keyCache[? keyItem.wooden_key];
cache[? itemStats.name] = "Wooden Key";
cache[? itemStats.usable] = false;
cache[? itemStats.icon] = spr_icon_item_key_wooden_key;
cache[? itemStats.description] = "might be a simple key but it unlocks a world of wonders";
		#endregion
		#region Hearthstone
keyCache[? keyItem.hearthstone] = ds_map_create();
var cache = keyCache[? keyItem.hearthstone];
cache[? itemStats.name] = "Hearthstone";
cache[? itemStats.usable] = true;
cache[? itemStats.icon] = spr_icon_item_key_hearthstone;
cache[? itemStats.description] = "copy righted from WoW. I have no originality";
		#endregion
	#endregion
	#region alchemy items - not done
var alchemyCache = item[? itemType.alchemy];
	#endregion
#endregion

#region Player inventory
inventory = ds_map_create();
inventory[? itemType.item] = ds_map_create();
inventory[? itemType.weapon] = ds_map_create();
inventory[? itemType.equipment] = ds_map_create();
inventory[? itemType.accessory] = ds_map_create();
inventory[? itemType.key] = ds_map_create();
inventory[? itemType.alchemy] = ds_map_create();
#endregion
