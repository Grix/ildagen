if (laseron)
    dac_blank_and_center_all();

refresh_miniaudio_flag = 1;
frame_surf_refresh = 1;
laseron = false;
menu_open = 0;
dialog_open = 0;
playing = false;
with (seqcontrol)
{
    playing = false;
    frame_surf_refresh = true;
    output_buffer_ready = false;
    if (song != 0)
        FMODGMS_Chan_PauseChannel(songinstance);
}
output_buffer_ready = false;

if (room == rm_ilda)
    window_set_caption("LaserShowGen - Editor Mode");
else if (room == rm_seq)
    window_set_caption("LaserShowGen - Timeline Mode");
else if (room == rm_options)
    window_set_caption("LaserShowGen - Settings");
else if (room == rm_loading)
    window_set_caption("LaserShowGen - Working...");

