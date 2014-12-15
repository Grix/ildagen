//export double FMODGetTagData()
//Gets the tag data from a stream
//Refer to Visual Music Demo
var buf;
buf = string_repeat(chr(0), 2048);
var len;
len = external_call(global.dll_FMODGetTagData,buf);
return "" + string_copy(buf,1,len);