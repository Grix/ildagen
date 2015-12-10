optimize_middle3_seq();
    
xpe = xo+xp;
ype = $ffff-(yo+yp);

opt_dist = point_distance($ffff/2,$ffff/2,xpe,ype);
opt_vectorx = ($ffff/2-xpe)/opt_dist;
opt_vectory = ($ffff/2-ype)/opt_dist;

var t_xp = xp;
var t_yp = yp;

trav = -controller.opt_maxdist;    
for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
    {
    t_xp = $ffff/2+opt_vectorx*trav_dist;
    t_yp = $ffff/2+opt_vectory*trav_dist;
    
    if ((t_yp > (512*128)) or (t_yp < 0) or (t_xp > (512*128)) or (t_xp < 0))
        {
        continue;
        }
    
    t_xp -= $8000;
    t_yp -= $8000;
    xpa[0] = t_xp & 255;
    t_xp = t_xp >> 8;
    xpa[1] = t_xp & 255;
    ypa[0] = t_yp & 255;
    t_yp = t_yp >> 8;
    ypa[1] = t_yp & 255;

    
    //writing point
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    if (exp_format == 5)
        {
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,0);
        buffer_write(ilda_buffer,buffer_u8,0);
        buffer_write(ilda_buffer,buffer_u8,0);
        }
    else
        {
        buffer_write(ilda_buffer,buffer_u16,0);
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,0);
        }
    maxpoints++;
    }
    
for (m = 0; m < controller.opt_maxdwell; m++)
    {
    t_xp = xpe;
    t_yp = ype;
    
    t_xp -= $8000;
    t_yp -= $8000;
    xpa[0] = t_xp & 255;
    t_xp = t_xp >> 8;
    xpa[1] = t_xp & 255;
    ypa[0] = t_yp & 255;
    t_yp = t_yp >> 8;
    ypa[1] = t_yp & 255;
    
    //writing point
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    if (exp_format == 5)
        {
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,0);
        buffer_write(ilda_buffer,buffer_u8,0);
        buffer_write(ilda_buffer,buffer_u8,0);
        }
    else
        {
        buffer_write(ilda_buffer,buffer_u16,0);
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,0);
        }
    maxpoints++;
    }
