//reads a hershey font file and returns the index font list,
//then draws to preview surface
/*
hershey_file = file_bin_open("hershey",0);

frame_list_parse = ds_list_create();

file_bin_seek(hershey_file,ds_list_find_value(hershey_index_list,hershey_selected));

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
ds_list_add(frame_list_parse,0); //id
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
    nextpointx = (nextcharx - $52)/constrx*600;
    nextpointy = (nextchary - $52)/constrx*600;
    
    ds_list_add(frame_list_parse,nextpointx);
    ds_list_add(frame_list_parse,nextpointy);
    ds_list_add(frame_list_parse,blank);
    blank = 0;
    ds_list_add(frame_list_parse,255);
    ds_list_add(frame_list_parse,255);
    ds_list_add(frame_list_parse,255);
    }
    
file_bin_close(hershey_file);

if (surface_exists(hershey_preview_surf))
    surface_free(hershey_preview_surf)
    
hershey_preview_surf = surface_create(512,512);

surface_set_target(hershey_preview_surf);
draw_set_color(c_white);

new_list = frame_list_parse;
    
xo = 256;
yo = 256;
listsize = (((ds_list_size(new_list)-50)/6)-1);

for (u = 0; u < listsize; u++)
    {
    nbl = ds_list_find_value(new_list,50+(u+1)*6+2);
    
    if (nbl == 0)
        {
        xp = ds_list_find_value(new_list,50+u*6+0);
        yp = ds_list_find_value(new_list,50+u*6+1);
        
        nxp = ds_list_find_value(new_list,50+(u+1)*6+0);
        nyp = ds_list_find_value(new_list,50+(u+1)*6+1);
        
        draw_line(xo+ xp,yo+ yp,xo+ nxp,yo+ nyp);
        show_debug_message(xo+xp)
        }
    }
    
surface_reset_target();   
     
ds_list_destroy(new_list);
    
