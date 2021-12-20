function undo_seq() {
	with (seqcontrol)
	{
	    if (ds_list_empty(undo_list))
	        exit;
        
		timeline_surf_length = 0;
	    undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
	    ds_list_delete(undo_list,ds_list_size(undo_list)-1);
    
	    if (string_char_at(undo,0) == "c")
	    {
	        //undo create object (delete)
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
	        objectlist = ds_list_find_value(undolisttemp,0);
	        if (!ds_list_exists(objectlist))
	        {
	            ds_list_destroy(undolisttemp); undolisttemp = -1;
	            exit;
	        }
			
			for (c = 0; c < ds_list_size(layer_list); c++)
		    {
		        layerlisttemp = ds_list_find_value(ds_list_find_value(layer_list,c), 1);
		        if (ds_list_find_index(layerlisttemp,objectlist) != -1)    
		        {
		            ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));
					
					redolisttemp = ds_list_create();
			        ds_list_add(redolisttemp,layerlisttemp);
			        ds_list_add(redolisttemp,objectlist);
			        ds_list_add(redo_list,"d"+string(redolisttemp));
					
					break;
		        }
		    }
			
	        ds_list_clear(somaster_list);
			
	        ds_list_destroy(undolisttemp);undolisttemp = -1;
	    }
	    else if (string_char_at(undo,0) == "s")
	    {
	        //undo split
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
	        objectlist = ds_list_find_value(undolisttemp,0);
	        objectlist1 = ds_list_find_value(undolisttemp,1);
	        objectlist2 = ds_list_find_value(undolisttemp,2);
	        if (!ds_list_exists(objectlist1) || !ds_list_exists(objectlist2) || !ds_list_exists(objectlist))
	        {
	            //ds_list_destroy(undolisttemp);
	            //ds_list_destroy(objectlist);
	            exit;
	        }
        
	        for (j = 0; j < ds_list_size(layer_list); j++)
	        {
	            layertop = layer_list[| j];
	            _layer = layertop[| 1];
	            if (ds_list_find_index(_layer, objectlist1) != -1)
	            {
	                ds_list_delete(_layer, ds_list_find_index(_layer, objectlist1));
	                ds_list_delete(_layer, ds_list_find_index(_layer, objectlist2));
	                ds_list_add(_layer, objectlist);
					
					redolisttemp = ds_list_create();
	                ds_list_add(redolisttemp, objectlist);
	                ds_list_add(redolisttemp, objectlist1);
	                ds_list_add(redolisttemp, objectlist2);
	                ds_list_add(redo_list, "z"+string(redolisttemp));
	            }
	        }
	        ds_list_destroy(undolisttemp);undolisttemp = -1;
	    }
		else if (string_char_at(undo,0) == "z")
	    {
	        //undo merge (only in redo now, opposite of split)
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
	        objectlist = ds_list_find_value(undolisttemp,0);
	        objectlist1 = ds_list_find_value(undolisttemp,1);
	        objectlist2 = ds_list_find_value(undolisttemp,2);
	        if (!ds_list_exists(objectlist1) || !ds_list_exists(objectlist2) || !ds_list_exists(objectlist))
	        {
	            //ds_list_destroy(undolisttemp);
	            //ds_list_destroy(objectlist);
	            exit;
	        }
        
	        for (j = 0; j < ds_list_size(layer_list); j++)
	        {
	            layertop = layer_list[| j];
	            _layer = layertop[| 1];
	            if (ds_list_find_index(_layer, objectlist) != -1)
	            {
	                ds_list_delete(_layer, ds_list_find_index(_layer, objectlist));
	                ds_list_add(_layer, objectlist1);
	                ds_list_add(_layer, objectlist2);
					
					redolisttemp = ds_list_create();
	                ds_list_add(redolisttemp, objectlist);
	                ds_list_add(redolisttemp, objectlist1);
	                ds_list_add(redolisttemp, objectlist2);
	                ds_list_add(redo_list, "s"+string(redolisttemp));
	            }
	        }
	        ds_list_destroy(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "d")
	    {
	        //undo delete object
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
	        objectlist = ds_list_find_value(undolisttemp,1);
	        layerlisttemp = ds_list_find_value(undolisttemp,0);
	        if (!ds_list_exists(layerlisttemp))
	        {
	            //ds_list_destroy(undolisttemp);
	            exit;
	        }
			
			redolisttemp = ds_list_create();
		    ds_list_add(redolisttemp,objectlist);
		    ds_list_add(redo_list,"c"+string(redolisttemp));
            
	        ds_list_add(layerlisttemp,objectlist);
	        ds_list_destroy(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "r")
	    {
	        //undo resize object
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
	        infolist = undolisttemp[| 0];
	        if (!ds_list_exists(infolist))
	        {
	            //ds_list_destroy(undolisttemp);
	            exit;
	        }
			
			redolisttemp = ds_list_create();
	        ds_list_add(redolisttemp,infolist);
	        ds_list_add(redolisttemp,infolist[| 0]);
	        ds_list_add(redo_list,"r"+string(redolisttemp));
			
	        ds_list_replace(infolist,0,undolisttemp[| 1]);
			
	        ds_list_destroy(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "m")
	    {
	        //undo move object
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
	        objectlist = ds_list_find_value(undolisttemp,0);
	        layerlisttemp = ds_list_find_value(undolisttemp,1);
	        frametime = ds_list_find_value(undolisttemp,2);
	        if (!ds_list_exists(layerlisttemp) || !ds_list_exists(objectlist))
	        {
	            //ds_list_destroy(undolisttemp);
	            exit;
	        }
            
	        for (j = 0; j < ds_list_size(layer_list); j++)
	        {
	            layertop = layer_list[| j];
	            _layer = layertop[| 1];
	            if (ds_list_find_index(_layer, objectlist) != -1)
	            {
					redolisttemp = ds_list_create();
	                ds_list_add(redolisttemp,objectlist);
	                ds_list_add(redolisttemp,_layer);
	                ds_list_add(redolisttemp,objectlist[| 0]);
					ds_list_add(redo_list,"m"+string(redolisttemp));
					
	                ds_list_delete(_layer, ds_list_find_index(_layer, objectlist));
	                ds_list_replace(objectlist, 0, frametime); 
	                ds_list_add(layerlisttemp, objectlist);
	            }
	        }
	        ds_list_destroy(undolisttemp);
	    }
	    else if (string_char_at(undo,0) == "l")
	    {
	        //undo marker clear
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
				
	        ds_list_add(redo_list,"l"+string(marker_list));
			
	        marker_list = undolisttemp;
	    }
	    else if (string_char_at(undo,0) == "e")
	    {
	        //undo envelope data clear/edit
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
	        if (!ds_list_exists(ds_list_find_value(undolisttemp,2)))
	        {
	            ds_list_destroy( ds_list_find_value(undolisttemp,0) );
	            ds_list_destroy( ds_list_find_value(undolisttemp,1) );
	        }
	        else
	        {
	            var t_selectedenvelope = ds_list_find_value(undolisttemp,2);
				
				var t_redolist = ds_list_create();
				ds_list_add(t_redolist,ds_list_find_value(t_selectedenvelope,1));
				ds_list_add(t_redolist,ds_list_find_value(t_selectedenvelope,2));
				ds_list_add(t_redolist,t_selectedenvelope);
				ds_list_add(redo_list,"e"+string(t_redolist));
				
	            ds_list_replace( t_selectedenvelope,1,ds_list_find_value(undolisttemp,0) );
	            ds_list_replace( t_selectedenvelope,2,ds_list_find_value(undolisttemp,1) );
	        }
	        ds_list_destroy(undolisttemp);
	    }
		else if (string_char_at(undo,0) == "a")
	    {
	        //undo reverse
	        var t_listtoreverse = real(string_digits(undo));
			ds_list_clear(somaster_list);
			ds_list_add(somaster_list, t_listtoreverse);
			reverse_timelineobject(false);
			ds_list_add(redo_list, "a"+string(t_listtoreverse));
	    }
		else if (string_char_at(undo,0) == "k")
	    {
	        //undo create marker
	        var t_markerpos = real(string_digits(undo));
			for (i = 0; i < ds_list_size(marker_list); i++)
			{
				if (marker_list[| i] = t_markerpos)
				{
					ds_list_delete(marker_list, i);
					ds_list_add(redo_list, "j"+string(t_markerpos));
				}
			}
			exit;
		}
		else if (string_char_at(undo,0) == "j")
	    {
	        //undo delete marker
	        var t_markerpos = real(string_digits(undo));
			ds_list_add(marker_list, t_markerpos);
			ds_list_add(redo_list, "k"+string(t_markerpos));
			exit;
		}
		else if (string_char_at(undo,0) == "h")
	    {
	        //undo move marker
	        undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
			var t_markerpos = undolisttemp[| 0];
			for (i = 0; i < ds_list_size(marker_list); i++)
			{
				if (marker_list[| i] = t_markerpos)
					ds_list_delete(marker_list, i);
			}
			t_markerpos = undolisttemp[| 1];
			ds_list_add(marker_list, t_markerpos);
			
			var t_redolist = ds_list_create();
			ds_list_add(t_redolist, undolisttemp[| 1]);
			ds_list_add(t_redolist, undolisttemp[| 0]);
			ds_list_add(redo_list, "h"+string(t_redolist));
			
			ds_list_destroy(undolisttemp);
			exit;
		}
		else if (string_char_at(undo,0) == "p")
	    {
	        //undo create envelope
	        var t_envelopetodelete = real(string_digits(undo));
			if (!ds_list_exists(t_envelopetodelete))
	            exit;
				
			for (i = 0; i < ds_list_size(layer_list); i++)
			{
				var t_envelope_list = layer_list[| i][| 0];
				for (j = 0; j < ds_list_size(t_envelope_list); j++)
				{
					if (t_envelope_list[| j] == t_envelopetodelete)
					{
						ds_list_delete(t_envelope_list, j);
						
						var t_redo_list = ds_list_create();
						ds_list_add(t_redo_list, t_envelopetodelete);
						ds_list_add(t_redo_list, t_envelope_list);
						ds_list_add(redo_list, "x"+string(t_redo_list));
						timeline_surf_length = 0;
						break;
					}
				}
			}
	    }
		else if (string_char_at(undo,0) == "x")
	    {
			// undo delete envelope
			undolisttemp = real(string_digits(undo));
			if (!ds_list_exists(undolisttemp))
	            exit;
				
			var t_envelope = undolisttemp[| 0];
			if (!ds_list_exists(t_envelope))
	            exit;
			var t_layer_envelope_list = undolisttemp[| 1];
			if (!ds_list_exists(t_layer_envelope_list))
	            exit;
				
			ds_list_add(t_layer_envelope_list, t_envelope);
			timeline_surf_length = 0;
			ds_list_add(redo_list, "p"+string(t_envelope));
			
			ds_list_destroy(undolisttemp);
		}
		else if (string_char_at(undo,0) == "q")
	    {
	        //undo create layer
	        var t_layertodelete = real(string_digits(undo));
			if (!ds_list_exists(t_layertodelete) || ds_list_size(t_layertodelete[| 1]) > 0)
	            exit;
				
			for (i = 0; i < ds_list_size(layer_list); i++)
			{
				if (layer_list[| i] == t_layertodelete)
				{
					if (ds_list_exists(t_layertodelete[| 0]))
						ds_list_destroy(t_layertodelete[| 0]);
					if (ds_list_exists(t_layertodelete[| 1]))
						ds_list_destroy(t_layertodelete[| 1]);
					if (ds_list_exists(t_layertodelete[| 5]))
						ds_list_destroy(t_layertodelete[| 5]);
					ds_list_destroy(t_layertodelete); t_layertodelete = -1;
					ds_list_delete(layer_list, i);
					timeline_surf_length = 0;
					
					ds_list_add(redo_list, "w");
					
					break;
				}
			}
	    }
		else if (string_char_at(undo,0) == "w")
	    {
			// restore layer (empty only)
			newlayer = ds_list_create();
		    ds_list_add(layer_list,newlayer);
		    ds_list_add(newlayer,ds_list_create()); //envelope list
		    ds_list_add(newlayer,ds_list_create()); //objects list
		    ds_list_add(newlayer,0); 
		    ds_list_add(newlayer,0);
		    ds_list_add(newlayer,"Layer "+string(controller.el_id));
		    controller.el_id++;
		    ds_list_add(newlayer,ds_list_create()); //dac list
			ds_list_add(newlayer,0); 
		    ds_list_add(newlayer,0);
			ds_list_add(newlayer,0); 
		    ds_list_add(newlayer,0);
			ds_list_add(redo_list, "q"+string(newlayer));
			timeline_surf_length = 0;
		}
		else
			exit;
    
	    frame_surf_refresh = 1;
	    selectedlayer = 0;
	    selectedx = 0;
	}



}
