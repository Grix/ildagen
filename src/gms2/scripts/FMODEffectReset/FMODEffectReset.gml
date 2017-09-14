//export double FMODEffectReset(double effect)
//Resets the effect

//FMODEffectReset(effect);

//According to the docs, this clears the effect from any remnent data
//which I now realize is only useful if you reuse the effect on another instance
//which my dll does not allow

return external_call(global.dll_FMODEffectReset,argument0);
