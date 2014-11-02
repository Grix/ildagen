ds_stack_push(controller.undo_list,"x"+string(controller.shaking_sdev))

controller.shaking_sdev = get_integer("Enter the standard deviation of the shaking offset in pixels. Higher value is stronger.",controller.shaking_sdev);
if (controller.shaking_sdev < 0.1) controller.shaking_sdev = 0.1;
if (controller.shaking_sdev > 512) controller.shaking_sdev = 512;
