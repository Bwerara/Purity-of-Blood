//console initializer
tmp = "";
hackSpawn = 0;
consoleState = "off";
commandStr = "";
commandRes = "";
selectIndex = 0;
clickHack = 0;
helpMenu = 0;
defaultRoomSpeed = room_speed;
for (var i=0; i<7; i++)
{
	history[i] = "";
	historyM[i] = "";
}
historyM[0] = "enter '?' or 'help' for options"

//LIST OF COMMANDS
	//GOTO
	//SET ROOM SPEED
	//CLICK HACK
	//SHUTDOWN
	//HELP
helpText[0] = "Commands:"
helpText[1] = "goto <room Name>"
helpText[2] = "setroomspeed <integer > 0>"
helpText[3] = "clickhack"
helpText[4] = "shutdown"
helpText[5] = "vsync toggle"
helpText[6] = "help   /   ?"
//Messages
helpTextM[0] = "Information:"
helpTextM[1] = "Transfers you to <room Name>, likely will cause progression related bugs."
helpTextM[2] = "Changes room speed to <integer > 0>, likely will cause many timing related bugs, dont do this."
helpTextM[3] = "Enables/disables the ability tomove character to the clicked location, likely will cause progression/collision related bugs."
helpTextM[4] = "Hard shutdown of the game, will not save, will not do anything"
helpTextM[5] = "Toggle vsync"
helpTextM[6] = "Enable/disable help menu"