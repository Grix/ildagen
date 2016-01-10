//reads a hershey font file
if (ds_exists(hershey_list,ds_type_list))
    exit;
hershey_list = ds_list_create();
ds_list_clear(hershey_index_list);
cnt = 0;

hershey_file = file_bin_open("hershey",0);
ini_open(get_save_filename("",""));

for (i = 0; i < 9999; i++)
    {
    if (file_bin_size(hershey_file) <= file_bin_position(hershey_file))
        break;
    
    hershey_string = "";
    
    frame_list_parse = ds_list_create();
    
    file_bin_seek(hershey_file,file_bin_position(hershey_file)+5);
    ds_list_add(hershey_index_list,file_bin_position(hershey_file));

    maxglyphpoints = 0;
    maxglyphpoints += 100*real(chr(file_bin_read_byte(hershey_file)));//  string_char_at(hershey_string,c));
    maxglyphpoints += 10*real(chr(file_bin_read_byte(hershey_file)));
    maxglyphpoints += real(chr(file_bin_read_byte(hershey_file)));
    
    ini_write_real(string(i),"n",maxglyphpoints);
    

    hershey_string += chr(file_bin_read_byte(hershey_file));
    hershey_string += chr(file_bin_read_byte(hershey_file));
    
    repeat(maxglyphpoints-1)
        {
        hershey_string += chr(file_bin_read_byte(hershey_file));
        hershey_string += chr(file_bin_read_byte(hershey_file));
        }
    ini_write_string(string(i),"s",hershey_string);
    }
    
file_bin_close(hershey_file);
ini_close();

font_type = 1;
return 1;
