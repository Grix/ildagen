//creates an element from whatever has been done on the screen

placing_status = 0;

ds_stack_push(undo_list,0);

if (!keyboard_check(vk_shift))
    {
    endx = mouse_x;
    endy = mouse_y;
    }
else
    {
    if (point_direction(startpos[0],startpos[1],mouse_x,mouse_y) > 315) || (point_direction(startpos[0],startpos[1],mouse_x,512-mouse_y) < 45) || ( (point_direction(startpos[0],startpos[1],mouse_x,512-mouse_y) > 135) && (point_direction(startpos[0],startpos[1],mouse_x,512-mouse_y) < 225) )
        {
        endx = mouse_x;
        endy = 512-startpos[1];
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
ds_list_add(new_list,(512-endy)*128); //end y
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