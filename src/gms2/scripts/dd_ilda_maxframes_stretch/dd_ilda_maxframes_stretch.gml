function dd_ilda_maxframes_stretch() 
{
	if (controller.use_bpm)
		ilda_dialog_num("maxframes_stretch","Enter the new duration of the animation, in number of beats (at "+string(controller.bpm)+" BPM). Will stretch the current animation to fit. Warning: Cannot be undone automatically.",(controller.maxframes / controller.projectfps) * (controller.bpm / 60));
	else
		ilda_dialog_num("maxframes_stretch","Enter the new duration of the animation, in number of frames (at "+string(controller.projectfps)+" FPS). Will stretch the current animation to fit. Warning: Cannot be undone automatically.",controller.maxframes);

}
