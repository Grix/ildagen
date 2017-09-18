if !keyboard_check(vk_control) or (!verify_serial(true))
    exit;

with (seqcontrol) 
{
    save_project();
}

