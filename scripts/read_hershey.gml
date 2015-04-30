//reads a hershey font file
if (ds_exists(hershey_list,ds_type_list))
    exit;
hershey_list = ds_list_create();
ds_list_clear(hershey_index_list);
cnt = 0;

hershey_file = file_bin_open("hershey",0);

while (1)
    {
    if (file_bin_size(hershey_file) <= file_bin_position(hershey_file))
        break;
    
    frame_list_parse = ds_list_create();
    
    /*glyphno = 0;
    if !hershey_error() return 0;
    glyphno += 10000*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    glyphno += 1000*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    glyphno += 100*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    glyphno += 10*real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;
    glyphno += real(FS_file_text_read_char(hershey_file,1));
    if !hershey_error() return 0;*/
    //c+= 5;
    file_bin_seek(hershey_file,file_bin_position(hershey_file)+5);
    ds_list_add(hershey_index_list,file_bin_position(hershey_file));

    maxglyphpoints = 0;
    maxglyphpoints += 100*real(chr(file_bin_read_byte(hershey_file)));//  string_char_at(hershey_string,c));
    maxglyphpoints += 10*real(chr(file_bin_read_byte(hershey_file)));
    maxglyphpoints += real(chr(file_bin_read_byte(hershey_file)));
    
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0);
    ds_list_add(frame_list_parse,0); 
    ds_list_add(frame_list_parse,el_id); //id
    repeat (40) ds_list_add(frame_list_parse,0); 
    blank = 0;
    
    constrxchar = file_bin_read_byte(hershey_file);
    constrychar = file_bin_read_byte(hershey_file);
    constrx = max((constrxchar - $52),1);
    constry = max((constrychar - $52),1);
    
    repeat(maxglyphpoints-1)
        {
        nextcharx = file_bin_read_byte(hershey_file);
        nextchary = file_bin_read_byte(hershey_file);
        if (nextcharx == $20) and (nextchary == $52)
            {
            blank = 1;
            continue;
            }
        nextpointx = (nextcharx - $52)/constrx/1.2;
        nextpointy = (nextchary - $52)/constrx/1.2;
        
        ds_list_add(frame_list_parse,nextpointx);
        ds_list_add(frame_list_parse,nextpointy);
        ds_list_add(frame_list_parse,blank);
        blank = 0;
        ds_list_add(frame_list_parse,255);
        ds_list_add(frame_list_parse,255);
        ds_list_add(frame_list_parse,255);
        
        }
    ds_list_add(hershey_list,frame_list_parse);
    }
    
file_bin_close(hershey_file);

font_type = 1;
return 1;
