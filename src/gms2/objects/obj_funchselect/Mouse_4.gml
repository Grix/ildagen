if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

if (is_undefined(controller.colorfunc_string_1)) controller.colorfunc_string_1 = "";

ilda_dialog_string("func1","Enter function for HUE channel",controller.colorfunc_string_1);


