/// @description dac_blank_and_center(dac list)
/// @function dac_blank_and_center
/// @param dac list
function dac_blank_and_center() {

	var t_dac = argument[0];

	if (!ds_list_exists_pool(t_dac))
	    exit;
    
	dacwrapper_stop(t_dac[| 0]);
	t_dac[| 6] = false;
	t_dac[| 7] = 0;
	t_dac[| 9] = true;



}
