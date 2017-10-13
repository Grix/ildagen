if (instance_exists(obj_dropdown))
    exit;
if (!verify_serial(true))
    exit;
    
with (seqcontrol)
    load_audio();

