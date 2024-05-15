function dd_scope_start() {
	
	if (controller.use_bpm) 
		ilda_dialog_num("scopestart","Enter the starting beat of the editing scope, between 0 and "+string(((controller.scope_end) / controller.projectfps) * (controller.bpm / 60)), ((controller.frame+1) / controller.projectfps) * (controller.bpm / 60));
	else
		ilda_dialog_num("scopestart","Enter the starting frame of the editing scope, between 0 and "+string(controller.scope_end),controller.frame+1);
		

}
