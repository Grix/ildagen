///_ML_SY_QueueAppendQueue(q1, q2);
/// @argType    r,r
/// @returnType void
/// @hidden     true
//appends q2 to q1

var q1, q2;
q1 = argument0;
q2 = argument1;

repeat (ds_queue_size(q2)) {
    ds_queue_enqueue(q1, ds_queue_dequeue(q2));
}
