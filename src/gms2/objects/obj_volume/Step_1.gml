if (instance_exists(obj_dropdown))
    exit;
	
if (moving == 1)
{
	seqcontrol.volume = clamp((mouse_x-bbox_left)/1.28, 0, 100);
	if (keyboard_check_control()) 
		seqcontrol.volume = 100;
    FMODGMS_Chan_Set_Volume(seqcontrol.play_sndchannel,seqcontrol.volume/100);
}
    
visible = (seqcontrol.song != -1);
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the audio volume.";
}