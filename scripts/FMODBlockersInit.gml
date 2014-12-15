//export double FMODBlockersInit(double NumBlockers, double xs, double ys, double zs)

//Blockers block sounds in the game, useful for walls, windows and other things

//This turns the blocker feature on. Call it before you play any sounds
//NumBlockers specifies the number of blocker in the room try to match your game and not to create too many blockers
//xs is the room width
//ys is the room height
//zs is the zspace (use 0) if not room
//The system actualy makes an equilateral cube region the size of the biggest s value.
//FMOD warns not to set these to a "too large" value with no mention what a "too large" value is
//Call it when the room starts with numblockes set to your wall count + door count + window count
//See FMODBlockersAddGMObjects to add your object to the system easily
//FMODBlockersInit(instance_number(wallsobj) + instance_number(doorsobj),room_width,room_height,0);
return external_call(global.dll_FMODBlockersInit,argument0,argument1,argument2,argument3);