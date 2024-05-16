if (instance_exists(obj_dropdown))
    exit;
	
if (!visible)
	exit;	

if (mouse_x > (x+23))
    seqcontrol.beats_shift += 0.1;
else
    seqcontrol.beats_shift -= 0.1;

stringToDraw = "Beat offset: "+string_format(seqcontrol.beats_shift,3,2);
seqcontrol.timeline_surf_length = 0;