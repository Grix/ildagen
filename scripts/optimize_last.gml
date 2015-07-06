xpeprev = xpe;
ypeprev = ype;

opt_dist = point_distance($ffff/2,$ffff/2,xpe,ype);
opt_vectorx = (xpeprev-$ffff/2)/opt_dist;
opt_vectory = (ypeprev-$ffff/2)/opt_dist;

for (m = 0;m < 3;m++)
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

trav = -controller.opt_maxdist;
for (trav_dist = trav/2;trav_dist >= -opt_dist; trav_dist += trav;)
    {
    xp = xpeprev+opt_vectorx*trav_dist;
    yp = ypeprev+opt_vectory*trav_dist;
    
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
    
