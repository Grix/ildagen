if (instance_exists(obj_dropdown))
    exit;
if (room = rm_ilda)
{
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
        image_index = 1;
        controller.tooltip = "Click here to open the full manual. Keyboard controls:##"+
        "Mouse)    Select drawing tool and draw#"+
        "Enter)    Remake selected object, or finalize curve#"+
        "Left/Right Arrows)    Go to previous/next frame#"+
        "Space)    Play/Pause#"+
        "Ctrl+Mouse)    Select object#"+
        "Tab)    Enter timeline mode#"+
        "I)    Send frames from editor mode to timeline mode#"+
        "Delete)    Delete selected object#"+
        "P)    Toggle 3D frame previewing#"+
        "Shift)    Force horizontal or vertical lines when drawing#"+
        "Q)    Snap cursor to the nearest tip of object#"+
        "Alt)    Snap mouse to ending position of last element for chaining#"+
        "Ctrl+Alt)    Snap mouse to starting position of last element for chaining##"+
        "A)    Show symmetry/alignment guidelines of elements#"+
        "S)    Show/Snap to square grid (Double click to toggle)#"+
        "S+Up/Down Key)    Resize square grid#"+
        "R)    Show radial grid (Double click to toggle)#"+
        "Z)    Zoom in around the cursor#"+
        "E)    Clone color from background image#"+
        "H)    Highlight all objects#"+
        "Ctrl)    Move all color sliders, or center symmetric sliders#"+
        "Ctrl+Z)    Undo#"+
        "Ctrl+C)    Copy selected objects#"+
        "Ctrl+X)    Cut selected objects#"+
        "Ctrl+V)    Paste#"+
        "Esc)    Stop laser DAC output#"+
        "Backspace)    Cancel object placing and selection#"+
        "0)    Jump to first frame#"+
        "Mouse wheel)    Adjust wave amplitude#"+
        "Ctrl+Mouse wheel)    Adjust wave frequency##"+
        "M)    Reset window size#"+
        "F11)    Toggle fullscreen";
    } 
    else image_index = 0;
}
else if (room = rm_seq)
{
    if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
    {
        image_index = 1;
        controller.tooltip = "Click here to open the full manual. Keyboard controls:##"+
        "Mouse)    Select object or time on timeline (Ctrl to select multiple)#"+
        "Left/Right Arrows)    Cycle between frames#"+
        "Space)    Play/Pause#"+
        "Tab)    Enter frame editor mode#"+
        "I)    Send frames from editor mode to timeline mode#"+
        "L)    Insert marker on timeline#"+
        "P)    Toggle 3D frame previewing#"+
        "D)    Hold to delete points in envelopes when dragging mouse##"+
        "Delete)    Delete selected object#"+
        "Ctrl+Z)    Undo#"+
        "Ctrl+C)    Copy selected objects#"+
        "Ctrl+X)    Cut selected objects#"+
        "Ctrl+V)    Paste#"+
        "S)    Split selected object at playback cursor position#"+
        "Esc)    Stop laser DAC output#"+
        "0)    Jump to first frame#"+
        "Mouse wheel or F7/F8)    Scroll/Zoom (where applicable)##"+
        "M)    Reset window size#"+
        "F11)    Toggle fullscreen#"+
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



