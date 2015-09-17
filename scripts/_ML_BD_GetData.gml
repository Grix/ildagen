///_ML_BD_GetData(buffer, type)
/// @argType    r, r
/// @returnType array
/// @hidden     true


var ret;
ret[0] = 0;
ret[1] = true;
var b = argument0;
var type = argument1;
var offset = buffer_tell(b);


if (type < $80) {
    ret[0] = buffer_read(b, type);
} else {
    switch (type) {
    case ds_type_list + $80:
        ret[0] = ds_list_create();
        _ML_BD_DecodeList(ret[0], b);
    break;
    case ds_type_priority + $80:
        ret[0] = ds_priority_create();
        _ML_BD_DecodePriority(ret[0], b);
    break;
    case ds_type_stack + $80:
        ret[0] = ds_stack_create();
        _ML_BD_DecodeStack(ret[0], b);
    break;
    case ds_type_queue + $80:
        ret[0] = ds_queue_create();
        _ML_BD_DecodeQueue(ret[0], b);
    break;
    case ds_type_map + $80:
        ret[0] = ds_map_create();
        _ML_BD_DecodeMap(ret[0], b);
    break;
    case ds_type_grid + $80:
        ret[0] = ds_grid_create(0,0);
        _ML_BD_DecodeGrid(ret[0], b);
    break;
    case $C1:
        ret[0] = _ML_LiTok_Create("", 0);
        _ML_LiTok_FromBuff(ret[0], b);
    default: 
        ret[1] = false;
    break;
    }
}
return ret;
