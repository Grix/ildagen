alarm[0] = 2;
alarm[4] = 600;

layer_list = ds_list_create();
_layer = ds_list_create();
ds_list_add(layer_list,_layer);
ds_list_add(_layer,ds_list_create()); //envelope list
ds_list_add(_layer,ds_list_create()); //elements list
ds_list_add(_layer,0); 
ds_list_add(_layer,0);
ds_list_add(_layer,"Layer 1");
ds_list_add(_layer,ds_list_create()); //dac list
timeline_surf_list = ds_list_create();

surface_list = ds_list_create();
somaster_list = ds_list_create();
somoving_list = ds_list_create();
undo_list = ds_list_create();
audio_list = ds_list_create();
effect_list = ds_list_create();
ilda_list = ds_list_create();
buffer_list = ds_list_create();
marker_list = ds_list_create();
timeline_surf = surface_create(1024,1024);
frame_surf = surface_create(512,512);
frame3d_surf = surface_create(512,512);
frame_surf_large = surface_create(1024,1024);
frame3d_surf_large = surface_create(1024,1024);
copy_list = ds_list_create();
copy_buffer = ds_list_create();
env_type_map = ds_map_create();

drawn = false;
frame_surf_refresh = 0;
image_speed = 0;
draw_mouseline = 0;
fastload = 1;
draw_cursorline = 0;
doubleclick = 0;    
frameprev = -1;
viewmode = 2;
selectedlayer = 0;
selectedx = 0;
song = -1;
songlength = 0;
volume = 100;
length = 1300;
projectfps = 30;
tooltip = "";
tlpos = 0;
parsingaudio = 0;
scrollbarx = 0;
scrollbarw = 0;
layerbarx = 0;
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

startframe = 0;
endframe = 1200;
startframex = -1;
endframex = -1;
largepreview = 0;
loop = false;

tlw = 982;
tlh = 128;
tls = tlh+138+16; //start of layer area, seen from outside surface
lbh = 705-32-tlh-138;
lbsh = tlh+16+lbh; //start of bottom scrollbar
phi = 1.618;
tlzoom = tlw;
tlx = 0;
tly = 0;
tlhalf = tlh/2;
tlthird = tlh/3;

ds_list_add(timeline_surf_list, tlzoom);
ds_list_add(timeline_surf_list, ds_list_create());

c_gold = make_colour_rgb(255,220,0);

playing = 0;
pos = 0;
deltatime = 0;

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
FMODGMS_Sys_Initialize(10);
play_sndchannel = FMODGMS_Chan_CreateChannel();
parse_sndchannel = FMODGMS_Chan_CreateChannel();
FMODGMS_Chan_Set_Mute(parse_sndchannel, true);

benchmark();

draw_set_font(fnt_tooltip);
menu_string = "   File      Properties      Edit      Tools      View      Settings      About   ";
menu_width_start[0] = 0;
menu_width[0] = string_width("   File   ");
menu_width_start[1] = menu_width[0];
menu_width[1] = string_width("   Properties   ");
menu_width_start[2] = menu_width_start[1]+menu_width[1];
menu_width[2] = string_width("   Edit   ");
menu_width_start[3] = menu_width_start[2]+menu_width[2];
menu_width[3] = string_width("   Tools   ");
menu_width_start[4] = menu_width_start[3]+menu_width[3];
menu_width[4] = string_width("   View   ");
menu_width_start[5] = menu_width_start[4]+menu_width[4];
menu_width[5] = string_width("   Settings   ");
menu_width_start[6] = menu_width_start[5]+menu_width[5];
menu_width[6] = string_width("   About   ");
menu_width_start[7] = menu_width_start[6]+menu_width[6];

