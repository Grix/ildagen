maxpointswanted = floor((1/controller.projectfps)*controller.opt_scanspeed); 
output_buffer_next_size = maxpointswanted;

if (controller.dac[| 1] == 0)
{
    //riya, 12bit
    xp = $800;
    yp = $800;
}
    
repeat (maxpointswanted)
    {
    //writing point
    buffer_write(output_buffer_next,buffer_u16,xp);
    buffer_write(output_buffer_next,buffer_u16,yp);
    buffer_write(output_buffer_next,buffer_u32,0);
    }
