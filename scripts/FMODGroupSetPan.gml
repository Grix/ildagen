//export double FMODGroupSetPan(double group, double pan)

//Set the group pan. -1(left) to 0 (center) to 1 (right)
//Regular Groups are 1-4. 0 for the master group. 
//Carefull, this overrides the instance and group pans too
return external_call(global.dll_FMODGroupSetPan,argument0,argument1);