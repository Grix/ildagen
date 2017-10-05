//redraws the surface containing the layer list and audio visualization in the timeline mode
//todo
if (!surface_exists(timeline_surf))
{
    timeline_surf = surface_create(2048,2048);
	timeline_surf_pos = tlx;
	timeline_surf_length = 0;
}
    
if (timeline_surf_tlzoom != tlzoom || timeline_surf_pos > tlx)
{
	timeline_surf_length = 0;
	timeline_surf_pos = tlx;
	timeline_surf_tlzoom = tlzoom;
}

var tlwdivtlzoom = tlw/tlzoom; //frames to pixels -> *
var t_tlx = timeline_surf_pos + timeline_surf_length; //in frames
var t_tlzoom = tlx+tlzoom-t_tlx + 200/tlwdivtlzoom; //in frames
var t_tlw = t_tlzoom*tlwdivtlzoom; //in pixels

if (tlx+tlzoom-t_tlx > -50*tlwdivtlzoom)
{
	if (!surface_exists(timeline_surf_temp))
		timeline_surf_temp = surface_create(2048,2048);

	surface_set_target(timeline_surf_temp);

	    draw_set_alpha(1);
	    draw_set_font(fnt_small);
	    gpu_set_blendenable(false);
		draw_set_color(c_white);
		draw_rectangle(0,0,t_tlw,surface_get_height(timeline_surf_temp),0);
    
	    //layers
    
	    draw_set_color(c_black);
	    var t_y = tlh+16; //-layerbary;
	    //var ypos_perm = 0;
	    ypos_perm = t_y;
	    var mouseoverlayerbutton_hor = (mouse_x == clamp(mouse_x,t_tlw-56,t_tlw-24));
	    for (i = 0; i < ds_list_size(layer_list);i++)
	    {
	        _layer = layer_list[| i];
        
	        //if (ypos_perm > tlh+16-48) and (ypos_perm < lbsh)
	        //{
                            
	            draw_rectangle_colour(-1,ypos_perm,t_tlw+1,ypos_perm+48,c_white,c_white,c_silver,c_silver,0);
	            draw_rectangle(-1,ypos_perm,t_tlw-16,ypos_perm+48,1);
            
	            elementlist = _layer[| 1];
	            for (j = 0; j < ds_list_size(elementlist); j++)
	            {
	                objectlist = elementlist[| j];
				
					if (!ds_exists(objectlist,ds_type_list))
					{
						ds_list_delete(elementlist, j);
						if (j > 0)
							j--;
						continue;
					}
                
	                frametime = ds_list_find_value(objectlist,0);
	                infolist = ds_list_find_value(objectlist,2);
	                duration = ds_list_find_value(infolist,0);
                
	                if (frametime < t_tlx+t_tlzoom) and (frametime+duration > t_tlx)
	                {
	                    //draw object on timeline
	                    framestartx = floor((frametime-t_tlx)*tlwdivtlzoom);
	                    frameendx = ceil((frametime-t_tlx+duration+1)*tlwdivtlzoom);
	                    draw_set_colour(c_dkgray);
	                        draw_rectangle(framestartx,ypos_perm+1,frameendx,ypos_perm+47,0);
	                    draw_set_colour(c_green);
	                        draw_rectangle(framestartx,ypos_perm+1,frameendx,ypos_perm+47,1);
	                    draw_set_colour(c_white);
						if ((duration+1)*tlwdivtlzoom > 3)
						{
		                    if (!surface_exists(infolist[| 1]))
		                        infolist[| 1] = make_screenshot(objectlist[| 1]);
		                    draw_surface_part(infolist[| 1],0,0,floor(clamp((duration+1)*tlwdivtlzoom,0,32))-1,32,framestartx+1,ypos_perm+8);
						}
	                    maxframes = infolist[| 2];
	                    draw_set_colour(c_black);
	                    if (maxframes != 1)
	                        for (k = 1; k <= duration/maxframes; k++)
	                        {
	                            linex = floor(framestartx+k*maxframes*tlwdivtlzoom);
	                            draw_line(linex,ypos_perm,linex,ypos_perm+48);
	                        }
	                    if (ds_list_find_index(somaster_list,objectlist) != -1)
	                    {
	                        draw_set_colour(c_gold);
	                        gpu_set_blendenable(true);
	                        draw_set_alpha(0.3);
	                            draw_rectangle(framestartx,ypos_perm+1,frameendx,ypos_perm+47,0);
	                        draw_set_alpha(1);
	                        gpu_set_blendenable(false);
	                        draw_set_colour(c_black);
	                    }
	                }
	            }
	        //}
                        
	        //ypos_perm += 48;
	        ypos_perm += 48;
        
	        //envelopes
	        envelope_list = ds_list_find_value(_layer, 0);
	        for (j = 0; j < ds_list_size(envelope_list); j++)
	        {
	            //if (ypos_perm > tlh+16-64) and (ypos_perm < lbsh)
	            //{
	                envelope = ds_list_find_value(envelope_list,j);
	                type = ds_list_find_value(envelope,0);
	                disabled = ds_list_find_value(envelope,3);
	                hidden = ds_list_find_value(envelope,4);
	                if (!disabled)
	                    draw_set_colour(c_white);
	                else
	                    draw_set_colour(c_gray);
	                if (!hidden)
	                {
	                    draw_rectangle(-1,ypos_perm,t_tlw-16,ypos_perm+64,0);
	                    draw_set_colour(c_ltgray);
	                    draw_line(-1,ypos_perm+32,t_tlw-60,ypos_perm+32);
	                    draw_set_colour(c_black);
	                    draw_rectangle(-1,ypos_perm,t_tlw-16,ypos_perm+64,1);
	                }
	                else
	                {
	                    draw_rectangle(-1,ypos_perm,t_tlw-16,ypos_perm+16,0);
	                    draw_set_colour(c_black);
	                    draw_rectangle(-1,ypos_perm,t_tlw-16,ypos_perm+16,1);
                    
	                    //ypos_perm += 16;
	                    ypos_perm += 16;
	                    continue;
	                }
                
	                //drawing envelope data
	                time_list = ds_list_find_value(envelope,1);
	                data_list = ds_list_find_value(envelope,2);
	                var default_value = ypos_perm+32;
	                if (type != "x") and (type != "y") and (type != "hue")
	                    default_value = ypos_perm;
	                draw_set_colour(c_green);
	                if (ds_list_size(time_list))
	                {
	                    //binary search algo, set t_index to the list index just before visible area
	                    var imin = 0;
	                    var imax = ds_list_size(time_list)-1;
	                    var imid;
	                    while (imin <= imax)
	                    {
	                        imid = floor(mean(imin,imax));
	                        if (ds_list_find_value(time_list,imid) <= t_tlx)
	                        {
	                            var valnext = ds_list_find_value(time_list,imid+1);
	                            if (is_undefined(valnext)) or (valnext > t_tlx)
	                                break;
	                            else
	                                imin = imid+1;
	                        }
	                        else
	                            imax = imid-1;
	                    }
	                    var t_index = imid;
	                    var t_env_y;
	                    var t_env_x;
	                    //draw envelope graph
	                    while ( (ds_list_find_value(time_list,t_index)-t_tlx) < t_tlzoom)
	                    {
	                        t_env_y = ypos_perm+ds_list_find_value(data_list,t_index);
	                        t_env_x = (ds_list_find_value(time_list,t_index)-t_tlx)*tlwdivtlzoom;
	                        if (t_index == ds_list_size(time_list)-1)
	                        {
	                            if (t_index == 0)
	                            {
	                                draw_line( -1, t_env_y, t_tlw-16, t_env_y);
	                                draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
	                                break;
	                            }
	                            draw_line(  t_env_x,t_env_y,t_tlw-16, t_env_y);
	                            draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
	                            break;
	                        }
	                        else if (t_index == 0)
	                            draw_line(  -1, t_env_y, t_env_x, t_env_y);
	                        draw_line(  t_env_x, t_env_y,
	                                    (ds_list_find_value(time_list,t_index+1)-t_tlx)*tlwdivtlzoom,
	                                    ypos_perm+ds_list_find_value(data_list,t_index+1));
	                        draw_rectangle( t_env_x-1,t_env_y-1,t_env_x+1,t_env_y+1,0);
	                        t_index++;
	                    }
	                }
	                else
	                {
	                    draw_line(-1,default_value,t_tlw-16,default_value);
	                }
	            //}
	            //ypos_perm += 64;
	            ypos_perm += 64;
	        }
		}
		ypos_perm += 48;
    
	    gpu_set_blendenable(true);  
    
		//what is this?
	    draw_set_colour(c_white);
	    gpu_set_blendmode(bm_subtract);
	    draw_rectangle(-1,-1,t_tlw,tlh+16,0);
	    draw_rectangle(-1,lbh+tlh+16,t_tlw,lbh+tlh+33,0);
	    gpu_set_blendmode(bm_normal);
       
	    var drawtime = ceil(t_tlx/projectfps);
	    if (tlwdivtlzoom > 0.3) 
			modulus = 5;
	    else if (tlwdivtlzoom > 0.05)
			modulus = 25;
	    else 
			modulus = 60;
    
	    draw_set_colour(c_ltgray);
	    gpu_set_blendenable(false);
	    while (1)
	    {
	        var tempx = round((drawtime*projectfps-t_tlx)*tlwdivtlzoom);
	        if (tempx > t_tlw)
	            break;

			//todo move outside surface or fix clipping
	        if ((drawtime mod modulus) == 0)
	        {
	            //draw timestamp
	            draw_set_colour(c_gray);
	                draw_line(tempx,0,tempx,tlh-1);
	            draw_set_halign(fa_center);
	            draw_set_valign(fa_center);
	            draw_set_colour(c_dkgray);
	            draw_text(tempx,tlh+9,string_replace(string_format(floor(drawtime/60),2,0)," ","0")+
	                                ":"+string_replace(string_format(drawtime %60,2,0)," ","0"));
	            draw_set_halign(fa_left);
	            draw_set_valign(fa_top);
	            draw_set_colour(c_ltgray);
	        }
	        else
	        {
	            if ((drawtime % (modulus/5)) == 0)
	                draw_line(tempx,0,tempx,tlh-1);
	        }
	        drawtime++;
	    }
		
		gpu_set_blendenable(true);
    
	    //audio   
	    if (song != -1)
	    {
	        draw_set_alpha(0.67);
	        for (u=0; u <= t_tlw; u++)
	        {
	            var nearesti = round((t_tlx+u*t_tlzoom/t_tlw)/projectfps*30)*3;
            
	            if (nearesti > ds_list_size(audio_list)-3)
	                break;
                
	            var v_tlhalf = tlhalf;
	            var v_tlthird = tlthird;
                
	            var v = ds_list_find_value(audio_list,nearesti);
	            draw_set_color(c_green);
	            draw_line(u,v_tlhalf+v*v_tlthird,u,v_tlhalf-v*v_tlthird);
            
	            v = ds_list_find_value(audio_list,nearesti+1);
	            draw_set_color(c_red);
	            draw_line(u,v_tlhalf+v*v_tlthird,u,v_tlhalf-v*v_tlthird);
            
	            v = ds_list_find_value(audio_list,nearesti+2);
	            draw_set_color(c_blue);
	            draw_line(u,v_tlhalf+v*tlthird,u,v_tlhalf-v*v_tlthird);    
	        }
	    }
        
	
	surface_reset_target();
	
	ypos_perm -= t_y;
	surface_copy_part(timeline_surf, timeline_surf_length*tlwdivtlzoom, 0, timeline_surf_temp, 0, 0, ceil(t_tlzoom*tlwdivtlzoom), surface_get_height(timeline_surf));
	timeline_surf_length += t_tlzoom;

	//draw_set_color(c_white);
	draw_set_font(fnt_tooltip);

}

draw_set_color(c_black);
var t_y = tlh+16-layerbary+tlsurf_y;
//var ypos_perm = 0;
var t_ypos = t_y;
var mouseoverlayerbutton_hor = (mouse_x == clamp(mouse_x,tlw-56,tlw-24));
for (i = 0; i <= ds_list_size(layer_list);i++)
{
	if (i == ds_list_size(layer_list))
	{
	    //if (t_ypos > tlh+16-48) and (t_ypos < lbsh)
	        draw_sprite(spr_addlayer,
	                    mouseoverlayerbutton_hor and (mouse_y == clamp(mouse_y,t_ypos+8,t_ypos+40)),
	                    tlw-56,t_ypos+8);
	    t_ypos += 48;
	    break;
	}
            
	_layer = layer_list[| i];
          
	var mouse_on_button_ver = (mouse_y == clamp(mouse_y,138+t_ypos+8,138+t_ypos+40));
	draw_sprite(spr_deletelayer,
	                mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-56,tlw-24)),
	                tlw-56,t_ypos+8);
	draw_sprite(spr_addenvelope,
	                mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-96,tlw-64)),
	                tlw-96,t_ypos+8);
                            
	var t_name = _layer[| 4];
	var t_stringlength = string_width(t_name)+5;
	var t_stringx = 5;//tlw-96-t_stringlength-5;
	draw_set_colour($eeeeee);
	draw_rectangle(t_stringx,t_ypos+3,t_stringx+t_stringlength+5,t_ypos+17,0);
	draw_set_colour($bbbbbb);
	draw_rectangle(t_stringx,t_ypos+3,t_stringx+t_stringlength+5,t_ypos+17,1);
                    
	draw_set_colour(c_black);
	gpu_set_blendenable(true);
	draw_text(t_stringx+5, t_ypos+4, t_name);
	gpu_set_blendenable(false);
                            
	if (selectedlayer == i)
	{
	    draw_set_colour(180);
	    var drawcursorxcorrected = (selectedx-tlx)/tlzoom*tlw;
	    if (drawcursorxcorrected == clamp(drawcursorxcorrected,0,tlw))
	        draw_line(drawcursorxcorrected,t_ypos,drawcursorxcorrected,t_ypos+48);
	    draw_set_colour(c_black);
	}
                        
	//t_ypos += 48;
	t_ypos += 48;
        
	//envelopes
	envelope_list = ds_list_find_value(_layer, 0);
	for (j = 0; j < ds_list_size(envelope_list); j++)
	{
	    //if (t_ypos > tlh+16-64) and (t_ypos < lbsh)
	    //{
	        envelope = ds_list_find_value(envelope_list,j);
	        type = ds_list_find_value(envelope,0);
	        disabled = ds_list_find_value(envelope,3);
	        hidden = ds_list_find_value(envelope,4);
	        if (hidden)
	        {
	            var typedraw = ds_map_find_value(env_type_map,type);
	            var t_stringlength = string_width(typedraw)+5;
	            var t_stringx = tlw-25-t_stringlength-5;
	            draw_set_colour($eeeeee);
	            draw_rectangle(t_stringx,t_ypos+1,t_stringx+t_stringlength+5,t_ypos+15,0);
	            draw_set_colour($bbbbbb);
	            draw_rectangle(t_stringx,t_ypos+1,t_stringx+t_stringlength+5,t_ypos+15,1);
                            
	            draw_set_colour(c_black);
	            gpu_set_blendenable(true);
	            draw_text(t_stringx+5, t_ypos+2, typedraw);
	            gpu_set_blendenable(false);
                    
	            //t_ypos += 16;
	            t_ypos += 16;
	            continue;
	        }
                
	        if (moving_object == 6) and (envelopetoedit == envelope)
	        {
	            draw_set_colour(c_green);
	            draw_line(mousexprev,mouseyprev-138,mouse_x,mouse_y-138);
	        }
                    
	        var typedraw = ds_map_find_value(env_type_map,type);
	        var t_stringlength = string_width(typedraw)+5;
	        var t_stringx = tlw-25-t_stringlength-5;
	        draw_set_colour($eeeeee);
	        draw_rectangle(t_stringx,t_ypos+42,t_stringx+t_stringlength+5,t_ypos+60,0);
	        draw_set_colour($bbbbbb);
	        draw_rectangle(t_stringx,t_ypos+42,t_stringx+t_stringlength+5,t_ypos+60,1);
                        
	        draw_set_colour(c_black);
	        gpu_set_blendenable(1);
	            draw_text(t_stringx+5, t_ypos+45, typedraw);
	            if (moving_object == 7) and (envelopetoedit == envelope)
	            {
	                draw_set_colour(c_red);
	                draw_set_alpha(0.3);
	                draw_rectangle(mousexprev,t_ypos,mouse_x,t_ypos+64,0);
	                draw_set_colour(c_black);
	                draw_set_alpha(1);
	            }
	        gpu_set_blendenable(0);
	        mouse_on_button_ver = (mouse_y == clamp(mouse_y,138+8+t_ypos,138+40+t_ypos));
	        draw_sprite(spr_deletelayer,
	                    mouse_on_button_ver and (mouse_x == clamp(mouse_x,tlw-56,tlw-24)),
	                    tlw-56,t_ypos+8);
	    //}
	    //t_ypos += 64;
	    t_ypos += 64;
	}
}
    
//start and end frame lines
startframex = (startframe-tlx)*tlwdivtlzoom;
if (startframex == clamp(startframex,0,tlw-16))
{
	draw_set_color(c_blue);
	draw_rectangle(startframex,0,startframex+1,tlh-1,0);
	draw_rectangle(startframex,tlh+17,startframex+1,lbsh,0);
	draw_set_font(fnt_bold);
	draw_text(startframex+4,lbsh-20,"Start");
}

endframex = (endframe-tlx)*tlwdivtlzoom;
if (endframex == clamp(endframex,0,tlw-16))
{
	draw_set_color(c_red);
	draw_rectangle(endframex,0,endframex+1,tlh-1,0);
	draw_rectangle(endframex,tlh+17,endframex+1,lbsh,0);
	draw_set_font(fnt_bold);
	draw_text(endframex-25,lbsh-20,"End");
}
gpu_set_blendenable(true);  
    
/*draw_set_colour(c_white);
gpu_set_blendmode(bm_subtract);
draw_rectangle(-1,-1,tlw,tlh+16,0);
draw_rectangle(-1,lbh+tlh+16,tlw,lbh+tlh+33,0);
gpu_set_blendmode(bm_normal);*/
        
//markers
draw_set_alpha(0.9);
draw_set_colour(c_fuchsia);
for (i = 0; i < ds_list_size(marker_list); i++)
{
	if (ds_list_find_value(marker_list,i) == clamp(ds_list_find_value(marker_list,i),tlx,tlx+tlzoom))
	{
	    var markerpostemp = (ds_list_find_value(marker_list,i)-tlx)*tlwdivtlzoom;
	    draw_rectangle(markerpostemp,0,markerpostemp+1,tlh-1,0);
	    draw_rectangle(markerpostemp,tlh+17,markerpostemp+1,lbsh,0);
	}
}
        
//scope fog
draw_set_alpha(0.6);
draw_set_colour(c_black);
if (startframex > 0)
	draw_rectangle(0,0,clamp(startframex,0,tlw-16),lbsh,0);
if (endframex < tlw)
{
	draw_rectangle(clamp(endframex,tlw-16,tlw),0,tlw,tlh+16,0);
	if (endframex < tlw-16)
	    draw_rectangle(clamp(endframex,0,tlw-16),0,tlw-16,lbsh,0);
}
draw_set_alpha(1);
    
//draw_set_alpha(1);
//draw_set_colour(c_white);
