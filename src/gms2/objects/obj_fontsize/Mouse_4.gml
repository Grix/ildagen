if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
    exit;

if (mouse_x > (x+23))
    controller.font_size += 2;
else
    controller.font_size -= 2;
if (controller.font_size < 1)
    controller.font_size = 1;
   

