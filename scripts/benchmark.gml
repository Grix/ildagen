//tesing benchmark
log("---")
var t_point = 0;
var t_pointcopy = 0;
time = get_timer();
repeat (1000)
    {
    t_point = ds_list_create();
    ds_list_add(t_point,100);
    ds_list_add(t_point,100);
    ds_list_add(t_point,100);
    ds_list_add(t_point,100);
    }
time = get_timer()-time;
log(time);
time2 = get_timer();
repeat (1000)
    {
    t_point = ds_list_create();
    ds_list_add(t_point,100);
    ds_list_add(t_point,100);
    ds_list_add(t_point,100);
    ds_list_add(t_point,100);
    ds_list_destroy(t_point);
    }
log(get_timer()-time2 - time);
