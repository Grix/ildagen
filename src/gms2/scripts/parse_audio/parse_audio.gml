var t_bits = FMODGMS_Snd_Get_BitsPerSample(song_parse);
var t_channels = FMODGMS_Snd_Get_NumChannels(song_parse);

var t_length = 2048*round(t_bits/8)*t_channels;
var t_parsebuffer = buffer_create(t_length, buffer_fixed, 2);
var t_result = FMODGMS_Snd_ReadData(song_parse, 4096, t_length, buffer_get_address(t_parsebuffer));

if (t_result <= 0)
	show_message_new("Failed to read data: "+FMODGMS_Util_GetErrorMessage());
	
var t_bufferIn = buffer_create(2048*4, buffer_fixed, 4);
var t_bufferOut = buffer_create(2048*2, buffer_fixed, 4);

for (var t_i = 0; t_i < 2048; t_i++)
	buffer_write(t_bufferIn, buffer_f32, buffer_read(t_parsebuffer, buffer_s16));
	
ld = FMODGMS_Util_FFT(buffer_get_address(t_bufferIn), buffer_get_address(t_bufferOut), 2048);

	
yo = 2;