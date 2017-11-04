if (!rdy) 
	exit;
if (view_current == 3)
	exit;

///Draw the box
draw_set_color(bak_color);
draw_set_alpha(bak_alpha);
draw_rectangle(x1,ty1,x2,ty2,false);
draw_set_alpha(1);
draw_set_color(border_color);
draw_rectangle(x1,ty1,x2,ty2,true);

draw_set_color(separator_color);

for(var i = 0; i < num; i++)
{
    var y1 = y+(item_height*i)+y_offset+1;
    var y2 = y+(item_height*(i+1))+y_offset;
    
    draw_set_color(separator_color);
    
    if(ds_list_find_value(sep_list,i))
    {
        draw_line(x1,y1,x2,y1);
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    if (ds_list_find_value(hl_list,i) == 0)
        draw_set_color(text_color);
    else
        draw_set_color(c_white);
    draw_text(x1+item_padding, y1+item_padding-2, ds_list_find_value(desc_list,i));
    
    if(i == selected)
    {
        draw_set_color(highlight_color);
        draw_set_alpha(.05);
        draw_roundrect_ext(x1+highlight_padding,y1+highlight_padding,x2-highlight_padding,y2-highlight_padding,highlight_rad,highlight_rad,false);
        draw_set_alpha(.8);
        draw_roundrect_ext(x1+highlight_padding,y1+highlight_padding,x2-highlight_padding,y2-highlight_padding,highlight_rad,highlight_rad,true);
        draw_set_alpha(1);
    }
}

//draw_sprite(spr_cursor,9,obj_cursor.x,obj_cursor.y);

draw_set_color(c_black);
draw_set_alpha(1);