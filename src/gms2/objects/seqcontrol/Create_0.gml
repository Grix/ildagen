//alarm[0] = 2;
alarm[4] = 3000;

layer_list = ds_list_create_pool();
surface_list = ds_list_create_pool();
somaster_list = ds_list_create_pool();
somoving_list = ds_list_create_pool();
undo_list = ds_list_create_pool();
redo_list = ds_list_create_pool();
audio_buffer = -1;
parsebuffer = -1;
bufferIn = -1;
bufferOut = -1;
effect_list = ds_list_create_pool();
ilda_list = ds_list_create_pool();
buffer_list = ds_list_create_pool();
marker_list = ds_list_create_pool();
jump_button_list = ds_list_create_pool();
jump_button_list_midi = ds_list_create_pool();
timeline_surf = -1;
timeline_surf_temp = -1;
timeline_surf_audio_temp = -1;
timeline_surf_audio = -1;
frame_surf = -1;
frame3d_surf = -1;
frame_surf_large = -1;
frame3d_surf_large = -1;
copy_list = ds_list_create_pool();
envelope_copy_list_time = ds_list_create_pool();
envelope_copy_list_data = ds_list_create_pool();
env_type_map = ds_map_create();
playlist_list = ds_list_create_pool();
playlist_start_next_flag = false;
midi_keys_pressed = ds_list_create_pool();
multiple_undo_list = ds_list_create_pool();

last_save_time = get_timer();
high_performance = false;
frame_surf_refresh = 0;
image_speed = 0;
draw_mouseline = 0;
fastload = 1;
draw_cursorline = 0;
doubleclick = 0;    
frameprev = -1;
viewmode = 2;
selectedlayer = 0;
selectedx = 5;
song = -1;
songlength = 0;
volume = 100;
length = 1300;
projectfps = 50;
tooltip = "";
tlpos = 0; //in ms
parsingaudio = 0;
scrollbarx = 0;
scrollbarw = 0;
layerbary = 0;
layerbarw = 0;
scroll_moving = 0;
playbackspeed = 1;
getint = -1;
getstr = -1;
dialog = "";
drawcursorx = 0;
drawcursory = 0;
moving_object = 0;
moving_object_flag = 0;
audioshift = 0;
ypos_perm = 48;
muted = false;
songfile_name = "";
song_samplerate = 0;
song_parse = 0;
filepath = "";
mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;
stretch_flag = 0;
objecttomove = 0;
previous_marker_pos = 0;
loadprojectflag = false;
moving_object_ready = false;
intensity_scale = 1;
intensity_scale_midi_shortcut = -2;
volume_midi_shortcut = -2;
selected_slider = -1;
show_is_demo = false;
audio_fft_bass_low_cutoff = 0;
audio_fft_bass_high_cutoff = 5;
audio_fft_treble_low_cutoff = 40;
audio_fft_treble_high_cutoff = 150;
somaster_list_prevsize = 0;
envelope_undolist = -1;
envelopexpos = 0;
startframe = 0;
endframe = 2600;
startframex = -1;
endframex = -1;
largepreview = 0;
loop = false;
beats_shift = 0;
doubleclick_mousexprevious = mouse_x;
envelope_copy_duration = -1;
song_sync_bad_prev = false;
layer_new_id = 1;

tlsurf_y = 137;
tlw = 983; //width of timeline
tlh = 128-16; //height of audio part of timeline
tls = tlh+tlsurf_y+16; //start of layer area, seen from outside surface
lbh = 705-32-tlh-tlsurf_y;
lbsh = tlh+15+lbh; //start of bottom scrollbar, seen from inside surface
phi = 1.618;
tlzoom = tlw*2; //number of frames displayed in visible timeline area
tlx = 0;
tlhalf = tlh/2;
tlthird = tlh/3;

timeline_surf_pos = 0;
timeline_surf_tlzoom = tlzoom;
timeline_surf_length = 0;

c_gold = make_colour_rgb(255,220,0);

playing = 0;
deltatime = 0;
//framepoints = 0;
//frame_complexity = 0;

add_layer();

if (controller.has_midi)
{
	intensity_scale_midi_shortcut = 7; // volume ID
}

ds_map_add(env_type_map,"x","X");
ds_map_add(env_type_map,"y","Y");
ds_map_add(env_type_map,"size","Size");
ds_map_add(env_type_map,"rotabs","Rotation");
ds_map_add(env_type_map,"a","Intensity");
ds_map_add(env_type_map,"hue","Hue");
ds_map_add(env_type_map,"r","Red");
ds_map_add(env_type_map,"g","Green");
ds_map_add(env_type_map,"b","Blue");

FMODGMS_Sys_Create();
FMODGMS_Sys_Initialize(2);
play_sndchannel = FMODGMS_Chan_CreateChannel();

benchmark();

menu_string = "   File      Edit      Tools      View      About   ";
menu_width_start[0] = 0;
menu_width[0] = string_width("   File   ");
menu_width_start[1] = menu_width[0];
menu_width[1] = string_width("   Edit   ");
menu_width_start[2] = menu_width_start[1]+menu_width[1];
menu_width[2] = string_width("   Tools   ");
menu_width_start[3] = menu_width_start[2]+menu_width[2];
menu_width[3] = string_width("   View   ");
menu_width_start[4] = menu_width_start[3]+menu_width[3];
menu_width[4] = string_width("   About   ");
menu_width_start[5] = menu_width_start[4]+menu_width[4];

