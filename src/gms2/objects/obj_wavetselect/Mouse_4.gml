if (instance_exists(oDropDown))
    exit;
if (!visible)
    exit;

if (mouse_x > (x+23))
    controller.wave_period += 0.5;
else
    controller.wave_period -= 0.5;
if (controller.wave_period < 0.5)
    controller.wave_period = 0.5;


