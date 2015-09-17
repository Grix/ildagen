/// _ML_BD_DecodeStack(grid, buffer)
/// @argType    r, r
/// @returnType void
/// @hidden     true
var ds = argument0;
var b = argument1;
var s = buffer_get_size(b);

var value;
var val_type;


do {
    val_type = buffer_read(b, buffer_u8);
    value = _ML_BD_GetData(b, val_type);
    if (value[1]) {
        ds_stack_push(ds, value[0]);
    }

} until (!value[1] || buffer_tell(b) == s);
