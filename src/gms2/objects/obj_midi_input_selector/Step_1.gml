if (instance_exists(obj_dropdown))
    exit;
    
if (mouse_x > x+80) and (mouse_x < (x+290)) and (mouse_y > y) and ((mouse_y < y+22))
{
    highlight = 1;
    controller.tooltip = "Choose which connected MIDI device to use for input (triggers, knobs etc).";
    
    if (mouse_check_button_pressed(mb_left))
    {
        dropdown_midi_input_selector();
    }
} 
else 
    highlight = 0;

