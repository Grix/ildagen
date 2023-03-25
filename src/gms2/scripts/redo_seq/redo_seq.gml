function redo_seq() {
	with (seqcontrol)
	{
	    if (ds_list_empty(redo_list))
	        exit;
        
		timeline_surf_length = 0;
	    redo = ds_list_find_value(redo_list,ds_list_size(redo_list)-1);
	    ds_list_delete(redo_list,ds_list_size(redo_list)-1);
    
	    if (string_char_at(redo,0) == "c")
	    {
	        //redo create object (delete)
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
	        objectlist = ds_list_find_value(redolisttemp,0);
	        if (!ds_list_exists(objectlist))
	        {
	            ds_list_destroy(redolisttemp);
	            exit;
	        }
			
			for (c = 0; c < ds_list_size(layer_list); c++)
		    {
		        layerlisttemp = ds_list_find_value(ds_list_find_value(layer_list,c), 1);
		        if (ds_list_find_index(layerlisttemp,objectlist) != -1)    
		        {
		            ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));
					
					undolisttemp = ds_list_create();
			        ds_list_add(undolisttemp,layerlisttemp);
			        ds_list_add(undolisttemp,objectlist);
			        ds_list_add(undo_list,"d"+string(undolisttemp));
					
					break;
		        }
		    }
			
	        ds_list_clear(somaster_list);
			
	        ds_list_destroy(redolisttemp);
	    }
	    else if (string_char_at(redo,0) == "s")
	    {
	        //redo split
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
	        objectlist = ds_list_find_value(redolisttemp,0);
	        objectlist1 = ds_list_find_value(redolisttemp,1);
	        objectlist2 = ds_list_find_value(redolisttemp,2);
	        if (!ds_list_exists(objectlist1) || !ds_list_exists(objectlist2) || !ds_list_exists(objectlist))
	        {
	            //ds_list_destroy(redolisttemp);
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
					
					undolisttemp = ds_list_create();
	                ds_list_add(undolisttemp, objectlist);
	                ds_list_add(undolisttemp, objectlist1);
	                ds_list_add(undolisttemp, objectlist2);
	                ds_list_add(undo_list, "z"+string(undolisttemp));
	            }
	        }
	        ds_list_destroy(redolisttemp);
	    }
		else if (string_char_at(redo,0) == "z")
	    {
	        //redo merge (only in redo now, opposite of split)
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
	        objectlist = ds_list_find_value(redolisttemp,0);
	        objectlist1 = ds_list_find_value(redolisttemp,1);
	        objectlist2 = ds_list_find_value(redolisttemp,2);
	        if (!ds_list_exists(objectlist1) || !ds_list_exists(objectlist2) || !ds_list_exists(objectlist))
	        {
	            //ds_list_destroy(redolisttemp);
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
					
					undolisttemp = ds_list_create();
	                ds_list_add(undolisttemp, objectlist);
	                ds_list_add(undolisttemp, objectlist1);
	                ds_list_add(undolisttemp, objectlist2);
	                ds_list_add(undo_list, "s"+string(undolisttemp));
	            }
	        }
	        ds_list_destroy(redolisttemp);
	    }
	    else if (string_char_at(redo,0) == "d")
	    {
	        //redo delete object
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
	        objectlist = ds_list_find_value(redolisttemp,1);
	        layerlisttemp = ds_list_find_value(redolisttemp,0);
	        if (!ds_list_exists(layerlisttemp))
	        {
	            //ds_list_destroy(redolisttemp);
	            exit;
	        }
			
			undolisttemp = ds_list_create();
		    ds_list_add(undolisttemp,objectlist);
		    ds_list_add(undo_list,"c"+string(undolisttemp));
            
	        ds_list_add(layerlisttemp,objectlist);
	        ds_list_destroy(redolisttemp);
	    }
	    else if (string_char_at(redo,0) == "r")
	    {
	        //redo resize object
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
	        infolist = redolisttemp[| 0];
	        if (!ds_list_exists(infolist))
	        {
	            //ds_list_destroy(redolisttemp);
	            exit;
	        }
			
			undolisttemp = ds_list_create();
	        ds_list_add(undolisttemp,infolist);
	        ds_list_add(undolisttemp,infolist[| 0]);
	        ds_list_add(undo_list,"r"+string(undolisttemp));
			
	        ds_list_replace(infolist,0,redolisttemp[| 1]);
			
	        ds_list_destroy(redolisttemp);
	    }
	    else if (string_char_at(redo,0) == "m")
	    {
	        //redo move object
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
	        objectlist = ds_list_find_value(redolisttemp,0);
	        layerlisttemp = ds_list_find_value(redolisttemp,1);
	        frametime = ds_list_find_value(redolisttemp,2);
	        if (!ds_list_exists(layerlisttemp) || !ds_list_exists(objectlist))
	        {
	            //ds_list_destroy(redolisttemp);
	            exit;
	        }
            
	        for (j = 0; j < ds_list_size(layer_list); j++)
	        {
	            layertop = layer_list[| j];
	            _layer = layertop[| 1];
	            if (ds_list_find_index(_layer, objectlist) != -1)
	            {
					undolisttemp = ds_list_create();
	                ds_list_add(undolisttemp,objectlist);
	                ds_list_add(undolisttemp,_layer);
	                ds_list_add(undolisttemp,objectlist[| 0]);
					ds_list_add(undo_list,"m"+string(undolisttemp));
					
	                ds_list_delete(_layer, ds_list_find_index(_layer, objectlist));
	                ds_list_replace(objectlist, 0, frametime); 
	                ds_list_add(layerlisttemp, objectlist);
	            }
	        }
	        ds_list_destroy(redolisttemp);
	    }
	    else if (string_char_at(redo,0) == "l")
	    {
	        //redo marker clear
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
				
	        ds_list_add(undo_list,"l"+string(marker_list));
			
	        marker_list = redolisttemp;
	    }
	    else if (string_char_at(redo,0) == "e")
	    {
	        //redo envelope data clear/edit
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
	        if (!ds_list_exists(ds_list_find_value(redolisttemp,2)))
	        {
	            ds_list_destroy( ds_list_find_value(redolisttemp,0) );
	            ds_list_destroy( ds_list_find_value(redolisttemp,1) );
	        }
	        else
	        {
	            var t_selectedenvelope = ds_list_find_value(redolisttemp,2);
				
				var t_undolist = ds_list_create();
				ds_list_add(t_undolist,ds_list_find_value(t_selectedenvelope,1));
				ds_list_add(t_undolist,ds_list_find_value(t_selectedenvelope,2));
				ds_list_add(t_undolist,t_selectedenvelope);
				ds_list_add(undo_list,"e"+string(t_undolist));
				
	            ds_list_replace( t_selectedenvelope,1,ds_list_find_value(redolisttemp,0) );
	            ds_list_replace( t_selectedenvelope,2,ds_list_find_value(redolisttemp,1) );
	        }
	        ds_list_destroy(redolisttemp);
	    }
		else if (string_char_at(redo,0) == "a")
	    {
	        //redo reverse
	        var t_listtoreverse = real(string_digits(redo));
			ds_list_clear(somaster_list);
			ds_list_add(somaster_list, t_listtoreverse);
			reverse_timelineobject(false);
			ds_list_add(undo_list, "a"+string(t_listtoreverse));
	    }
		else if (string_char_at(redo,0) == "k")
	    {
	        //redo create marker
	        var t_markerpos = real(string_digits(redo));
			for (i = 0; i < ds_list_size(marker_list); i++)
			{
				if (marker_list[| i] = t_markerpos)
				{
					ds_list_delete(marker_list, i);
					ds_list_add(undo_list, "j"+string(t_markerpos));
				}
			}
			exit;
		}
		else if (string_char_at(redo,0) == "j")
	    {
	        //redo delete marker
	        var t_markerpos = real(string_digits(redo));
			ds_list_add(marker_list, t_markerpos);
			ds_list_add(undo_list, "k"+string(t_markerpos));
			exit;
		}
		else if (string_char_at(redo,0) == "h")
	    {
	        //redo move marker
	        redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
			var t_markerpos = redolisttemp[| 0];
			for (i = 0; i < ds_list_size(marker_list); i++)
			{
				if (marker_list[| i] = t_markerpos)
					ds_list_delete(marker_list, i);
			}
			t_markerpos = redolisttemp[| 1];
			ds_list_add(marker_list, t_markerpos);
			
			var t_undolist = ds_list_create();
			ds_list_add(t_undolist, redolisttemp[| 1]);
			ds_list_add(t_undolist, redolisttemp[| 0]);
			ds_list_add(undo_list, "h"+string(t_undolist));
			
			ds_list_destroy(redolisttemp);
			exit;
		}
		else if (string_char_at(redo,0) == "p")
	    {
	        //redo create envelope
	        var t_envelopetodelete = real(string_digits(redo));
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
						
						var t_undo_list = ds_list_create();
						ds_list_add(t_undo_list, t_envelopetodelete);
						ds_list_add(t_undo_list, t_envelope_list);
						ds_list_add(undo_list, "x"+string(t_undo_list));
						timeline_surf_length = 0;
						break;
					}
				}
			}
	    }
		else if (string_char_at(redo,0) == "x")
	    {
			// redo delete envelope
			redolisttemp = real(string_digits(redo));
			if (!ds_list_exists(redolisttemp))
	            exit;
				
			var t_envelope = redolisttemp[| 0];
			if (!ds_list_exists(t_envelope))
	            exit;
			var t_layer_envelope_list = redolisttemp[| 1];
			if (!ds_list_exists(t_layer_envelope_list))
	            exit;
				
			ds_list_add(t_layer_envelope_list, t_envelope);
			timeline_surf_length = 0;
			ds_list_add(undo_list, "p"+string(t_envelope));
		}
		else if (string_char_at(redo,0) == "q")
	    {
	        //redo create layer
	        var t_layertodelete = real(string_digits(redo));
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
					ds_list_destroy(t_layertodelete);
					ds_list_delete(layer_list, i);
					timeline_surf_length = 0;
					
					ds_list_add(undo_list, "w");
					
					break;
				}
			}
	    }
		else if (string_char_at(redo,0) == "w")
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
			ds_list_add(undo_list, "q"+string(newlayer));
			timeline_surf_length = 0;
		}
		else if (string_char_at(redo,0) == "g")
	    {
	        // redo duplicate layer
	        selectedlayer = real(string_digits(redo));
			layer_duplicate();
		}
		else
			exit;
    
	    frame_surf_refresh = 1;
	    selectedlayer = 0;
	    selectedx = 0;
	}



}
