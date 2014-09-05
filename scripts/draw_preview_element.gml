//draws a preview of the element under construction

if (!keyboard_check(vk_shift))
    {
    endx = mouse_x;
    endy = mouse_y;
    }
else
    {
    if (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) > 315) || (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) < 45) || ( (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) > 135) && (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) < 225) )
        {
        endx = mouse_x;
        endy = startpos[1];
        }
    else
        {
        endx = startpos[0];
        endy = mouse_y;
        }

    }

if (placing == "line")
    draw_line(startpos[0],startpos[1],endx,endy);
else if (placing == "rect")
    draw_rectangle(startpos[0],startpos[1],endx,endy,1);
else if (placing == "circle")
    draw_circle(startpos[0],startpos[1],point_distance(startpos[0],startpos[1],endx,endy),1);
else if (placing == "wave")
    {
    cp = 20+5*wave_period;
    vector[0] = (endx-startpos[0])/(cp-1);
    vector[1] = (endy-startpos[1])/(cp-1);
    for (i = 0; i < cp; i++)
        {
        ratiox = sin(degtorad(point_direction(startpos[0],startpos[1],endx,endy)));
        ratioy = cos(degtorad(point_direction(startpos[0],startpos[1],endx,endy)));
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
