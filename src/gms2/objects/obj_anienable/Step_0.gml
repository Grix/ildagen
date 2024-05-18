if (instance_exists(obj_dropdown))
    exit;
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Enables/disables animation.\nIf animation is enabled, properties like color and movement will gradually change from the start to the end of the editing scope.";
} 

