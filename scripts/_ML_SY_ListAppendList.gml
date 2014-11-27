///_ML_SY_ListAppendList(q1, q2);
/// @argType    r,r
/// @returnType void
/// @hidden     true
//appends q2 to q1

var q1, q2;
q1 = argument0;
q2 = argument1;
var ind = 0;
repeat (ds_list_size(q2)) {
    ds_list_add(q1, ds_list_find_value(q2, ind++));
}
