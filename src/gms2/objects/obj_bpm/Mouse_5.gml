if (instance_exists(obj_dropdown))
    exit;
if (!visible)
    exit;
    
ilda_dialog_num("bpm","Enter the number of beats per minute:",controller.bpm);
// todo not implemented in dialog
