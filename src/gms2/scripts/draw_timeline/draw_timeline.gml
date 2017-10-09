var tlwdivtlzoom = tlw/tlzoom; //frames to pixels -> *
var t_tlx = timeline_surf_pos + timeline_surf_length; //in frames
var t_tlzoom = tlx+tlzoom-t_tlx + 200/tlwdivtlzoom; //in frames
var t_tlw = t_tlzoom*tlwdivtlzoom; //in pixels


draw_surface_part(timeline_surf, floor(tlx*tlwdivtlzoom - timeline_surf_pos*tlwdivtlzoom), 0, tlw-16, lbsh-(tlh+16), 0, tlsurf_y+tlh+15);

draw_set_color(c_black);
var t_ypos = tlh+16-layerbary+tlsurf_y;
var mouse_on_button_hor = (mouse_x == clamp(mouse_x,tlw-56,tlw-24));
for (i = 0; i <= ds_list_size(layer_list);i++)
{
	if (i == ds_list_size(layer_list))
	{
		var mouse_on_button_ver = (mouse_y == clamp(mouse_y,t_ypos+8,t_ypos+40)) && mouse_y > tlsurf_y+tlh+16;
	    if (t_ypos > tlh+16-48+tlsurf_y) and (t_ypos < lbsh+tlsurf_y)
	        draw_sprite(spr_addlayer,
	                    mouse_on_button_hor && mouse_on_button_ver,
	                    tlw-56,t_ypos+8);
	    t_ypos += 48;
	    break;
	}
            
	_layer = layer_list[| i];
          
	if (t_ypos > tlh+16-48+tlsurf_y) and (t_ypos < lbsh+tlsurf_y)
	{
		var mouse_on_button_ver = (mouse_y == clamp(mouse_y,t_ypos+8,t_ypos+40)) && mouse_y > tlsurf_y+tlh+16;
		draw_sprite(spr_deletelayer,
		                mouse_on_button_ver and mouse_on_button_hor,
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
	}

                     
	t_ypos += 48;
        
	//envelopes
	envelope_list = ds_list_find_value(_layer, 0);
	for (j = 0; j < ds_list_size(envelope_list); j++)
	{
	    if (t_ypos > tlh+16-64+tlsurf_y) and (t_ypos < lbsh+tlsurf_y)
	    {
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
                    
	            t_ypos += 16;
	            continue;
	        }
                
	        if (moving_object == 6) and (envelopetoedit == envelope)
	        {
	            draw_set_colour(c_green);
	            draw_line(mousexprev,mouseyprev-tlsurf_y,mouse_x,mouse_y-tlsurf_y);
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
	        mouse_on_button_ver = (mouse_y == clamp(mouse_y,8+t_ypos,40+t_ypos));
	        draw_sprite(spr_deletelayer,
	                    mouse_on_button_ver and mouse_on_button_hor,
	                    tlw-56,t_ypos+8);
	    }
	    t_ypos += 64;
	}
}
    
//start and end frame lines
draw_set_font(fnt_bold);
gpu_set_blendenable(true);

startframex = (startframe-tlx)*tlwdivtlzoom;
if (startframex == clamp(startframex,0,tlw-16))
{
	draw_set_color(c_blue);
	draw_rectangle(startframex,tlsurf_y,startframex+1,tlsurf_y+tlh-1,0);
	draw_rectangle(startframex,tlsurf_y+tlh+17,startframex+1,tlsurf_y+lbsh,0);
	draw_text(startframex+4,tlsurf_y+lbsh-20,"Start");
}

endframex = (endframe-tlx)*tlwdivtlzoom;
if (endframex == clamp(endframex,0,tlw-16))
{
	draw_set_color(c_red);
	draw_rectangle(endframex,tlsurf_y,endframex+1,tlsurf_y+tlh-1,0);
	draw_rectangle(endframex,tlsurf_y+tlh+17,endframex+1,tlsurf_y+lbsh,0);
	draw_text(endframex-25,tlsurf_y+lbsh-20,"End");
}
draw_set_font(fnt_tooltip);
        
//markers
draw_set_alpha(0.9);
draw_set_colour(c_fuchsia);
for (i = 0; i < ds_list_size(marker_list); i++)
{
	if (ds_list_find_value(marker_list,i) == clamp(ds_list_find_value(marker_list,i),tlx,tlx+tlzoom))
	{
	    var markerpostemp = (ds_list_find_value(marker_list,i)-tlx)*tlwdivtlzoom;
	    draw_rectangle(markerpostemp,tlsurf_y,markerpostemp+1,tlh-1+tlsurf_y,0);
	    draw_rectangle(markerpostemp,tlsurf_y+tlh+17,markerpostemp+1,lbsh+tlsurf_y,0);
	}
}

draw_set_alpha(1);
draw_surface_part(timeline_surf_audio, floor(tlx*tlwdivtlzoom - timeline_surf_pos*tlwdivtlzoom), 0, tlw, tlh+16, 0, tlsurf_y);
        
//scope fog
gpu_set_blendenable(true);
draw_set_alpha(0.6);
draw_set_colour(c_black);
if (startframex > 0)
	draw_rectangle(0,tlsurf_y,clamp(startframex,0,tlw-16),lbsh+tlsurf_y,0);
if (endframex < tlw)
{
	draw_rectangle(clamp(endframex,tlw-16,tlw),tlsurf_y,tlw,tlsurf_y+tlh+16,0);
	if (endframex < tlw-16)
	    draw_rectangle(clamp(endframex,0,tlw-15),tlsurf_y,tlw-15,lbsh+tlsurf_y,0);
}

//scroll edges
draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(0, tlsurf_y+lbsh, tlw, tlsurf_y+lbsh+16, 0);
draw_rectangle(tlw-16, tlsurf_y+tlh+16, tlw, tlsurf_y+lbsh+16, 0);
draw_set_color(c_black);
draw_rectangle(0, tlsurf_y+lbsh, tlw, tlsurf_y+lbsh+16, 1);
draw_rectangle(tlw-16, tlsurf_y+tlh+16, tlw, tlsurf_y+lbsh+16, 1);
