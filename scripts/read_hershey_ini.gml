//reads a hershey font file
if (ds_exists(hershey_list,ds_type_list))
    exit;
hershey_list = ds_list_create();
ds_list_clear(hershey_index_list);
cnt = 0;

ini_open("hershey.ini");

for (i = 0; i < 2352; i++)
    {
    frame_list_parse = ds_list_create();

    maxglyphpoints = ini_read_real(string(i),"n",0);
    hershey_string = ini_read_string(string(i),"s","");
    
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
    
    j = 1;
    constrxchar = ord(string_char_at(hershey_string,j));
    j++;
    constrychar = ord(string_char_at(hershey_string,j));
    j++;
    constrx = max((constrxchar - $52),1);
    constry = max((constrychar - $52),1);
    
    /*if (maxglyphpoints == 1)
        {
        nextcharx = file_bin_read_byte(hershey_file);
        nextchary = file_bin_read_byte(hershey_file);
        nextpointx = (nextcharx - $52)/constrx/1.2;
        nextpointy = (nextchary - $52)/constrx/1.2;
        
        repeat (2)
            {
            ds_list_add(frame_list_parse,nextpointx);
            ds_list_add(frame_list_parse,nextpointy);
            ds_list_add(frame_list_parse,blank);
            ds_list_add(frame_list_parse,255);
            ds_list_add(frame_list_parse,255);
            ds_list_add(frame_list_parse,255);
            }
        }
    else*/ repeat(maxglyphpoints-1)
        {
        nextcharx = ord(string_char_at(hershey_string,j));
        j++;
        nextchary = ord(string_char_at(hershey_string,j));
        j++;
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
    
ini_close();

font_type = 1;
return 1;
