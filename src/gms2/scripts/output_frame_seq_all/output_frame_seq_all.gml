/// @description output_frame_seq_all()
/// @function output_frame_seq_all
function output_frame_seq_all() {

	if (debug_mode)
	{
	    log("outputted frame seq ", tlpos/(1000/projectfps), controller.fpsmultiplier, delta_time/1000);
		if ((round(tlpos/projectfps*1000) != frameprev+1*controller.fpsmultiplier) && controller.playing)
			log("Skipped frame!!");
	}

	for (n = 0; n < ds_list_size(controller.dac_list); n++)
	{
	    var t_dac = controller.dac_list[| n];
		
		//log("DAC: " + string(n) + ": " + string(t_dac[| 8]));
		
		if (t_dac[| 8] == false) // whether is used
			continue;
			
	    output_frame_seq(t_dac);
	}

	load_profile(1);



}
