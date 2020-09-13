/// @description output_frame_seq_all()
/// @function output_frame_seq_all
function output_frame_seq_all() {

	for (n = 0; n < ds_list_size(controller.dac_list); n++)
	{
	    var t_dac = controller.dac_list[| n];
	    output_frame_seq(t_dac);
	    //minroomspeed = max(projectfps,10); 
	}

	load_profile(1);



}
