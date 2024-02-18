if (instance_exists(obj_dropdown))
    exit;
	
visible = (controller.placing == "text");
if (!visible)
    exit;
    
if (mouse_x > x+70) and (mouse_x < (x+300)) and (mouse_y > y) and ((mouse_y < y+22))
{
    highlight = 1;
    controller.tooltip = "Click to choose the font for the text tool.\nYou can also right click and choose 'Load custom font' to browse for a custom LaserBoy font file.";
    
    if (mouse_check_button_pressed(mb_left))
        dropdown_font_selector();
	else if (mouse_check_button_pressed(mb_right))
		dropdown_text();
} 
else 
    highlight = 0;

