if (instance_exists(oDropDown))
    exit;
if (!visible)
    exit;

if (mouse_x < (x+23*1.5))
    controller.blankmode2 = 1;
else
    controller.blankmode2 = 0;

