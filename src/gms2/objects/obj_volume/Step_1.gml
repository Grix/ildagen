if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    seqcontrol.volume += (mouse_x-mouse_xprevious)/1.28;
    if (seqcontrol.volume  < 0) seqcontrol.volume = 0;
    if (seqcontrol.volume > 100) seqcontrol.volume = 100;
    FMODGMS_Chan_Set_Volume(seqcontrol.play_sndchannel,seqcontrol.volume/100);
}
    
visible = (seqcontrol.song != 0);
if (!visible)
    exit;
    
mouse_xprevious = mouse_x;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the audio volume.";
}

