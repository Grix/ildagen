///ML_VM_RemVar(parser, key)
/// @argType    r ,s
/// @returnType void
/// @hidden     false
/*
**  Usage:
**      ML_VM_RemVar(parser, key)
**
**  Arguments:
**      parser  parser index
**      key     Key/Pointer to the variable to remove
**
**  Returns:
**
**  Notes:
**      also removes all variables pointing to this entry
*/

var s, v, k, ind;
var VARMAP = _ML_LiP_GetVarMap(argument0);
var P_VARIABLE = _ML_LiP_GetVariableTable(argument0);
s = ds_map_size(P_VARIABLE);
k = argument1;



if (s > 0) {
    v = ds_map_find_first(P_VARIABLE);
    repeat (s) { 
        ind = ds_map_find_value(P_VARIABLE, v);
        if (_ML_Li_GetName(ind) == k) {
            ML_RemVariable(argument0, ind);
        }
        v = ds_map_find_next(P_VARIABLE, v);
    }
}
ds_map_delete(VARMAP, k);

return list;
