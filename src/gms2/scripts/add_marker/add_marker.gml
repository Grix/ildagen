/// @description add_marker(position in frames)
/// @function add_marker
/// @param position in frames
function add_marker(argument0) {

	if (ds_list_find_index(seqcontrol.marker_list,argument0) == -1)
	    ds_list_add(seqcontrol.marker_list,argument0);

	ds_list_add(seqcontrol.undo_list, "k"+string(argument0));

}
