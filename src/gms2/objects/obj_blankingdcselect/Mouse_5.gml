if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;

ilda_dialog_num("blankdc","Enter the blanking duty cycle",controller.blank_dc);

