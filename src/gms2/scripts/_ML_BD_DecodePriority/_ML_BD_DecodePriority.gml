/// @description _ML_BD_DecodePriority(grid, buffer)
/// @function _ML_BD_DecodePriority
/// @param grid
/// @param  buffer
/// @argType    r, r
/// @returnType void
/// @hidden     true
function _ML_BD_DecodePriority(argument0, argument1) {
	var ds = argument0;
	var b = argument1;
	var s = buffer_get_size(b);

	var value, p;
	var val_type;
	var p_type;


	do {
	    val_type = buffer_read(b, buffer_u8);
	    value = _ML_BD_GetData(b, val_type);
	    if (value[1]) {
	        p_type = buffer_read(b, buffer_u8);
	        p = _ML_BD_GetData(b, p_type);
	        if (p[1]) {
	            ds_priority_add(ds, value[0], p[0]);
	        }
	    }

	} until (!value[1] || !p[1] || buffer_tell(b) == s);



}
