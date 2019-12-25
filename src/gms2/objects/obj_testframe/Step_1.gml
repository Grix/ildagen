if (instance_exists(obj_dropdown))
    exit;
    
if (mouse_x > x+45) and (mouse_x < (x+210)) and (mouse_y > y) and ((mouse_y < y+22))
{
    highlight = 1;
    controller.tooltip = "Choose what to project to preview settings profile if you turn the laser on.";
    
    if (mouse_check_button_pressed(mb_left))
    {
        dropdown_testframe();
    }
} 
else 
    highlight = 0;

