//export double FMODUpdateTakeOverDone()
//returns 0 on error
//returns 1 on success

//This function in used after you pop up a dialog box in GM
//Or show the Help (F1)
//Or go into a long loop when GM events will no longer be called
//Therefore FMODUpdate will no longer be called, which may freeze the music
//after a few seconds

//in the case of F1, you would have to disable GM's automatic handling of it
//and recreate it 
//FMODUpdateTakeOverWhileLocked()
//show_info();
//FMODUpdateTakeOverDone()

//for dialog boxes
//FMODUpdateTakeOverWhileLocked()
//filename = get_open_filename()
//FMODUpdateTakeOverDone()
return external_call(global.dll_FMODUpdateTakeOverDone);
