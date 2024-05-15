function dd_scope_end() 
{
	if (controller.use_bpm) 
		ilda_dialog_num("scopeend","Enter the ending beat of the editing scope, between "+string(((controller.scope_start) / controller.projectfps) * (controller.bpm / 60))+" and "+string(((controller.maxframes) / controller.projectfps) * (controller.bpm / 60)), ((controller.frame+1) / controller.projectfps) * (controller.bpm / 60));
	else
		ilda_dialog_num("scopeend","Enter the ending frame of the editing scope, between "+string(controller.scope_start+2)+" and "+string(controller.maxframes),controller.frame+1);



}
