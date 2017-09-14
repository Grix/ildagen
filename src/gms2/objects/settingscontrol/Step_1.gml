if (room != rm_options)
    exit;

minroomspeed = 60;

if (controller.laseron)
{
    if (controller.preview_testframe == 0)
    {
        if (controller.laseron)
        {
            if (!ds_exists(controller.dac,ds_type_list))
            {
                show_message_new("Error, DAC data missing");
                controller.laseron = false;
                controller.dac = -1;
            }
            else
                output_frame_settings();
        }
    }
    else if (controller.preview_testframe == 1)
    {
        with (controller)
        {
            if (!ds_exists(dac,ds_type_list))
            {
                show_message_new("Error, DAC data missing");
                laseron = false;
                dac = -1;
            }
            else
            {
                output_frame();
            }
        }
        minroomspeed = max(controller.projectfps,10);
    }
    else if (controller.preview_testframe == 2)
    {
        with (seqcontrol)
            output_frame_seq_all();
            
        minroomspeed = max(seqcontrol.projectfps,10);
    }
}

room_speed = controller.projectfps;
while (room_speed < minroomspeed)
    room_speed += controller.projectfps;

