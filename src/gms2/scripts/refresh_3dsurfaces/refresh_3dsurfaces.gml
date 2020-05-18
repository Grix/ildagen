draw_clear_alpha(c_black,1);

el_list = ds_list_find_value(frame_list,frame);

var t_div = $ffff/view_wport[4];
var t_wporthalf = view_wport[4]/2;
var t_scalediag = sqrt(view_hport[4]*view_hport[4]+view_wport[4]*view_wport[4])/2;

gpu_set_blendmode(bm_add);
draw_set_alpha(0.8);
draw_set_colour(c_white);
for (i = 0;i < ds_list_size(el_list);i++)
{
    new_list = ds_list_find_value(el_list,i);
    
    xo = ds_list_find_value(new_list,0)/t_div;
    yo = ds_list_find_value(new_list,1)/t_div;
    listsize = (((ds_list_size(new_list)-20)/4)-1);
    
    for (u = 0; u < listsize; u++)
    {
        nextpos = 20+(u+1)*4;
        nbl = ds_list_find_value(new_list,nextpos+2);
        
        if (nbl == 0)
        {
            if (viewmode == 1)
                framepoints++;
            
            xp = ds_list_find_value(new_list,nextpos-4);
            yp = ds_list_find_value(new_list,nextpos-3);
            
            nxp = ds_list_find_value(new_list,nextpos);
            nyp = ds_list_find_value(new_list,nextpos+1);
            
            pdir = point_direction(t_wporthalf,t_wporthalf,xo+ xp/t_div,yo+ yp/t_div);
            npdir = point_direction(t_wporthalf,t_wporthalf,xo+ nxp/t_div,yo+ nyp/t_div);
            xxp = t_wporthalf+cos(degtorad(-pdir))*t_scalediag;
            yyp = t_wporthalf+sin(degtorad(-pdir))*t_scalediag;
            nxxp = t_wporthalf+cos(degtorad(-npdir))*t_scalediag;
            nyyp = t_wporthalf+sin(degtorad(-npdir))*t_scalediag;
            
            if (abs(xp-nxp) < 8) && (abs(yp-nyp) < 8) && !(ds_list_find_value(new_list,nextpos-2))
            {
                draw_set_alpha(0.9);
                draw_line_colour(t_wporthalf,t_wporthalf,xxp,yyp,ds_list_find_value(new_list,nextpos+3),c_black);
                draw_set_alpha(0.8);
            }
            else
                draw_triangle_colour(t_wporthalf,t_wporthalf,xxp,yyp,nxxp,nyyp,ds_list_find_value(new_list,nextpos+3),c_black,c_black,0);
        }
		else if (!controller.exp_optimize)
			framepoints++;
    }
}
gpu_set_blendmode(bm_normal);
draw_set_colour(c_black);
draw_set_alpha(1);
