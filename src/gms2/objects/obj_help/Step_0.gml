if (instance_exists(obj_dropdown))
    exit;
if (room == rm_ilda)
{
    if (keyboard_check_control() && keyboard_check(vk_f1)) || ((mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom)))
    {
        image_index = 1;
        controller.tooltip = "Click here to open the full manual. Keyboard controls:\n\n"+
        "Mouse)    Select drawing tool and draw\n"+
        "Enter)    Remake selected object, or finalize curve\n"+
        "Left/Right Arrows)    Go to previous/next frame\n"+
        "Space)    Play/Pause\n"+
        ""+get_ctrl_string()+" + Mouse click)    Select object\n"+
        "Tab)    Enter timeline mode\n"+
        "I)    Send frames from editor mode to timeline mode\n"+
		"L)    Send frames from editor mode to the grid view\n"+
        ""+get_delete_string()+")    Delete selected object\n"+
        "P)    Toggle 3D frame previewing\n"+
        "Shift)    Force horizontal or vertical lines when drawing\n"+
        "Q)    Snap cursor to the nearest tip of object\n"+
        "Alt)    Snap mouse to ending position of last element for chaining\n"+
        ""+get_ctrl_string()+"+Alt)    Snap mouse to starting position of last element for chaining\n\n"+
        "A)    Show symmetry/alignment guidelines of elements\n"+
        "S)    Show/Snap to square grid (Double click to toggle)\n"+
        "S+Up/Down Key)    Resize square grid\n"+
        "R)    Show radial grid (Double click to toggle)\n"+
        "Z)    Zoom in around the cursor\n"+
        "E)    Clone color from background image\n"+
        "H)    Highlight all objects\n"+
        ""+get_ctrl_string()+")    Move all color sliders, or center symmetric sliders\n"+
        ""+get_ctrl_string()+"+Z)    Undo\n"+
		""+get_ctrl_string()+"+Y)    Redo\n"+
        ""+get_ctrl_string()+"+C)    Copy selected objects\n"+
        ""+get_ctrl_string()+"+X)    Cut selected objects\n"+
        ""+get_ctrl_string()+"+V)    Paste\n"+
		"U)    Toggle laser DAC output\n"+
        "Esc)    Turn off laser DAC output\n"+
        "Backspace)    Cancel object placing and selection\n"+
        "0)    Jump to first frame\n"+
        "Mouse wheel)    Adjust wave amplitude\n"+
        ""+get_ctrl_string()+"+Mouse wheel)    Adjust wave frequency\n\n"+
        "M)    Reset window size\n"+
        "F11)    Toggle fullscreen";
    } 
    else image_index = 0;
}
else if (room == rm_seq)
{
    if (keyboard_check_control() && keyboard_check(vk_f1)) || ((mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom)))
    {
        image_index = 1;
        controller.tooltip = "Click here to open the full manual. Keyboard controls:\n\n"+
        "Mouse)    Select object or time on timeline ("+get_ctrl_string()+" to select multiple)\n"+
		""+get_ctrl_string()+" + Mouse click)    Select multiple objects on timeline\n"+
		""+get_ctrl_string()+" + Mouse drag)    Drag timeline to scroll (horizontally or vertically)\n"+
        "Left/Right Arrows)    Go to next/previous frame\n"+
        "Space)    Play/Pause\n"+
        "Tab)    Enter frame editor mode\n"+
        "I)    Send frames from editor mode to timeline mode\n"+
        "L)    Insert marker on timeline\n"+
        "P)    Toggle 3D frame previewing\n"+
        "D)    Hold to delete points in envelopes when dragging mouse\n"+
		"J)    Create a jump point (where you can press a button to jump to this timeline position)\n\n"+
		""+get_ctrl_string()+"+1)    Set start positione\n"+
		""+get_ctrl_string()+"+2)    Set end position\n\n"+
        ""+get_delete_string()+")    Delete selected object\n"+
        ""+get_ctrl_string()+"+Z)    Undo\n"+
		""+get_ctrl_string()+"+Y)    Redo\n"+
        ""+get_ctrl_string()+"+C)    Copy selected objects\n"+
        ""+get_ctrl_string()+"+X)    Cut selected objects\n"+
        ""+get_ctrl_string()+"+V)    Paste\n"+
		"R)    Reverse selected object\n"+
        "S)    Split selected object at playback cursor position\n\n"+
		""+get_ctrl_string()+"+S)    Save project\n"+
		"U)    Toggle laser DAC output\n"+
        "Esc)    Turn off laser DAC output\n"+
        "0)    Jump to first frame\n"+
        "Mouse wheel or F7/F8)    Zoom in timeline\n\n"+
        "Shift + Mouse wheel or F7/F8)    Scroll horizontally in timeline\n\n"+
        "M)    Reset window size\n"+
        "F11)    Toggle fullscreen\n"+
        "F1)    Show manual\n" +
		""+get_ctrl_string()+"+F1)   Show this keyboard shortcut tooltip.";
    } 
    else image_index = 0;
}
else if (room == rm_live)
{
     if (keyboard_check_control() && keyboard_check(vk_f1)) || ((mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom)))
    {
        image_index = 1;
        controller.tooltip = "Click here to open the full manual. Keyboard controls:\n\n"+
        "Mouse)    Select file\n"+
        "Space)    Play/Pause\n"+
		"0)    Pause and reset position of all objects\n" +
        "Tab)    Enter editor mode\n"+
		"L)    Send frames from editor mode to the grid view\n"+
        "I)    Send the selected frames from the grid view to the timeline mode\n"+
        ""+get_delete_string()+")    Delete selected object\n"+
		"X)    Toggle exclusive playback of selected object\n"+
		"O)    Toggle looping of selected object\n"+
		"R)    Toggle restarting/resuming when playing selected object\n"+
		"H)    Toggle whether to push and hold to play or toggle playing in selected object\n"+
        "P)    Toggle 3D frame previewing\n"+
        ""+get_ctrl_string()+"+Z)    Undo\n"+
		""+get_ctrl_string()+"+Y)    Redo\n"+
		"U)    Toggle laser DAC output\n"+
        "Esc)    Turn off laser DAC output\n\n"+
        "M)    Reset window size\n"+
        "F11)    Toggle fullscreen\n" +
        "F1)    Show manual\n" +
		""+get_ctrl_string()+"+F1)   Show this keyboard shortcut tooltip.";
    } 
    else image_index = 0;
}
else
{
     if (keyboard_check_control() && keyboard_check(vk_f1)) || ((mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom)))
    {
        controller.tooltip = "Click here to open the full manual.";
        image_index = 1;
    }
    else
        image_index = 0;
}



