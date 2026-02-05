if (instance_exists(obj_dropdown))
    exit;


controller.enable_artnet = !controller.enable_artnet;
if (controller.enable_artnet)
	controller.enable_sacn = false;
	
dacwrapper_dmx_setenable(controller.enable_artnet, controller.enable_artnet);