function dd_ilda_maxframes() {
	if (controller.use_bpm)
		ilda_dialog_num("maxframes","Enter the new duration of the animation, in number of beats (at "+string(controller.bpm)+" BPM). Will pad or cut off the end. Warning: Cannot be undone automatically.",(controller.maxframes / controller.projectfps) * (controller.bpm / 60));
	else
		ilda_dialog_num("maxframes","Enter the new duration of the animation, in number of frames (at "+string(controller.projectfps)+" FPS). Will pad or cut off the end. Warning: Cannot be undone automatically.",controller.maxframes);



}
