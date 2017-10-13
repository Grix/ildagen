if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

if (mouse_x < (x+23*1.5))
    controller.colormode2 = 1;
else
    controller.colormode2 = 0;


