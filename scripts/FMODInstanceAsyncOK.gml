//export double FMODInstanceAsyncOK(double instance)

//This is hard core. 
//Refer to the VisualMusic demo for proper use
//Adds a sound (from a web stream usually, but can be used for regular files)
//The sound is not ready to setup until FMODSoundAsyncReady returns true

//sound = FMODSoundAddAsyncStream("http://www.server.com:80")
//in step event
//if(FMODSoundAsyncReady(sound)) 
//{
//    FMODSoundSetMaxVolume(sound,.5)
//    instance = FMODSoundPlay(sound);
//}

//There are a lot of other things to do while it plays...

//if(instance and !FMODInstanceAsyncOK(instance)) 
//{
//    FMODInstanceSetMuted(instance,true)
//    other things needed like if timed out, refer to VisualMusic demo
//}
//else
//{
//    FMODInstanceSetMuted(instance,false)
//}
return external_call(global.dll_FMODInstanceAsyncOK,argument0);