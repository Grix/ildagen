///_ML_BD_DecodeMap(map, buffer)
/// @argType    r, r
/// @returnType void
/// @hidden     true
var ds = argument0;
var b = argument1;
var s = buffer_get_size(b);

var val;
var val_type;
var key;
var key_type;


do {
    key_type = buffer_read(b, buffer_u8);
    key = _ML_BD_GetData(b, key_type);

    if (key[1]) {
        val_type = buffer_read(b, buffer_u8);
        val = _ML_BD_GetData(b, val_type);
        if (val[1]) {
            ds_map_add(ds, key[0], val[0]);
        }
    }

} until (buffer_tell(b) == s || !key[1] || !val[1]);



