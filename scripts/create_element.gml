//creates an element from whatever has been done on the screen

placing_status = 0;

if (maxframes == 1) and (anienable)
    maxframes = 32;

ds_stack_push(undo_list,0);

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
    if (placing == "rect")
        {
        //if ( (startpos[0]-mouse_x) > (startpos[1]-(512-mouse_y)) )
            {
            endx = mouse_x;
            endy = startpos[1]-(mouse_x-startpos[0]);
            }
        /*else
            {
            endy = -mouse_y-startpos[1]+512;
            endy = 512-mouse_y;
            }*/
        }
    }

new_list = ds_list_create();

ds_list_add(new_list,startpos[0]*128); //origo x
ds_list_add(new_list,startpos[1]*128); //origo y
ds_list_add(new_list,endx*128); //end x
ds_list_add(new_list,endy*128); //end y
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);

if (placing == "line") //create a line
    create_line();
    
else if (placing == "circle") //create a circle
    create_circle();
    
if (placing == "wave") //create a wave
    create_wave();
    
else if (placing == "rect") //create a rectangle (not working)
    create_rect();

ds_list_add(el_list,new_list);

surf = surface_create(512,512);
surface_set_target(surf);
    draw_clear_alpha(c_white,0);
    xo = ds_list_find_value(new_list,0)/128;
    yo = ds_list_find_value(new_list,1)/128;
    
    //TODO if just one
    
    for (u = 0; u < (((ds_list_size(new_list)-10)/6)-1); u++)
        {
        xp = ds_list_find_value(new_list,10+u*6+0);
        yp = ds_list_find_value(new_list,10+u*6+1);
        bl = ds_list_find_value(new_list,10+u*6+2);
        b = ds_list_find_value(new_list,10+u*6+3);
        g = ds_list_find_value(new_list,10+u*6+4);
        r = ds_list_find_value(new_list,10+u*6+5);
        
        nxp = ds_list_find_value(new_list,10+(u+1)*6+0);
        nyp = ds_list_find_value(new_list,10+(u+1)*6+1);
        nbl = ds_list_find_value(new_list,10+(u+1)*6+2);
        nb = ds_list_find_value(new_list,10+(u+1)*6+3);
        ng = ds_list_find_value(new_list,10+(u+1)*6+4);
        nr = ds_list_find_value(new_list,10+(u+1)*6+5);
        
        if (nbl == 0)
            {
            draw_set_color(make_colour_rgb(nr,ng,nb));
            if (xp == nxp) && (yp == nyp)
                {
                draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                }
            else
                draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
            }
        
        }
surface_reset_target();
//surface_flip(surf);
ds_list_add(surf_list,surf);
