if (instance_exists(obj_dropdown))
    exit;

controller.enable_sacn = !controller.enable_sacn;
if (controller.enable_sacn)
	controller.enable_artnet = false;
	
dacwrapper_dmx_setenable(controller.enable_artnet, controller.enable_artnet);
