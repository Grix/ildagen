if !keyboard_check(vk_control) or (!verify_serial(true))
    exit;

with (livecontrol) 
{
    save_live_project_quick();
}

