if (instance_exists(obj_dropdown))
    exit;
if (!visible) exit;

if (is_undefined(controller.shapefunc_string_x)) controller.shapefunc_string_x = "";

ilda_dialog_string("funcx","Enter function for X coordinate",controller.shapefunc_string_x);


