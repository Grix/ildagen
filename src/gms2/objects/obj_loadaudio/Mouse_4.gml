if (instance_exists(oDropDown))
    exit;
if (!verify_serial())
    exit;
    
with (seqcontrol)
{
    load_audio();
}

