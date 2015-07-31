xpeprev = argument0;
ypeprev = argument1;

xpe = argument2;
ype = argument3;
opt_dist = point_distance(xpeprev,ypeprev,xpe,ype);

if (opt_dist < controller.opt_maxdist)
    return 1;
    
opt_vectorx = (xpe-xpeprev)/opt_dist;
opt_vectory = (ype-ypeprev)/opt_dist;

for (m = 0;m < opt_maxdwell;m++)
    {
    xp = xpeprev;
    yp = ypeprev;
    
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