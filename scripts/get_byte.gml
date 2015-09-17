//returns byte at pos i


//file_bin_seek(ild_file,i);
//file_bin_read_byte(ild_file);
//return file_bin_(ild_file);
//buffer_seek(ild_file, i+icp+1, 0);
return buffer_peek(ild_file, i, buffer_u8);
//wordrf = (byterf0 << 8) + byterf1;
