if (instance_exists(oDropDown))
    exit;
if (!visible)
    exit;

ilda_dialog_num("shaking_sdevset","Enter the shaking instensity",controller.shaking_sdev);

