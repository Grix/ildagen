///dac_blank_and_center(dac list)

active_dac = argument0;

if (active_dac[| 1] == 0) //riya
{
    buffer_seek(controller.blank_frame, buffer_seek_start, 0);
    buffer_write(controller.blank_frame, buffer_u16, $800);
    buffer_write(controller.blank_frame, buffer_u16, $800);
    buffer_write(controller.blank_frame, buffer_u8, 0);
    buffer_write(controller.blank_frame, buffer_u8, 0);
    buffer_write(controller.blank_frame, buffer_u8, 0);
    buffer_write(controller.blank_frame, buffer_u8, 0);
    
    log(dac_riya_outputframe(active_dac[| 0], 10000, 1, buffer_get_address(controller.blank_frame)));
}

