//export double FMODInstanceSetLoopCount(double instance, double loopcount)
//Set the instance loop count. -1 loop forever, 0 no loop >0 the number of times to loop 
//(1 will loop once, playing the sound twice)
return external_call(global.dll_FMODInstanceSetLoopCount,argument0,argument1);