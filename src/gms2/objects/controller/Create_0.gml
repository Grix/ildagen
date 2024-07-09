version = "2.0.3";
versiondate = "2024-07-09";

global.list_pool = ds_stack_create();
global.list_pool_is_taken = ds_map_create();

//gc_enable(false);

if (debug_mode)
{
    show_debug_overlay(1);
    gml_release_mode(false);
}
else
{
    gml_release_mode(true);
}

window_set_min_height(732);
window_set_min_width(1100);

//setup file handling system
FStemp = game_save_id;
if (os_type == os_windows) 
	FStemp+="temp\\";
else
{
	FStemp+="temp/"; //sometimes fails when linux? todo hardcode ~/.config/LaserShowGen/temp/
}

if (os_browser == browser_not_a_browser)
{
    if (directory_exists("temp"))
        directory_destroy("temp");
    directory_create("temp");
}

var t_dir = "";
//if (os_type == os_macosx)
//	t_dir = "datafiles/"
if (os_type != os_linux)
{
	if (!file_exists(t_dir+"settings.ini") && !file_exists("settings.ini"))
		file_copy(t_dir+"settings_default.ini", "settings.ini");
}
else
{
	if (!file_exists(game_save_id + "settings.ini"))
		file_copy("settings_default.ini", game_save_id + "settings.ini");
}

log("save location:",FStemp);

file_dropper_init();  // Causes problems in HTML5 export

// Dialog module settings, causes crash?
//widget_set_caption("LaserShowGen");
//widget_set_owner(window_handle());

//declarations and setup
//math_set_epsilon(0.00001);
//ds_set_precision(0.00001); 
draw_set_circle_precision(24);
application_surface_enable(false);
draw_set_font(fnt_tooltip);
draw_set_color(c_black);

instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3], "foreground", obj_cursor);

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

el_list = ds_list_create_pool();
undo_list = ds_list_create_pool();
redo_list = ds_list_create_pool();
frame_surf = -1;
frame3d_surf = -1;
frame_list = ds_list_create_pool();
ds_list_add(frame_list,el_list);
free_list = ds_list_create_pool();
bez_list = ds_list_create_pool();
font_list = ds_list_create_pool();
font_map = ds_map_create();
snap_list = ds_list_create_pool();
minitimeline_surf = -1;
hershey_preview_surf = -1;
copy_list = -1;
semaster_list = ds_list_create_pool();
hershey_index_list = ds_list_create_pool();
hershey_list = -1;
menu_surf = -1;
dac_list = ds_list_create_pool();
blindzone_list = ds_list_create_pool();
profile_list = ds_list_create_pool();
list = ds_list_create_pool();
emptyliststring = ds_list_write(list);
ds_list_free_pool(list);
radialgrid_surf = -1;
squaregrid_surf = -1;
edit_recording_list = -1;
action_history_list = ds_list_create_pool();

c_gold = make_colour_rgb(255,220,0);
c_ltltgray = make_colour_rgb(239,235,235);

window_set_color(c_ltltgray);

adclosed = false;
dac = -1;
laseron = false;
laseronfirst = false;
el_id = 2;
projectfps = 50;
xdelta[64] = 0;
playing = 0;
update_verbose = 0;
updatereceived = 0;
serial = "";
frame_surf_refresh = 0;
refresh_minitimeline_flag = 1;
letter = "";
image_speed = 0;
font_type = -1;
selected_font_name = "";
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
update_semasterlist_flag = 0;
doubleclick = 0;
last_room = rm_seq;
last_room_2 = rm_ilda;
releasenotes = "";
filepath = "";
warning_suppress = false;
warning_disable = false;
bug_report_suppress = false;
force_io_reset = false;
known_filename_of_load = "";
has_midi = false;
midi_input_device = 0;
midi_output_device = 0;
use_bpm = true;
bpm = 120;
bpm_timeline_offset_frames = 0;
beats_per_bar = 4;

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
if (os_type != os_linux)
	ini_open("settings.ini");
else
	ini_open(game_save_id + "settings.ini");
dpi_scaling = ini_read_real("main", "dpi_scaling_override", 0);
if (dpi_scaling == 0 || dpi_scaling == -1)
	dpi_multiplier = clamp(min( ceil(display_get_height()/(735*2.05)), ceil(display_get_width()/(1350*2)) ),1,3);
else
	dpi_multiplier = dpi_scaling;
ini_close();
default_window_w = 1350*dpi_multiplier;
default_window_h = 735*dpi_multiplier;
log("window size", default_window_w, default_window_h);

tooltip = "";
tooltip_warning = "";
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
tab_cycles_all = 0;
enable_dynamic_fps = 1;
preview_while_laser_on = 0;

global.loading_exportproject = 0;
global.loading_exportilda = 0;
global.loading_exportildahtml5 = 0;
global.loading_saveproject = 0;
global.loading_loadproject = 0;
global.loading_saveliveproject = 0;
global.loading_loadliveproject = 0;
global.loading_importilda = 0;
global.loading_importfont = 0;
global.loading_importildaseq = 0;
global.loading_importildalive = 0;
global.loading_importfolderlive = 0;

opt_onlyblanking = false;
opt_maxdist = 150;
opt_maxdwell = 3;
opt_maxdwell_blank = 1;
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
intensity_master_scale = 1;
red_scale_lower = 0;
blue_scale_lower = 0;
green_scale_lower = 0;
angle_prev = 0;
dotstrength = 1;
scale_left_top = $1000;
scale_left_bottom = $1000;
scale_right_top = $EFFF;
scale_right_bottom = $EFFF;
scale_top_left = $1000;
scale_top_right = $1000;
scale_bottom_left = $EFFF;
scale_bottom_right = $EFFF;
opt_per_point = true;

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
font_spacing = 1;
preview_testframe = 0; //0: testframe, 1: editor mode, 2: timeline mode
editing_type = 0; //0: A to B, 1: Record/Custom
editing_path_normalized = true;

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
anireverse = false;

rot = 0;
anirot = 0;
anirot_raw = 0;
scalex = 1;
scaley = 1;
aniscalex = 1;
aniscaley = 1;
swapxy = false;
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
fpsmultiplier = 1;
endx = 0;
endy = 0;

quicktip_closed_list = ds_list_create_pool();

shapefunc_cp = 100;
shapefunc_string_x = "";
shapefunc_string_y = "";
colorfunc_string_1 = "";
colorfunc_string_2 = "";
colorfunc_string_3 = "";
blankfunc_string = "";

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

tab_menu_string = "   Settings      Grid View      Timeline      Editor   ";
tab_menu_width_start[0] = 0;
tab_menu_width[0] = string_width("   Editor   ");
tab_menu_width_start[1] = tab_menu_width[0];
tab_menu_width[1] = string_width("   Timeline   ");
tab_menu_width_start[2] = tab_menu_width_start[1]+tab_menu_width[1];
tab_menu_width[2] = string_width("   Grid View   ");
tab_menu_width_start[3] = tab_menu_width_start[2]+tab_menu_width[2];
tab_menu_width[3] = string_width("   Settings   ");
tab_menu_width_start[4] = tab_menu_width_start[3]+tab_menu_width[3];

randomize();

init_palette();

rtmidi_init();
var t_num_midi = rtmidi_probe_ins();
if (t_num_midi > 0)
{
	log(rtmidi_name_in(0));
	rtmidi_set_inport(0);
	has_midi = true;
}

if (os_browser == browser_not_a_browser)
{
    update_check();
    alarm[7] = 2; // parse parameters and load settings after everything has inited
}

verify_serial(false);
telem();

//var t_resolution_log = file_text_open_append("resolution_log.txt");
//file_text_write_string(t_resolution_log, string(window_get_width()) + "," + string(window_get_height()) + "," + string(display_get_width()) + "," + string(display_get_height()) + "," + string(display_get_dpi_x()) + "\n");
//file_text_close(t_resolution_log);

//ex_patch_window_close_capture(1);
window_command_hook(window_command_close);  // Causes problems in HTML5 export

if (!debug_mode)
{
	log("Creating exception handler");
	exception_unhandled_handler(function(ex)
	{
	    var _f = file_text_open_append("crash.txt");
	    file_text_write_string(_f, string(ex));
	    file_text_close(_f);
	
		var t_actionhistory = get_action_history_string();
		http_post_string(   "https://www.bitlasers.com/lasershowgen/bugreport.php",
		                    "bug=OS: " + string(os_type) + " VER: "+string(controller.version) + "\r\n"+t_actionhistory + "\r\n"+string_replace_all(string_replace_all(string(ex),"\"",""),"'",""));
	
		show_message("ERROR: LaserShowGen has unfortunately encountered a problem and must close. This bug has been logged and reported (anonymously) to the developer, and we will work to fix this problem in future releases.\n\nIf you wish to save your unsaved work, you will now be asked for a file location. NB: Please don't overwrite your existing file as the crash may cause problems in the new backup file.");
	
		if (room == rm_seq)
		{
			with (seqcontrol)
				save_project_noloading();
		}
		else if (room == rm_live)
		{
			with (livecontrol)
				save_live_project_noloading();
		}
		else
		{
			with (controller)
				save_frames();
		}
	});
}
