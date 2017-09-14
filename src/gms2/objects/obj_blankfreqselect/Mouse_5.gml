if (instance_exists(oDropDown))
    exit;
if (!visible)
    exit;

ilda_dialog_num("blankfreq","Enter the blanking frequency",controller.blank_freq);

