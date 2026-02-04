if (instance_exists(obj_dropdown))
    exit;
    
if (mouse_x > x+80) and (mouse_x < (x+290)) and (mouse_y > y) and ((mouse_y < y+22))
{
    highlight = 1;
    controller.tooltip = "Choose which network interface to use for receiving Art-Net or sACN DMX data.";
    
    if (mouse_check_button_pressed(mb_left))
    {
        dropdown_dmx_interface_selector();
    }
} 
else 
    highlight = 0;

