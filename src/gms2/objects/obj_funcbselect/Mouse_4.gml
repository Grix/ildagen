if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

if (is_undefined(controller.colorfunc_string_3)) controller.colorfunc_string_3 = "";

ilda_dialog_string("func3","Enter function for BLUE channel",controller.colorfunc_string_3);

