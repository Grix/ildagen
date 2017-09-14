//Get the last error in the dll
//Call only if the result of anthe call returns 0nothe FMOD call returns 0;

//errnumber = FMODGetLastError();

///Example call
//if(FMODInit(100) = 0) show_message(FMODErrorStr(FMODGetLastError()));

//export double FMODGetLastError(void)
return external_call(global.dll_FMODGetLastError);
