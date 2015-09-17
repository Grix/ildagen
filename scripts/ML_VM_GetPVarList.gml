///ML_VM_GetPVarList(parser, key)
/// @argType    r,r 
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_VM_GetPVarList(parser, key)
**
**  Arguments:
**      parser  parser index
**      key     key/pointer to check for
**
**  Returns:
**      ds_list containing id of all variables pointing to "key"
**
**  Notes:
**      - Creates list, you are responsible for destroying the list
**
**  Notes:
*/

var s, list, v, k, ind;
var P_VARIABLE =  _ML_LiP_GetVariableTable(argument0);
s = ds_map_size(P_VARIABLE);
list = ds_list_create();
k = argument1;

if (s > 0) {
    v = ds_map_find_first(P_VARIABLE);
    repeat (s) { 
        ind = ds_map_find_value(P_VARIABLE, v);
        if (_ML_Li_GetName(ind) == k) {
            ds_list_add(list, ind);
        }
        v = ds_map_find_next(P_VARIABLE, v);
    }
}


return list;
