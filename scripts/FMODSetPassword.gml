//export double FMODSetPassword(LPCSTR password)
//Sets the password to use for encrypted sound files
//Call this from the start if all your sounds have the same password
//or before SoundAdd if your sounds have different passwords
//Password does not affect non encrypted files
return external_call(global.dll_FMODSetPassword,argument0);