///ML_VM_HasNoPVar(parser, key)
/// @argType    r, r
/// @returnType real
/// @hidden     false


/*
**  Usage:
**      ML_VM_HasNoPVar(parser, key)
**
**  Arguments:
**      parser  parser index
**      key     key/pointer to check for
**
**  Returns:
**      Whether there exists any variable pointing to "key"
**
**  Notes:
*/

var s, v, k, ind;
var P_VARIABLE = _ML_LiP_GetVariableTable(argument0);
s = ds_map_size(P_VARIABLE);
k = argument1;

if (s > 0) {
    v = ds_map_find_first(P_VARIABLE);
    repeat (s) { 
        ind = ds_map_find_value(P_VARIABLE, v);
        if (_ML_Li_GetName(ind) == k) {
            return true;
        }
        v = ds_map_find_next(P_VARIABLE, v);
    }
}


return false;
