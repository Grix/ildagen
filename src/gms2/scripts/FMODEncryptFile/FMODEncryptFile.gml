//export double FMODEncryptFile(string sourcefile, string destfile, string password)
//returns 0 on error
//returns 1 on success
//Destination file will be deleted if it exists
//Will show error message boxes.  No FMODGetLastError on this one.
//Use this to encrypt your sounds without using the included password encryption applet

return external_call(global.dll_FMODEncryptFile,argument0,argument1,argument2);
