//works its way through an ilda file
with (controller)
    {
    while (1)
        {
        if (read_ilda_header())
            {
            el_id++;
            global.loading_current = global.loading_end;
            exit;
            }
        
        if (format != 2)
            read_ilda_frame();
        
        if (get_timer()-global.loadingtimeprev >= 100000)
            {
            global.loading_current = frame_number;
            global.loadingtimeprev = get_timer();
            break;
            }
        }
    }

