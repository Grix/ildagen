tlpos = 0;    
playing = 0;
frame_surf_refresh = 1;
parsingaudio = 0;
ds_list_destroy(audio_list);
audio_list = ds_list_create();

//todo free memory better:
for (u = 0; u < ds_list_size(undo_list); u++)
    {
    if (ds_exists(ds_list_find_value(undo_list,u),ds_type_list))
        ds_list_destroy(ds_list_find_value(undo_list,u));
    }
ds_list_destroy(undo_list);
undo_list = ds_list_create();

if (song)
    {
    FMODInstanceStop(songinstance);
    FMODSoundFree(song);
    song = 0;
    }
    
num_layers = ds_list_size(layer_list);
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

//todo clear undo list