if (room != rm_loading && last_room != room)
{
	last_room_2 = last_room;
	last_room = room;
}

if (laseron)
    dac_blank_and_center_all();

refresh_minitimeline_flag = 1;
frame_surf_refresh = 1;
update_semasterlist_flag = 1;
if (!seqcontrol.playlist_start_next_flag)
	laseron = false;
menu_open = 0;
dialog_open = 0;
playing = false;
with (seqcontrol)
{
    playing = false;
    frame_surf_refresh = true;
    output_buffer_ready = false;
    if (song != -1)
        FMODGMS_Chan_PauseChannel(play_sndchannel);
}
output_buffer_ready = false;

forceresize = true;

if (room == rm_ilda)
    window_set_caption("LaserShowGen - Editor Mode");
else if (room == rm_seq)
    window_set_caption("LaserShowGen - Timeline Mode");
else if (room == rm_live)
    window_set_caption("LaserShowGen - Grid View");
else if (room == rm_options)
    window_set_caption("LaserShowGen - Settings");
else if (room == rm_loading)
    window_set_caption("LaserShowGen - Working...");

