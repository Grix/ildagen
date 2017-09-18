if (instance_exists(oDropDown))
    exit;
if (!verify_serial(true))
    exit;
    
with (seqcontrol)
{
    load_audio();
}

