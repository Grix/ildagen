tlpos = 0;    
playing = 0;
frame_surf_refresh = 1;

if (song)
    {
    FMODInstanceStop(songinstance);
    FMODSoundFree(song);
    }
    
num_layers = ds_list_size(layer);
selectedlayer = 0;
repeat (num_layers)   
    {
    layer = ds_list_find_value(layer_list,0);
    num_objects = ds_list_size(layer);
    repeat (num_objects)   
        {
        selectedx = -ds_list_find_value(layer,0);
        seq_delete_object_noundo();
        }
    ds_list_destroy(layer);
    ds_list_delete(layer_list,0);
    }
    
selectedlayer = -1;
ds_list_clear(layer_list);

//todo clear undo list
