//tesing benchmark
/*
log("---")
time = get_timer();
i = 0;
repeat (1000)
    {
    t_point[i] = ds_list_create();
    ds_list_add(t_point[i],100);
    ds_list_add(t_point[i],100);
    ds_list_add(t_point[i],100);
    ds_list_add(t_point[i],100);
    i++;
    }
i = 0;
repeat (1000)
    {
    ds_list_destroy(t_point[i]);
    i++;
    }
time = get_timer()-time;
log(time);
time2 = get_timer();
repeat (1000)
    {
    t_point1 = ds_list_create();
    ds_list_add(t_point1,100);
    ds_list_add(t_point1,100);
    ds_list_add(t_point1,100);
    ds_list_add(t_point1,100);
    ds_list_destroy(t_point1);
    }
log(get_timer()-time2);

*/
