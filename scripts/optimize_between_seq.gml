xpeprev = xpp;
ypeprev = $ffff-ypp;

xpe = xo+xp;
ype = $ffff-(yo+yp);
opt_dist = point_distance(xpeprev,ypeprev,xpe,ype);

if (opt_dist < controller.opt_maxdist)
    return 1;

var t_yp, t_xp;

opt_vectorx = (xpe-xpeprev)/opt_dist;
opt_vectory = (ype-ypeprev)/opt_dist;

for (m = 0;m < controller.opt_maxdwell;m++)
    {
    t_xp = xpeprev;
    t_yp = ypeprev;
    
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
    buffer_write(ilda_buffer,buffer_u8,$40);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    maxpoints++;
    }

trav = -controller.opt_maxdist;
    
for (trav_dist = trav/2;opt_dist >= -trav_dist; trav_dist += trav)
    {
    t_xp = xpeprev-opt_vectorx*trav_dist;
    t_yp = ypeprev-opt_vectory*trav_dist;
    
    if (t_yp > (512*128)) || (t_yp < 0) || (t_xp > (512*128)) || (t_xp < 0)
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
    buffer_write(ilda_buffer,buffer_u8,$40);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    maxpoints++;
    }
    
for (m = 0;m < controller.opt_maxdwell;m++)
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
    buffer_write(ilda_buffer,buffer_u8,$40);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    maxpoints++;
    }
