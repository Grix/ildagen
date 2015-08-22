draw_clear_alpha(c_black,1);

el_list = ds_list_find_value(frame_list,frame);

draw_set_blend_mode(bm_add);
draw_set_alpha(0.8);
draw_set_colour(c_white);
for (i = 0;i < ds_list_size(el_list);i++)
    {
    new_list = ds_list_find_value(el_list,i);
    
    xo = ds_list_find_value(new_list,0)/128;
    yo = ds_list_find_value(new_list,1)/128;
    listsize = (((ds_list_size(new_list)-20)/4)-1);
    
    for (u = 0; u < listsize; u++)
        {
        nextpos = 20+(u+1)*4;
        nbl = ds_list_find_value(new_list,nextpos+2);
        
        if (nbl == 0)
            {
            xp = ds_list_find_value(new_list,nextpos-4);
            yp = ds_list_find_value(new_list,nextpos-3);
            
            nxp = ds_list_find_value(new_list,nextpos);
            nyp = ds_list_find_value(new_list,nextpos+1);
            
            pdir = point_direction(256,256,xo+ xp/128,yo+ yp/128);
            npdir = point_direction(256,256,xo+ nxp/128,yo+ nyp/128);
            xxp = 256+cos(degtorad(-pdir))*400;
            yyp = 256+sin(degtorad(-pdir))*400;
            nxxp = 256+cos(degtorad(-npdir))*400;
            nyyp = 256+sin(degtorad(-npdir))*400;
            
            if (xp == nxp) && (yp == nyp) && !(ds_list_find_value(new_list,nextpos-2))
                {
                draw_set_alpha(0.9);
                draw_line_colour(256,256,xxp,yyp,ds_list_find_value(new_list,nextpos+3),c_black);
                draw_set_alpha(0.8);
                }
            else
                draw_triangle_colour(256,256,xxp,yyp,nxxp,nyyp,ds_list_find_value(new_list,nextpos+3),c_black,c_black,0);
            }
        }
    }
draw_set_blend_mode(bm_normal);
draw_set_colour(c_black);
draw_set_alpha(1);