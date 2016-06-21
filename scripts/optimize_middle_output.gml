maxpointswanted = floor((1/controller.projectfps)*controller.opt_scanspeed); 
output_buffer_next_size = maxpointswanted;

    
repeat (maxpointswanted)
    {
    //writing point
    buffer_write(output_buffer,buffer_u16,$8000);
    buffer_write(output_buffer,buffer_u16,$8000);
    buffer_write(output_buffer,buffer_u32,0);
    buffer_write(output_buffer,buffer_u32,0);
    }
