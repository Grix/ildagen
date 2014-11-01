ds_stack_push(controller.undo_list,"d"+string(controller.dotmultiply))

controller.dotmultiply = get_integer("Enter the intensity/brightness (amount of overlapping points) per dot. Higher value make dots brighter.",controller.dotmultiply);
if (controller.dotmultiply < 1) controller.dotmultiply = 1;
if (controller.dotmultiply > 32) controller.dotmultiply = 32;
