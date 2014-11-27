///_ML_BD_DecodeList(list, buffer)
/// @argType    r, r
/// @returnType void
/// @hidden     true
var list = argument0;
var b = argument1;
var s = buffer_get_size(b);

var value;
var val_type;
var v;

do {
    val_type = buffer_read(b, buffer_u8);
    value = _ML_BD_GetData(b, val_type);
    if (value[1]) {
        ds_list_add(list, value[0]);
    }


} until (!value[1] || buffer_tell(b) == s);

