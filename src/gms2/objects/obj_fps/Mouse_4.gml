if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

ilda_dialog_num("fps","Enter number of frames per second",seqcontrol.projectfps);
