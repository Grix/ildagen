maxpointswanted = floor((1/controller.projectfps)*controller.opt_scanspeed); 

if (dac[| 1] == 0)
{
    //riya, 12bit
    xp = $FFF;
    yp = $FFF;
}
else
{
    //error
    playing = false;
    dac = -1;
    laseron = false;
    dac_string = "[None]";
    show_message_async("Unexpected value, corrupt DAC data");
}
    
repeat (maxpointswanted)
    {
    //writing point
    buffer_write(ilda_buffer,buffer_u16,xp);
    buffer_write(ilda_buffer,buffer_u16,yp);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    }

maxpoints = maxpointswanted;
