ds_stack_push(controller.undo_list,"r"+string(controller.resolution))

controller.resolution = get_integer("Enter point density (detail level) of new objects. Lower looks better but is slower.",controller.resolution);
if (controller.resolution < 4) controller.resolution = 4;
if (controller.resolution > $8000) controller.resolution = $8000;