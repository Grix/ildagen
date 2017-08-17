///process_dialog_seq(map)

//Get integer
new_id = ds_map_find_value(argument[0], "id");
controller.dialog_open = 0;
controller.menu_open = 0;

if (new_id == getint)
{ 
    if ds_map_find_value(argument[0], "status")
   {
      switch (dialog)
      {
        case "objectduration":
        {
            if ds_list_empty(somaster_list)
                exit;
            
            objectlist = ds_list_find_value(somaster_list,0);
            infolisttomove = ds_list_find_value(objectlist,2);
            newduration = round(ds_map_find_value(argument[0], "value"));
            if (newduration < 1) 
                newduration = 1;
            newduration--;
            
            undolisttemp = ds_list_create();
            ds_list_add(undolisttemp,infolisttomove);
            ds_list_add(undolisttemp,infolisttomove[| 0]);
            ds_list_add(undo_list,"r"+string(undolisttemp));
            
            ds_list_replace(infolisttomove,0,newduration);
            
            //todo: check for collisions
            
            break;
        }
        case "fps":
        {
            projectfps = clamp(ds_map_find_value(argument[0], "value"),1,999);
            controller.projectfps = projectfps;
            break;
        }
        case "audioshift":
        {
            audioshift = ds_map_find_value(argument[0], "value");
            obj_audioshift.stringToDraw = "Offset: "+string_format(seqcontrol.audioshift,4,1)+"ms";
            
            break;
        }
        case "projectclear":
        {
            clear_project();
            
            break;
        }
        case "loadproject":
        {
            load_project(get_open_filename_ext("LaserShowGen project|*.igp","","","Select LaserShowGen project file"));
          
            break;
        }
          
        case "fromseq":
        {
            frames_fromseq();
            
            break;
        }
            
        case "envelopedelete":
        {
            selectedenvelope_index = ds_list_find_index(env_list_to_delete,selectedenvelope);
            if (selectedenvelope_index == -1) 
                exit;
            
            ds_list_destroy(ds_list_find_value(selectedenvelope,1));
            ds_list_destroy(ds_list_find_value(selectedenvelope,2));
            ds_list_destroy(selectedenvelope);
            ds_list_delete(env_list_to_delete,selectedenvelope_index);
            
            break;
        }
            
        case "layerdelete":
        {
            layer = layertodelete;
            selectedlayer = ds_list_find_index(layer_list,layer);
            if (selectedlayer == -1)
                exit;
            num_objects = ds_list_size(layer[| 1]);
            ds_list_clear(somaster_list);
            repeat (num_objects)   
            {
                ds_list_add(somaster_list,ds_list_find_value(layer[| 1],0));
                seq_delete_object_noundo();
            }
            ds_list_destroy(layer[| 1]);
            
            envelope_list = ds_list_find_value(layer,0);
            num_objects = ds_list_size(envelope_list);
            repeat (num_objects)   
            {
                envelope = ds_list_find_value(envelope_list,0);
                ds_list_destroy(ds_list_find_value(envelope,1));
                ds_list_destroy(ds_list_find_value(envelope,2));
                ds_list_destroy(envelope);
                ds_list_delete(envelope_list,0);
            }
            ds_list_destroy(envelope_list);
            
            var t_dac_list = ds_list_find_value(layer,5);
            num_objects = ds_list_size(t_dac_list);
            repeat (num_objects)  
                ds_list_destroy(ds_list_find_value(t_dac_list,0));
            ds_list_destroy(t_dac_list);
            
            ds_list_destroy(layer);
            ds_list_delete(layer_list,selectedlayer);
            
            selectedlayer = 0;
            selectedx = 0;
            
            break;
        }  
      }
    }
}
else if (new_id == getstr)
{
    if ds_map_find_value(argument[0], "status")
   {
      if ds_map_find_value(argument[0], "result") != ""
      {
          switch (dialog)
        {
            case ("layer_rename"):
            {
                var t_thisprojlist = seqcontrol.layer_list[| settingscontrol.projectortoselect];
                t_thisprojlist[| 4] = ds_map_find_value(argument[0], "result");
                projectorlist_update();
                break;
            }
        }
      }
   }
}
