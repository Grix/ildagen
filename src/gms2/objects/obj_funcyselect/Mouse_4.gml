if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

if (is_undefined(controller.shapefunc_string_y)) controller.shapefunc_string_y = "";

ilda_dialog_string("funcy","Enter function for Y coordinate",controller.shapefunc_string_y);


