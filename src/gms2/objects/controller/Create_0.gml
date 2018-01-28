version = "1.6.3";
versiondate = "2018-01-28";

if (debug_mode)
{
    show_debug_overlay(1);
    gml_release_mode(false);
}
else
{
    gml_release_mode(true);
}

//setup file handling system
FStemp = game_save_id+"temp\\";
if (os_browser == browser_not_a_browser)
{
    if (directory_exists("temp"))
        directory_destroy("temp");
    directory_create("temp");
}

//declarations and setup
//math_set_epsilon(0.00001);
//ds_set_precision(0.00001); 
draw_set_circle_precision(24);
application_surface_enable(false);
draw_set_font(fnt_tooltip);
draw_set_color(c_black);

instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-23, "normal", obj_cursor);

varmap = ds_map_create();
//shape function
parser_shape = ML_InitParserScience(varmap);
    ML_AddVariable(parser_shape, "point", 0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_shape, "frame", 0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_shape, "startx", 0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_shape, "starty", 0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_shape, "endx", 0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_shape, "endy", 0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_shape, "width", $ffff, ML_VAL_REAL, 1);
    ML_AddVariable(parser_shape, "height", $ffff, ML_VAL_REAL, 1);
    ML_AddVariable(parser_shape, "max", $ffff, ML_VAL_REAL, 1);
    ML_AddFunction(parser_shape, "lerp", _ML_Lerp, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL);
    ML_AddFunction(parser_shape, "random", _ML_random, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL);
    ML_AddFunction(parser_shape, "random_normal", _ML_random_gauss, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL);
	ML_AddVariable(parser_shape, "audio_loudness", 0, ML_VAL_REAL, 1);
	ML_AddVariable(parser_shape, "audio_wave", 0, ML_VAL_REAL, 1);
	ML_AddVariable(parser_shape, "audio_spectrum", 0, ML_VAL_REAL, 1);
varmap = ds_map_create();
//color/blank function
parser_cb = ML_InitParserScience(varmap);
    ML_AddVariable(parser_cb, "point",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "frame",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "startx",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "starty",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "anchorx",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "anchory",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "endx",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "endy",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "pri_red",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "pri_green",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "pri_blue",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "sec_red",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "sec_green",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "sec_blue",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "x",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "y",0, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "max", 255, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "width", $ffff, ML_VAL_REAL, 1);
    ML_AddVariable(parser_cb, "height", $ffff, ML_VAL_REAL, 1);
    ML_AddFunction(parser_cb, "lerp", _ML_Lerp, ML_VAL_REAL,ML_VAL_REAL,ML_VAL_REAL,ML_VAL_REAL);
    ML_AddFunction(parser_cb, "random", _ML_random, ML_VAL_REAL,ML_VAL_REAL,ML_VAL_REAL);
    ML_AddFunction(parser_cb, "random_normal", _ML_random_gauss, ML_VAL_REAL,ML_VAL_REAL,ML_VAL_REAL);
	ML_AddVariable(parser_cb, "audio_loudness", 0, ML_VAL_REAL, 1);
	ML_AddVariable(parser_cb, "audio_wave", 0, ML_VAL_REAL, 1);
	ML_AddVariable(parser_cb, "audio_spectrum", 0, ML_VAL_REAL, 1);
    
alarm[3] = 120;

default_window_w = 1350;
default_window_h = 735;
window_set_size(default_window_w, default_window_h);

el_list = ds_list_create();
undo_list = ds_list_create();
frame_surf = -1;
frame3d_surf = -1;
frame_list = ds_list_create();
ds_list_add(frame_list,el_list);
free_list = ds_list_create();
bez_list = ds_list_create();
font_list = ds_list_create();
snap_list = ds_list_create();
minitimeline_surf = -1;
hershey_preview_surf = -1;
copy_list = -1;
semaster_list = ds_list_create();
hershey_index_list = ds_list_create();
hershey_list = -1;
menu_surf = -1;
dac_list = ds_list_create();
blindzone_list = ds_list_create();
profile_list = ds_list_create();
list = ds_list_create();
emptyliststring = ds_list_write(list);
ds_list_destroy(list);
radialgrid_surf = -1;
squaregrid_surf = -1;

c_gold = make_colour_rgb(255,220,0);
c_ltltgray = make_colour_rgb(236,236,236);

adclosed = false;
dac = -1;
laseron = false;
laseronfirst = false;
el_id = 2;
projectfps = 30;
xdelta[32] = 0;
playing = 0;
update_verbose = 0;
updatereceived = 0;
serial = "";
frame_surf_refresh = 0;
refresh_minitimeline_flag = 1;
letter = "";
image_speed = 0;
font_type = -1;
hershey_moving = 0;
hershey_scrollw = 19;
hershey_scrollx = 0;
hershey_scrollh = 4930;
hershey_selected = 0;
dialog_open = false;
regflag = false;
menu_open = 0;
updateget = -1;
updatenotes = -1;
file = -1;
show_ad = true;
show_tooltip = true;
framecursor_prev = 0;
show_framecursor_prev = false;
scope_moving = false;
highlight = false;
resizing_moving = 0;

sgridshow = 0;
rgridshow = 0;
sgriddouble = 0;
rgriddouble = 0;
guidelineshow = 0;
guidelinedouble = 0;
sgridnum = 16;

mouse_yprevious = mouse_y;
mouse_xprevious = mouse_x;

phi = 1.618;
tlw = 512;
tlh = 42;
tlorigo_x = 0;
tlorigo_y = 515;

tooltip = "";
bckimage = 0;
onion = 0;
onion_dropoff = 0.7;
onion_number = 2;
onion_alpha = 0.8;
scroll = 0;
viewmode = 0;
selectedelement = -1;
exp_optimize = 1;
exp_format = 5;
opt_warning_flag = 0;
getint = -1;
getstr = -1;
dialog = "";
selecting = 0;
scrollcursor_flag = 0;

global.loading_exportproject = 0;
global.loading_exportilda = 0;
global.loading_exportildahtml5 = 0;
global.loading_saveproject = 0;
global.loading_loadproject = 0;
global.loading_importilda = 0;
global.loading_importfont = 0;
global.loading_importildaseq = 0;

opt_onlyblanking = false;
opt_maxdist = 150;
opt_maxdwell = 2;
opt_maxdwell_blank = 2;
opt_blankshift = 0;
opt_redshift = 0;
opt_greenshift = 0;
opt_blueshift = 0;
opt_scanspeed = 30000;
invert_y = false;
invert_x = false;
projector = 0;
red_scale = 1;
blue_scale = 1;
green_scale = 1;
red_scale_lower = 0;
blue_scale_lower = 0;
green_scale_lower = 0;
angle_prev = 0;
dotstrength = 1;
scale_left_top = 0;
scale_left_bottom = 0;
scale_right_top = $FFFF;
scale_right_bottom = $FFFF;
scale_top_left = 0;
scale_top_right = 0;
scale_bottom_left = $FFFF;
scale_bottom_right = $FFFF;


placing = "line";
placing_select_last = "line";
object_select_hovering = 0;
startpos[1] = 0;
placing_status = 0;
wave_amp = 10000;
wave_period = 1;
pointx[20] = 0;
pointy[20] = 0;
wave_offset = 0;
bez_moving = 0;
font_size = 20;
preview_testframe = 0; //0: testframe, 1: editor mode, 2: timeline mode

resolution = "auto";
framepoints = 0;
frame_complexity = 0;

reap_color = 1;
reap_blank = 1;
reap_removeoverlap = 0;
reap_trans = 1;
reap_interpolate = 1;
rectxmax = 0;
rectxmin = 0;
rectymax = 0;
rectymin = 0;

colormode = "solid";
colormode2 = 0;
color1 = c_white;
color2 = c_white;
enddotscolor = c_red;
color_period = 8192;
color_freq = 1;
color_dc = 0.5;
color_offset = 0;
color_blendmode = 0; //0 replace, 1 add, 2 subtract

blankmode = "solid";
blankmode2 = 0;
blank_period = 8192;
blank_dc = 0.5;
blank_freq = 4;
blank = 0;
enddots = 0;
makedot = 0;
dotmultiply = 12;
blank_offset = 0;
blank_blendmode = 1; //0 replace, 1 and, 2 or, 3 xor

anienable = 0;
frame = 0;
framehr = 0;
frameprev = 0;
fillframes = 1;
maxframes = 1;
anicolor1 = c_white;
anicolor2 = c_white;
anienddotscolor = c_red;
anicolor_dc = 0.5;
aniblank_dc = 0.5;
aniblank_offset = 0;
anicolor_offset = 0;
aniwave_offset = 0;
anifunc = "saw";
aniwave_amp = 10000;
anirep = 1;

rot = 0;
anirot = 0;
scalex = 1;
scaley = 1;
aniscalex = 1;
aniscaley = 1;
anchorx = $8000;
anchory = $8000;
anixtrans = 0;
aniytrans = 0;
shaking = 0;
shaking_sdev = 1000;
anishaking_sdev = 1000;
scope_start = 0;
scope_end = 0;
objmoving = 0;
projectfps = 30;
fpsmultiplier = 1;
endx = 0;
endy = 0;

shapefunc_cp = 100;
shapefunc_string_x = "";
shapefunc_string_y = "";
colorfunc_string_1 = "";
colorfunc_string_2 = "";
colorfunc_string_3 = "";
blankfunc_string = "";

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

randomize();

init_palette();

if (os_browser == browser_not_a_browser)
{
    update_check();
    parse_parameter();
    load_settings();
}

verify_serial(false);
telem();

ex_patch_window_close_capture(1);


