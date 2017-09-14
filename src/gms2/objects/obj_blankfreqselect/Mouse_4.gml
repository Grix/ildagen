if (instance_exists(oDropDown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
    controller.blank_freq += 0.5;
else
    controller.blank_freq -=0.5;
if (controller.blank_freq < 0.5)
    controller.blank_freq = 0.5;


