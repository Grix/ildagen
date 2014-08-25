//draws a preview of the element under construction

if (placing == "line")
    draw_line(startpos[0],startpos[1],mouse_x,512-mouse_y);
else if (placing == "circle")
    draw_circle(startpos[0],startpos[1],point_distance(startpos[0],startpos[1],mouse_x,512-mouse_y),1);
else if (placing == "wave")
    {
    cp = 20+5*wave_period;
    vector[0] = (mouse_x-startpos[0])/(cp-1);
    vector[1] = (512-mouse_y-startpos[1])/(cp-1);
    for (i = 0; i < cp; i++)
        {
        ratiox = sin(degtorad(point_direction(startpos[0],startpos[1],mouse_x,512-mouse_y)));
        ratioy = cos(degtorad(point_direction(startpos[0],startpos[1],mouse_x,512-mouse_y)));
        pointx[i] = startpos[0]+vector[0]*i+wave_amp*sin(pi*2/(cp-1)*i*wave_period)*ratiox/128;
        pointy[i] = startpos[1]+vector[1]*i+wave_amp*sin(pi*2/(cp-1)*i*wave_period)*ratioy/128;
        }
    for (i = 0; i < (cp-1); i++)
        draw_line(pointx[i],pointy[i],pointx[i+1],pointy[i+1]);
        
    if (mouse_wheel_up())
        {
        if !(keyboard_check(vk_control))
            wave_amp += 128*3;
        else 
            wave_period += 0.5;
        }
    else if (mouse_wheel_down())
        if !(keyboard_check(vk_control))
            wave_amp -= 128*3;
        else 
            wave_period -= 0.5;
            
    if (wave_period < 0.5) wave_period = 0.5;

    }