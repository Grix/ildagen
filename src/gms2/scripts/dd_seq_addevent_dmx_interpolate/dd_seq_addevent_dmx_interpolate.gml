// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_seq_addevent_dmx_interpolate(){
	if (seqcontrol.selectedlayer == -1 || seqcontrol.selectedx < 0)
    {
        show_message_new("Please select an empty position on the timeline first.");
        exit;
    }    
	
	with (seqcontrol)
	{
		selectedlayerlist = ds_list_find_value(layer_list,selectedlayer);
	
		seq_add_dmx_interpolate_event(seqcontrol.tlpos, selectedlayerlist, 1, 0, 255);
	}
}