with(controller)
{
    frames_tolive_importedilda();
    
    ds_list_destroy(ild_list);
}
    
global.loading_importildalive = 0;
room_goto(rm_live);
return 1;
