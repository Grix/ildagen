optimize_middle3();
    
xo = ds_list_find_value(ds_list_find_value(el_list,0),0);
yo = ds_list_find_value(ds_list_find_value(el_list,0),1);
xpe = xo+ds_list_find_value(ds_list_find_value(el_list,0),20);
ype = $ffff-(yo+ds_list_find_value(ds_list_find_value(el_list,0),21));



opt_dist = point_distance($ffff/2,$ffff/2,xpe,ype);
opt_vectorx = ($ffff/2-xpe)/opt_dist;
opt_vectory = ($ffff/2-ype)/opt_dist;

trav = -controller.opt_maxdist;    
for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
    {
    xp = $ffff/2+opt_vectorx*trav_dist;
    yp = $ffff/2+opt_vectory*trav_dist;
    
    if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
        {
        continue;
        }
    
    xp -= $8000;
    yp -= $8000;
    xpa[0] = xp & 255;
    xp = xp >> 8;
    xpa[1] = xp & 255;
    ypa[0] = yp & 255;
    yp = yp >> 8;
    ypa[1] = yp & 255;

    
    //writing point
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    buffer_write(ilda_buffer,buffer_u8,$40);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    maxpoints++;
    }
    
for (m = 0;m < opt_maxdwell;m++)
    {
    xp = xpe;
    yp = ype;
    
    xp -= $8000;
    yp -= $8000;
    xpa[0] = xp & 255;
    xp = xp >> 8;
    xpa[1] = xp & 255;
    ypa[0] = yp & 255;
    yp = yp >> 8;
    ypa[1] = yp & 255;
    
    //writing point
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    buffer_write(ilda_buffer,buffer_u8,$40);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    maxpoints++;
    }