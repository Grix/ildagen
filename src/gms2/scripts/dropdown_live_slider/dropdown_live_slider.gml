// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dropdown_live_slider(){
	
	livecontrol.selected_slider = object_index;
	
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	
	with (ddobj)
	{
	    num = 4;
		ds_list_add(desc_list,"Change MIDI shortcut...");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_live_slider_change_midi_shortcut);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Unbind MIDI shortcut");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_live_slider_unbind_midi_shortcut);
	    ds_list_add(hl_list,1);
		
		var t_dmx_disabled = true;
		if (livecontrol.selected_slider == obj_live_masteralpha)
			t_dmx_disabled = livecontrol.masteralpha_dmx_disable;
		else if (livecontrol.selected_slider == obj_live_masterred)
			t_dmx_disabled = livecontrol.masterred_dmx_disable;
		else if (livecontrol.selected_slider == obj_live_mastergreen)
			t_dmx_disabled = livecontrol.mastergreen_dmx_disable;
		else if (livecontrol.selected_slider == obj_live_masterblue)
			t_dmx_disabled = livecontrol.masterblue_dmx_disable;
		else if (livecontrol.selected_slider == obj_live_masterhue)
			t_dmx_disabled = livecontrol.masterhue_dmx_disable;
		else if (livecontrol.selected_slider == obj_live_masterx)
			t_dmx_disabled = livecontrol.masterx_dmx_disable;
		else if (livecontrol.selected_slider == obj_live_mastery)
			t_dmx_disabled = livecontrol.mastery_dmx_disable;
		else if (livecontrol.selected_slider == obj_live_masterabsrot)
			t_dmx_disabled = livecontrol.masterabsrot_dmx_disable;
		else if (livecontrol.selected_slider == obj_bpm_adjust)
			t_dmx_disabled = livecontrol.speed_adjusted_dmx_disable;
		
		ds_list_add(desc_list,"Toggle DMX input (Currently " + (t_dmx_disabled ? "disabled" : "enabled") + ")");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_live_slider_toggle_dmx_disable);
	    ds_list_add(hl_list,!t_dmx_disabled);
		ds_list_add(desc_list,"Reset to default value");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_live_slider_reset_value);
	    ds_list_add(hl_list,1);
	
	    event_user(1);
	}


}