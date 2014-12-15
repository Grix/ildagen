//export double FMODInstanceGetNextTag(double instance)
//returns 1 is there is a (new) tag to be looked at.
//reads the next unread tag from the stream
//Use FMODGetTagName and FMODGetTagData to get the tags information you just read
//Refer to Visual Music Demo

return external_call(global.dll_FMODInstanceGetNextTag,argument0);