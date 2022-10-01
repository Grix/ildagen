if (instance_exists(obj_dropdown))
    exit;

controller.warning_disable = !controller.warning_disable;

if (controller.warning_disable)
	show_message_new("NB: This will disable various confirmation message before non-undoable actions, meaning that you may accidentally make unrecoverable mistakes!");

save_profile();

