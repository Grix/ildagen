/// @description output_frame_live(daclist)
/// @function output_frame_seq
/// @param daclist

minroomspeed = max(controller.projectfps,7.5);
    
output_buffer = controller.dac[| 4];
output_buffer2 = controller.dac[| 5];
output_buffer_ready = controller.dac[| 6];
output_buffer_next_size = controller.dac[| 7];

    
if (output_buffer_ready)
{
    dac_send_frame(controller.dac, output_buffer, output_buffer_next_size, output_buffer_next_size*controller.projectfps);
    frame_surf_refresh = false;
    output_buffer_ready = false;
    controller.laseronfirst = false;
    
    var t_output_buffer_prev = output_buffer;
    output_buffer = output_buffer2;
    output_buffer2 = t_output_buffer_prev;
}

maxpoints = 0;

if (selectedfile < 0 || selectedfile >= ds_list_size(filelist))
	exit;
    
buffer_seek(output_buffer, buffer_seek_start, 0);

el_list = ds_list_create(); 
    
objectlist = filelist[| selectedfile];

infolist =  ds_list_find_value(objectlist, 2);
object_length = ds_list_find_value(infolist, 0);
object_maxframes = ds_list_find_value(infolist, 2);

//draw object
el_buffer = ds_list_find_value(objectlist,1);
fetchedframe = frame mod object_maxframes;
buffer_seek(el_buffer,buffer_seek_start,0);
buffer_ver = buffer_read(el_buffer,buffer_u8);
if (buffer_ver != 52)
{
    show_message_new("Error: Unexpected idbyte in buffer for export_project. Things might get ugly. Contact developer.");
    controller.dac[| 4] = output_buffer;
    controller.dac[| 5] = output_buffer2;
    controller.dac[| 6] = output_buffer_ready;
    controller.dac[| 7] = output_buffer_next_size;
    exit;
}
buffer_maxframes = buffer_read(el_buffer,buffer_u32);
        
//skip to correct frame
for (i = 0; i < fetchedframe;i++)
{
    numofel = buffer_read(el_buffer,buffer_u32);
    for (u = 0; u < numofel; u++)
    {
        numofdata = buffer_read(el_buffer,buffer_u32)-20;
        buffer_seek(el_buffer,buffer_seek_relative,50+numofdata*3.25);
    }
}
            
buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
//make into lists
for (i = 0; i < buffer_maxelements;i++)
{
    numofinds = buffer_read(el_buffer,buffer_u32);
    ind_list = ds_list_create();
    ds_list_add(el_list,ind_list);
    for (u = 0; u < 10; u++)
    {
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
    }
            
    for (u = 10; u < 20; u++)
    {
        ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
    }
    for (u = 20; u < numofinds; u += 4)
    {
        xp = buffer_read(el_buffer,buffer_f32);
        yp = buffer_read(el_buffer,buffer_f32);
        bl = buffer_read(el_buffer,buffer_bool);
        c = buffer_read(el_buffer,buffer_u32);
        ds_list_add(ind_list,xp);
        ds_list_add(ind_list,yp);
        ds_list_add(ind_list,bl);
        ds_list_add(ind_list,c);
    }
}
    
//blindzones preview
if (room = rm_options)
{
    blindzone_el_lists = 0;
    for (i = 0; i < ds_list_size(controller.blindzone_list); i += 4)
    {
        var blindzone_el = ds_list_create();
        blindzone_el[| 19] = 0; //fills up to 19 with 0
        blindzone_el[| 10] = true;
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 1]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 1]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 3]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 3]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
        ds_list_add(blindzone_el, 0);
        ds_list_add(blindzone_el, c_white);
        ds_list_add(el_list, blindzone_el);
        blindzone_el_lists++;
    }
}

assemble_frame_dac();

if (room = rm_options)
{
    for (i = 0; i < blindzone_el_lists; i++)
    {
        ds_list_destroy(el_list[| ds_list_size(el_list)-1]);
        ds_list_delete(el_list, ds_list_size(el_list)-1);
    }
}

//cleanup
for (i = 0; i < ds_list_size(el_list); i++)
{
    ds_list_destroy(ds_list_find_value(el_list,i));
}
ds_list_destroy(el_list);

output_buffer_ready = true;
controller.dac[| 4] = output_buffer;
controller.dac[| 5] = output_buffer2;
controller.dac[| 6] = output_buffer_ready;
controller.dac[| 7] = output_buffer_next_size;


