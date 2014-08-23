//creates an element from whatever has been done on the screen

placing_status = 0;

new_list = ds_list_create();

ds_list_add(new_list,startpos[0]*128); //origo x
ds_list_add(new_list,startpos[1]*128); //origo y
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);

if (placing == "line")
    {
    checkpoints = ceil(point_distance(startpos[0],startpos[1],mouse_x,mouse_y,)*128/resolution);
    vector[0] = (mouse_x-startpos[0])/checkpoints;
    vector[1] = (mouse_y-startpos[1])/checkpoints;
    
    for (n = 0;n <= checkpoints; n++)
        {
        c[0] = 255;
        c[1] = 255;
        c[2] = 255;
        blank = $40;
        
        ds_list_add(new_list,n*vector[0]*128);
        ds_list_add(new_list,n*vector[1]*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        
        }
    }
    
ds_list_add(el_list,new_list);
