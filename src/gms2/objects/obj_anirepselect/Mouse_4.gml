if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
    controller.anirep += 1;
else
    controller.anirep -= 1;
if (controller.anirep < 1)
    controller.anirep = 1;


