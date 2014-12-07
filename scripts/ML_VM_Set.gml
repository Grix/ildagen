///ML_VM_Set(parser, VarMap, [CreateNewVars] )
/// @argType    r, r, r
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_VM_Set(parser, VarMap, [CreateNewVars] )
**
**  Arguments:
**      parser          parser index
**      VarMap          Map containing [Variable; Value] pairs (where Variable is a string)
**      CreateNewVars   Whether to create new variables based on the new map
**                          varstring = key (in VarMap)
**                          value = value (in VarMap)
**                          type = type of value (in VarMap)
**                          readonly = true
**                      Default to not create new vars
**
**  Returns:
**      VarMap id
**
**  Notes:
**      - Does NOT take ownership of the map, destroying keeps responsibility of the user
**      - Destroys all created variables in the parser
**      - Normally not called by the user (as varmap is initialized at creation of the parser)
*/
var parser = argument[0];
ML_ClearVariable(parser)
var VARMAP = _ML_LiP_GetVarMap(parser);
if (VARMAP != -1) ds_map_destroy(VARMAP);
VARMAP = argument[1];


if (argument_count > 1) {
    if (argument[2]) {    
        var s;
        s = ds_map_size(VARMAP);
        if (s > 0) {
            var str, value, type;
            str = ds_map_find_first(VARMAP);
            repeat (s) { 
                value = ds_map_find_value(VARMAP, str);
                if (is_real(value)) {
                    type = ML_VAL_REAL;
                } else {
                    type = ML_VAL_STRING;
                }
                ML_AddVariable(parser, str, value, type, true)
                str = ds_map_find_next(VARMAP, v);
            }
        }
    }
}

_ML_LiP_SetVarMap(parser, VARMAP);
return VARMAP;