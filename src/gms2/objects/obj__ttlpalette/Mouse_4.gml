if (instance_exists(obj_dropdown))
    exit;
if (!visible)
	exit;
	
controller.ttlpalette = !controller.ttlpalette;

if (controller.ttlpalette == 0)
	controller.pal_list = controller.pal_list_ilda;
else
	controller.pal_list = controller.pal_list_ttl;

save_profile();

