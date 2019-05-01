if (instance_exists(obj_dropdown))
    exit;
if (room = rm_ilda)
{
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
        image_index = 1;
        controller.tooltip = "Click here to open the full manual. Keyboard controls:\n\n"+
        "Mouse)    Select drawing tool and draw\n"+
        "Enter)    Remake selected object, or finalize curve\n"+
        "Left/Right Arrows)    Go to previous/next frame\n"+
        "Space)    Play/Pause\n"+
        "Ctrl+Mouse)    Select object\n"+
        "Tab)    Enter timeline mode\n"+
        "I)    Send frames from editor mode to timeline mode\n"+
		"L)    Send frames from editor mode to live mode\n"+
        "Delete)    Delete selected object\n"+
        "P)    Toggle 3D frame previewing\n"+
        "Shift)    Force horizontal or vertical lines when drawing\n"+
        "Q)    Snap cursor to the nearest tip of object\n"+
        "Alt)    Snap mouse to ending position of last element for chaining\n"+
        "Ctrl+Alt)    Snap mouse to starting position of last element for chaining\n\n"+
        "A)    Show symmetry/alignment guidelines of elements\n"+
        "S)    Show/Snap to square grid (Double click to toggle)\n"+
        "S+Up/Down Key)    Resize square grid\n"+
        "R)    Show radial grid (Double click to toggle)\n"+
        "Z)    Zoom in around the cursor\n"+
        "E)    Clone color from background image\n"+
        "H)    Highlight all objects\n"+
        "Ctrl)    Move all color sliders, or center symmetric sliders\n"+
        "Ctrl+Z)    Undo\n"+
        "Ctrl+C)    Copy selected objects\n"+
        "Ctrl+X)    Cut selected objects\n"+
        "Ctrl+V)    Paste\n"+
        "Esc)    Stop laser DAC output\n"+
        "Backspace)    Cancel object placing and selection\n"+
        "0)    Jump to first frame\n"+
        "Mouse wheel)    Adjust wave amplitude\n"+
        "Ctrl+Mouse wheel)    Adjust wave frequency\n\n"+
        "M)    Reset window size\n"+
        "F11)    Toggle fullscreen";
    } 
    else image_index = 0;
}
else if (room = rm_seq)
{
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
        image_index = 1;
        controller.tooltip = "Click here to open the full manual. Keyboard controls:\n\n"+
        "Mouse)    Select object or time on timeline (Ctrl to select multiple)\n"+
        "Left/Right Arrows)    Cycle between frames\n"+
        "Space)    Play/Pause\n"+
        "Tab)    Enter frame editor mode\n"+
        "I)    Send frames from editor mode to timeline mode\n"+
        "L)    Insert marker on timeline\n"+
        "P)    Toggle 3D frame previewing\n"+
        "D)    Hold to delete points in envelopes when dragging mouse\n\n"+
        "Delete)    Delete selected object\n"+
        "Ctrl+Z)    Undo\n"+
        "Ctrl+C)    Copy selected objects\n"+
        "Ctrl+X)    Cut selected objects\n"+
        "Ctrl+V)    Paste\n"+
		"R)    Reverse selected object\n"+
        "S)    Split selected object at playback cursor position\n\n"+
		"Ctrl+S)    Save project\n"+
        "Esc)    Stop laser DAC output\n"+
        "0)    Jump to first frame\n"+
        "Mouse wheel or F7/F8)    Scroll/Zoom (where applicable)\n\n"+
        "M)    Reset window size\n"+
        "F11)    Toggle fullscreen\n"+
        "F1)    Show manual";
    } 
    else image_index = 0;
}
else
{
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
        controller.tooltip = "Click here to open the full manual.";
        image_index = 1;
    }
    else
        image_index = 0;
}



