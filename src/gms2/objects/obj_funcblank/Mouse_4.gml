if (instance_exists(obj_dropdown))
    exit;
if (!visible) 
	exit;

if (is_undefined(controller.blankfunc_string)) 
	controller.blankfunc_string = "";

ilda_dialog_string("funcen","Enter function for the blanking",controller.blankfunc_string);


