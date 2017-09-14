if (instance_exists(oDropDown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
    controller.color_freq += 0.5;
else
    controller.color_freq -= 0.5;
if (controller.color_freq < 0.5)
    controller.color_freq = 0.5;


