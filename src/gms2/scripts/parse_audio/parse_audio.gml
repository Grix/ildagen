var t_parsebuffer = buffer_create(1024, buffer_fixed, 2);
var t_result = FMODGMS_Snd_ReadData(song_parse, 0, 1024, buffer_get_address(t_parsebuffer));

if (t_result <= 0)
	show_message_new("Failed to read data: "+FMODGMS_Util_GetErrorMessage());