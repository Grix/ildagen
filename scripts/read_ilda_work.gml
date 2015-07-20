//works its way through an ilda file

while (1)
    {
    action = read_ilda_header();
    if (action == 1)
        {
        el_id++;
        exit;
        }
    read_ilda_frame();
    }