var t_warn = false;
var t_plist = seqcontrol.projector_list;

ini_open("settings.ini");

for (i = 0; i < ds_list_size(t_plist); i++)
{
    var t_thisplist = t_plist[| i];
    
    if (controller.el_id <= t_thisplist[| 0])
        controller.el_id = t_thisplist[| 0]+1;

    var t_daclist = t_thisplist[| 2];
    
    for (j = 0; j < ds_list_size(t_daclist); j++)
    {
        //check if dac still is connected
        var t_thisdaclist = t_daclist[| j];
        var t_found = -1;
        for (k = 0; k < ds_list_size(controller.dac_list); k++)
        {
            var t_thisdaclist2 = controller.dac_list[| k];
            if (t_thisdaclist[| 1] == t_thisdaclist2[| 1])
            {
                t_found = k;
                break;
            }
        }
        if (t_found == -1)
        {
            ds_list_destroy(t_thisdaclist);
            ds_list_delete(t_daclist,j);
            j--;
            warn = true;
            continue;
        }
        else
        {
            t_thisdaclist[| 0] = t_found;
        }
        
        //resolve preset errors
        if ((t_thisdaclist[| 3] == "") || (t_thisdaclist[| 2] == -1))
        {
            var t_projectorstring = "projector_"+string(t_thisdaclist[| 2]);
            projector_name = ini_read_string(t_projectorstring, "name", "error");
                
            if (projector_name == "error")
            {
                ds_list_replace(t_thisdaclist, 2, -1);
                ds_list_replace(t_thisdaclist, 3, "DEFAULT");
            }
            else
            {
                ds_list_replace(t_thisdaclist, 3, projector_name);
            }
        }
    }
    
    //force same preset for all duplicate dacs
    /*for (j = 0; j < ds_list_size(t_daclist); j++)
    {
        var t_thisdaclist = t_daclist[| j];
        var t_found = -1;
        for (l = i; l < ds_list_size(t_plist); l++)
        {
            var t_thisplist2 = t_plist[| l];
            var t_daclist2 = t_thisplist2[| 4];
            var t_start = 0;
            if (l == i)
                t_start = j+1;
            for (k = t_start; k < ds_list_size(t_daclist); k++)
            {
                var t_thisdaclist2 = t_daclist2[| k];
                if (t_thisdaclist[| 0] == t_thisdaclist2[| 0])
                {
                    ds_list_destroy(t_thisdaclist2);
                    ds_list_delete(t_daclist,k);
                    k--;
                    warn = true;
                }
            }
        }
    }*/
}

/*if (warn)
{
    show_message_async("Warning: One or more DACs have been removed from their timeline projector configuration due to being disconnected or referenced multiple times.");
}*/

if (room == rm_options)
    surface_free(obj_projectors.surf_projectorlist);
    
ini_close();
