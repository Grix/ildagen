for (i = 0;i < ds_list_size(surf3d_list);i++)
    {
    surface_free(ds_list_find_value(surf3d_list,i))
    }
ds_list_clear(surf3d_list);

el_list = ds_list_find_value(frame_list,frame);

draw_set_alpha(0.65);
for (i = 0;i < ds_list_size(el_list);i++)
    {
    new_list = ds_list_find_value(el_list,i);
    
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
            
            nxp = ds_list_find_value(new_list,10+(u+1)*6+0);
            nyp = ds_list_find_value(new_list,10+(u+1)*6+1);
            nbl = ds_list_find_value(new_list,10+(u+1)*6+2);
            nb = ds_list_find_value(new_list,10+(u+1)*6+3);
            ng = ds_list_find_value(new_list,10+(u+1)*6+4);
            nr = ds_list_find_value(new_list,10+(u+1)*6+5);
            
            if (nbl == 0)
                {
                pdir = point_direction(256,256,xo+ xp/128,yo+ yp/128);
                npdir = point_direction(256,256,xo+ nxp/128,yo+ nyp/128);
                xxp = 256+cos(degtorad(-pdir))*400;
                yyp = 256+sin(degtorad(-pdir))*400;
                nxxp = 256+cos(degtorad(-npdir))*400;
                nyyp = 256+sin(degtorad(-npdir))*400;
                
                draw_set_color(make_colour_rgb(nr,ng,nb));
                if (xp == nxp) && (yp == nyp)
                    {
                    draw_set_alpha(0.8)
                    draw_line_colour(256,256,xxp,yyp,make_colour_rgb(nr,ng,nb),make_colour_rgb(nr/9,ng/9,nb/9));
                    draw_set_alpha(0.65)
                    }
                else
                    draw_triangle_colour(256,256,xxp,yyp,nxxp,nyyp,make_colour_rgb(nr,ng,nb),make_colour_rgb(nr/9,ng/9,nb/9),make_colour_rgb(nr/9,ng/9,nb/9),0);
                }
        
            
            }
    surface_reset_target();
    ds_list_add(surf3d_list,surf);
    }


draw_set_alpha(1);