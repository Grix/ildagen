//export double FMODSoundSetGroup(double sound, double group)
//You have 4 groups in the system
//returns 1 on success
//returns 0 on error
//Groups are a number from 1 to 4
//priority - 1 //Assured to me played. Use for menu and game critical sounds/music)
//effects - 2 //Will be bumped if concurent instance count is reached and priority soun needs to play
//ambientmusic - 3 //Will be cut by abouve group of count is maxed (background music usually)
//ambient effects -4 //will be cut by any above. rain sound, river sounds

//Is also defines what volume setting the sound will obey as you can play with groups volume,mute and pause
//if you dont set the group, only the GlobalVolume and instancevolume will affect the sound
//sound = FMODSoundAdd("gunshot.wav");
//FMODSoundSetGroup(sound,2);

//Call before playing the sound

return external_call(global.dll_FMODSoundSetGroup,argument0,argument1);
