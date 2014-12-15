//export double FMODInstanceSetSpeakerMix(
//  double instance,  
//  double  frontleft, 
//  double  frontright, 
//  double  center, 
//  double  lfe, 
//  double  backleft, 
//  double  backright, 
//  double  sideleft, 
//  double  sideright)

//Set how the instance is played over the all the speakers
//Pretty sure if the sound is threed, the function has no effect
//You can actualy make pretty cool effect with this

//each speaker setting takes a value from 0 (mute) to 1 (normal) to 5 (amplified x5)

//returns 0 or failure, 1 on success
return external_call(global.dll_FMODInstanceSetSpeakerMix,argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8);