//export double FMODInstanceGetLoopCount(double instance)

//Returns the instance loop count (0 - done looping (performing last play), -1 looping forever, >0 Number of loops left)

return external_call(global.dll_FMODInstanceGetLoopCount,argument0);
