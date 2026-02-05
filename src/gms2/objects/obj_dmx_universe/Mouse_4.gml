if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
	exit;

if (!is_real(controller.dmx_universe)) 
	controller.dmx_universe = 1;

ilda_dialog_num("dmx_universe","Enter the sACN/Art-Net DMX universe number to listen on (Between 0 and 65535).",controller.dmx_universe);

