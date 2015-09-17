///_ML_BD_DecodeGrid(grid, buffer)
/// @argType    r, r
/// @returnType void
/// @hidden     true
var ds = argument0;
var b = argument1;

var w = buffer_read(b, buffer_u32);
var h = buffer_read(b, buffer_u32);

ds_grid_resize(ds, w, h);

var val_type, value;
for (var j = 0; j < h; ++j) {
    for (var i = 0; i < w; ++i) {
        val_type = buffer_read(b, buffer_u8);
        value = _ML_BD_GetData(b, val_type);
        ds_grid_set(ds, i, j , value[0]);
    }
}
