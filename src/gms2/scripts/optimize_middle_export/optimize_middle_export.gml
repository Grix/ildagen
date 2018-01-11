if (controller.exp_optimize == 0)
    maxpointswanted = 1;
else
    maxpointswanted = floor((1/controller.projectfps)*controller.opt_scanspeed); 

x_lowerbound_top = controller.scale_left_top;
y_lowerbound_left = $FFFF-controller.scale_bottom_left;
x_lowerbound_bottom = controller.scale_left_bottom;
y_lowerbound_right = $FFFF-controller.scale_bottom_right;
x_scale_top = (controller.scale_right_top-controller.scale_left_top)/$ffff;
y_scale_left = (controller.scale_bottom_left-controller.scale_top_left)/$ffff;
x_scale_bottom = (controller.scale_right_bottom-controller.scale_left_bottom)/$ffff;
y_scale_right = (controller.scale_bottom_right-controller.scale_top_right)/$ffff;
mid_x = x_lowerbound_top+(x_lowerbound_bottom-x_lowerbound_top)*($8000/$ffff)+$8000*(x_scale_top+(x_scale_bottom-x_scale_top)*($8000/$ffff));
mid_y = y_lowerbound_left+(y_lowerbound_right-y_lowerbound_left)*($8000/$ffff)+$8000*(y_scale_left+(y_scale_right-y_scale_left)*($8000/$ffff));

xp = mid_x;
yp = mid_y;

xp -= $8000;
yp -= $8000;
xpa[0] = xp & 255;
xp = xp >> 8;
xpa[1] = xp & 255;
ypa[0] = yp & 255;
yp = yp >> 8;
ypa[1] = yp & 255;

for (m = 0; m < maxpointswanted-1; m++)
{
    //writing point
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    
    if (controller.exp_format == 5)
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
}
buffer_write(ilda_buffer,buffer_u8,xpa[1]);
buffer_write(ilda_buffer,buffer_u8,xpa[0]);
buffer_write(ilda_buffer,buffer_u8,ypa[1]);
buffer_write(ilda_buffer,buffer_u8,ypa[0]);

if (controller.exp_format == 5)
{
    buffer_write(ilda_buffer,buffer_u8,$C0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
}
else
{
    buffer_write(ilda_buffer,buffer_u16,0);
    buffer_write(ilda_buffer,buffer_u8,$C0);
    buffer_write(ilda_buffer,buffer_u8,0);
}
