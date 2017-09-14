if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

if (is_undefined(controller.colorfunc_string_2)) controller.colorfunc_string_2 = "";

ilda_dialog_string("func2","Enter function for SATURATION channel",controller.colorfunc_string_2);


