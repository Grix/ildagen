///optimize_arg(xfirst,yfirst,xlast,ylast,color)

xpeprev = argument0;
ypeprev = argument1;

xpe = argument2;
ype = argument3;
color = argument5;

opt_dist = point_distance(xpeprev,ypeprev,xpe,ype);
    
opt_vectorx = (xpe-xpeprev)/200;
opt_vectory = (ype-ypeprev)/200;

trav = -controller.opt_maxdist;
    
for (trav_dist = trav/2;opt_dist >= -trav_dist; trav_dist += trav)
    {
    xp = xpeprev-opt_vectorx*trav_dist;
    yp = ypeprev-opt_vectory*trav_dist;
    
    if (yp > (512*128)) || (yp < 0) || (xp > (512*128)) || (xp < 0)
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
    if (exp_format == 5)
        {
        buffer_write(ilda_buffer,buffer_u8,bl);
        buffer_write(ilda_buffer,buffer_u8,colour_get_blue(c));
        buffer_write(ilda_buffer,buffer_u8,colour_get_green(c));
        buffer_write(ilda_buffer,buffer_u8,colour_get_red(c));
        }
    else
        {
        buffer_write(ilda_buffer,buffer_u16,0);
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,color);
        }
    maxpoints++;
    }

