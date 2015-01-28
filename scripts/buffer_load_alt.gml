tempfile = FS_file_bin_open(argument0,0);
tempfilesize = FS_file_bin_size(tempfile);
tempbuffer = buffer_create(tempfilesize,buffer_fixed,1);

for (b = 0; b < tempfilesize; b++)
    {
    byte = FS_file_bin_read_byte(tempfile);
    //show_debug_message(byte)
    buffer_write(tempbuffer,buffer_u8,byte);
    }

buffer_seek(tempbuffer,buffer_seek_start,0);
return tempbuffer;
