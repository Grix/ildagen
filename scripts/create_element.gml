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

if (placing == "line") //create a line
    {
    checkpoints = ceil(point_distance(startpos[0],startpos[1],mouse_x,512-mouse_y)*128/resolution);
    if (checkpoints < 2) checkpoints = 2;
    vector[0] = (mouse_x-startpos[0])/checkpoints;
    vector[1] = (512-mouse_y-startpos[1])/checkpoints;
    
    for (n = 0;n <= checkpoints; n++)
        {
        if (colormode = "solid")
            {
            c[0] = colour_get_blue(color1);
            c[1] = colour_get_green(color1);
            c[2] = colour_get_red(color1);
            }
        else if (colormode = "gradient")
            {
            c[0] = (colour_get_blue(color1)*(checkpoints-n)/checkpoints + colour_get_blue(color2)*n/checkpoints);
            c[1] = (colour_get_green(color1)*(checkpoints-n)/checkpoints + colour_get_green(color2)*n/checkpoints);
            c[2] = (colour_get_red(color1)*(checkpoints-n)/checkpoints + colour_get_red(color2)*n/checkpoints);
            }
            
        blank = 0;
        
        ds_list_add(new_list,n*vector[0]*128);
        ds_list_add(new_list,n*vector[1]*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        
        }
    }
else if (placing == "circle") //create a circle
    {
    radius = point_distance(startpos[0],startpos[1],mouse_x,512-mouse_y)*128;
    checkpoints = ceil(2*pi*radius/resolution);
    if (checkpoints < 8) checkpoints = 8;
    
    if !((startpos[0] == mouse_x) && (startpos[1] == mouse_y))
        for (n = 0;n <= checkpoints; n++)
            {
            if (colormode = "solid")
                {
                c[0] = colour_get_blue(color1);
                c[1] = colour_get_green(color1);
                c[2] = colour_get_red(color1);
                }
            else if (colormode = "gradient")
                {
                c[0] = (colour_get_blue(color1)*(checkpoints-n)/checkpoints + colour_get_blue(color2)*n/checkpoints);
                c[1] = (colour_get_green(color1)*(checkpoints-n)/checkpoints + colour_get_green(color2)*n/checkpoints);
                c[2] = (colour_get_red(color1)*(checkpoints-n)/checkpoints + colour_get_red(color2)*n/checkpoints);
                }
                
            blank = 0;
            
            ds_list_add(new_list,cos(2*pi/checkpoints*n)*radius);
            ds_list_add(new_list,sin(2*pi/checkpoints*n)*radius);
            ds_list_add(new_list,blank);
            ds_list_add(new_list,c[0]);
            ds_list_add(new_list,c[1]);
            ds_list_add(new_list,c[2]);
            
            }
    else
        {
        ds_list_add(new_list,mouse_x*128);
        ds_list_add(new_list,mouse_y*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        ds_list_add(new_list,mouse_x*128);
        ds_list_add(new_list,mouse_y*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        }
    }
if (placing == "wave") //create a wave
    {
    checkpoints = ceil((point_distance(startpos[0],startpos[1],mouse_x,512-mouse_y)*128+wave_amp*2*wave_period)/resolution);
    if (checkpoints < 4) checkpoints = 4;
    vector[0] = (mouse_x-startpos[0])/checkpoints;
    vector[1] = (512-mouse_y-startpos[1])/checkpoints;
    
    if !((startpos[0] == mouse_x) && (startpos[1] == mouse_y))
        for (n = 0;n <= checkpoints; n++)
            {
            if (colormode = "solid")
                {
                c[0] = colour_get_blue(color1);
                c[1] = colour_get_green(color1);
                c[2] = colour_get_red(color1);
                }
            else if (colormode = "gradient")
                {
                c[0] = (colour_get_blue(color1)*(checkpoints-n)/checkpoints + colour_get_blue(color2)*n/checkpoints);
                c[1] = (colour_get_green(color1)*(checkpoints-n)/checkpoints + colour_get_green(color2)*n/checkpoints);
                c[2] = (colour_get_red(color1)*(checkpoints-n)/checkpoints + colour_get_red(color2)*n/checkpoints);
                }
                
            ratiox = sin(degtorad(point_direction(startpos[0],startpos[1],mouse_x,512-mouse_y)));
            ratioy = cos(degtorad(point_direction(startpos[0],startpos[1],mouse_x,512-mouse_y)));
            pointx = vector[0]*n+wave_amp*sin(pi*2/checkpoints*n*wave_period)*ratiox/128;
            pointy = vector[1]*n+wave_amp*sin(pi*2/checkpoints*n*wave_period)*ratioy/128;
                
            blank = 0;
            
            ds_list_add(new_list,pointx*128);
            ds_list_add(new_list,pointy*128);
            ds_list_add(new_list,blank);
            ds_list_add(new_list,c[0]);
            ds_list_add(new_list,c[1]);
            ds_list_add(new_list,c[2]);
            
            }
    else
        {
        ds_list_add(new_list,mouse_x*128);
        ds_list_add(new_list,mouse_y*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        ds_list_add(new_list,mouse_x*128);
        ds_list_add(new_list,mouse_y*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        }
    }

    
ds_list_add(el_list,new_list);
