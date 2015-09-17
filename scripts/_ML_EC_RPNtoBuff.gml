///_ML_EC_RPNtoBuff(buffer, queue_source)
/// @argType    r, r
/// @returnType void
/// @hidden     true

var buffer = argument0;
var source = argument1;
var rpn = ds_queue_create();
ds_queue_copy(rpn, source);
var s = ds_queue_size(rpn);

var tok;

buffer_write(b, buffer_u8, ds_type_queue);

repeat (s) {
    tok = ds_queue_dequeue(rpn);   
    
    buffer_write(b,buffer_u8, $C1);
    _ML_LiTok_ToBuff(b, tok);
    buffer_write(b, buffer_u8, $FF);

}

buffer_write(b, buffer_u8, $FF);

ds_queue_destroy(rpn);
