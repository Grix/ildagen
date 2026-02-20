// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dropdown_seq_slider(){
	
	seqcontrol.selected_slider = object_index;
	
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	
	with (ddobj)
	{
	    num = 4;
		ds_list_add(desc_list,"Change MIDI shortcut...");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_slider_change_midi_shortcut);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Unbind MIDI shortcut");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_slider_unbind_midi_shortcut);
	    ds_list_add(hl_list,1);
		
		var t_dmx_disabled = true;
		if (seqcontrol.selected_slider == obj_tl_intensity_scale)
			t_dmx_disabled = seqcontrol.masteralpha_dmx_disable;
		
		ds_list_add(desc_list,"Toggle DMX input (Currently " + (t_dmx_disabled ? "disabled" : "enabled") + ")");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_seq_slider_toggle_dmx_disable);
	    ds_list_add(hl_list,!t_dmx_disabled);
		
	    ds_list_add(desc_list,"Reset to default value");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_slider_reset_value);
	    ds_list_add(hl_list,1);
	
	    event_user(1);
	}


}