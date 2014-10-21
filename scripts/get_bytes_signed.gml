//returns two next bytes combined

byte0 = get_byte();
//byte0t = byte0 & $7F;
//minus = 1-2*(byte0t != byte0);
//file_bin_seek(ild_file,i+icp+1);
//byte1 = file_bin_read_byte(ild_file);
//buffer_seek(ild_file, i+icp+1, 0);
byte1 = buffer_peek(ild_file, i+1, buffer_u8);
//show_debug_message("word unsign "+string(i)+" "+string(byte0)+" "+string(byte1)+" "+string(((byte0 << 8) + byte1)*minus));
//file_bin_seek(ild_file,i+1);
//byte1 = file_bin_read_byte(ild_file);
return ((byte0 << 8) + byte1)//*minus;


//return byte1;