//tesing benchmark

log("---")
time = get_timer();
i = 0;
repeat (1000)
    {
    i++;
    vector = point_distance(100+i,20+i,i,50+i);
    }
time = get_timer()-time;
log(time);
/*time2 = get_timer();
repeat (1000)
    {
    
    }
log(get_timer()-time2);


