#define FS_gmfilesystem_initialize_detail
return FS_gmfilesystem_initialize(true);



#define _gmfilesystem_initialize
var exename = FS_guess_project_filename();
var location;
if (argument0) {
	location = "%localappdata%";
} else {
	location = "%appdata%";
}
FS_set_gm_save_area(location + "/" + exename);
FS_set_working_directory(location + "/" + exename);
return 0;



#define _guess_project_filename
///_guess_project_filename()
var c = parameter_count();

if (c < 1) return "";

var exename = string_delete(parameter_string(0), 1, FS_string_rpos("\", parameter_string(0)));
if (exename == "Runner.exe") {
    if (c >= 3) {
        if (parameter_string(1) ==  "-game") {
            exename = string_delete(parameter_string(2), 1, FS_string_rpos("\", parameter_string(2)));
        }
    }
} 
return string_copy(exename, 1,FS_string_rpos(".", exename)  - 1);



#define _string_rpos
///_string_rpos(substr, str)

/*
**  Usage:
**      string_rpos(substr,str)
**
**  Arguments:
**      substr      a substring of text
**      str         a string of text
**
**  Returns:
**      the right-most position of the given
**      substring within the given string
**
**  GMLscripts.com
*/
{
    var sub,str,pos,ind;
    sub = argument0;
    str = argument1;
    pos = 0;
    ind = 0;
    do {
        pos += ind;
        ind = string_pos(sub,str);
        str = string_delete(str,1,ind);
    } until (ind == 0);
    if (pos == 0) {
        pos = string_length(str);
    }
    return pos;
}

#define _buffer_save
///_buffer_save(ind, fname)
/**
*  _buffer_save(ind, fname)
* @argType    r, s
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("","");
buffer_save(argument0, fname);
return FS_export_raw(fname, argument1);

#define _buffer_save_ext
///_buffer_save_ext(ind, fname, offset, size)
/**
*  _buffer_save_ext(ind, fname, offest, size)
* @argType    r, s, r, r
* @returnType real
* @hidden     false
*/
var fname = FS_unique_fname("","");
buffer_save_ext(argument0, fname, argument2, argument3);
return FS_export_raw(fname, argument1);

#define _buffer_load
///_buffer_load(fname)
///@argType s
///@returnType r

return buffer_load(FS_copy_fast(argument0));

#define _buffer_load_ext
///_buffer_load_ext(buffer, filename, offset)
///@argType r, s, r
///@returnType r
buffer_load_ext(argument0, FS_copy_fast(argument1), argument2);
return 0;




#define _background_add
/**
*  _background_add(fname, removeback, smooth)
* @argType    string, real, real
* @returnType real
* @hidden     false
*/
return background_add(FS_import_image(argument0),argument1,argument2);


#define _background_replace
/**
*  _background_replace(ind, fname, removeback, smooth)
* @argType    real, string, real, real
* @returnType real
* @hidden     false
*/
return background_replace(argument0,FS_import_image(argument1),argument2,argument3);


#define _background_save
/**
*  _background_save(ind, fname)
* @argType    r, s
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".png");
background_save(argument0, fname);
return FS_export_image(fname, argument1);


#define _background_save_adv
/**
*  _background_save_adv(ind, fname, param)
* @argType    r, s, r
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".png");
background_save(argument0, fname);
return FS_export_image_adv(fname, argument1, argument2);


#define _d3d_model_load
/**
* _d3d_model_load(ind, fname)
* @argType    r, s
* @returnType real
* @hidden     false
*/
return d3d_model_load(argument0, FS_copy_fast(argument1));



#define _d3d_model_save
/**
* _d3d_model_save(ind, fname)
* @argType    real, string
* @returnType real
* @hidden     false
*/
var fname = FS_unique_fname("",".txt");
d3d_model_save(argument0, fname);
return FS_export_raw(fname, argument1);


#define _screen_save
/**
* _screen_save(fname)
* @argType    string
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".bmp");
screen_save(fname);
return FS_export_image(fname, argument0);


#define _screen_save_adv
/**
* _screen_save_adv(fname, param)
* @argType    string, real
* @returnType real
*/
var fname = FS_unique_fname("",".bmp");
screen_save(fname);
return FS_export_image_adv(fname, argument0, argument1);


#define _screen_save_part
/**
* _screen_save_part(fname, x, y, w, h)
* @argType    string, r, r, r, r
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".bmp");
screen_save_part(fname,argument1, argument2, argument3, argument4);
return FS_export_image(fname, argument0);


#define _screen_save_part_adv
/**
* _screen_save_part_adv(fname, x, y, w, h, param)
* @argType    string, r, r, r, r, r
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".bmp");
screen_save_part(fname,argument1, argument2, argument3, argument4);
return FS_export_image_adv(fname, argument0, argument5);


#define _sound_add
/**
*  _sound_add(fname, kind, preload)
* @argType    string, real, real
* @returnType real
* @hidden     false
*/
return sound_add(FS_copy_fast(argument0),argument1,argument2);


#define _sound_replace
/**
*  _sound_replace(ind, fname, kind, preload)
* @argType    real, string, real, real
* @returnType real
* @hidden     false
*/
return sound_replace(argument0,FS_copy_fast(argument1),argument2,argument3);


#define _sprite_add
/**
*  _sprite_add(fname, subimg, removeback, smooth, xorig, yorig)
* @argType    string, real, real, real, real, real
* @returnType real
* @hidden     false
*/

return sprite_add(FS_import_image(argument0),argument1,argument2,argument3,argument4,argument5);


#define _sprite_replace
/**
*  _sprite_sprite_replace(ind, fname, subimg, removeback, smooth, xorig, yorig)
* @argType    real, string, real, real, real, real, real
* @returnType real
* @hidden     false
*/
return sprite_replace(argument0, FS_import_image(argument1),
            argument2,argument3,argument4,argument5,argument6);


#define _sprite_save
/**
*  _sprite_save(ind, subimg, fname)
* @argType    r, r, s
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".png");
sprite_save(argument0, argument1, fname);
return FS_export_image(fname, argument2);


#define _sprite_save_adv
/**
*  _sprite_save_adv(ind, subimg, fname, param)
* @argType    r, r, s, r
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".png");
sprite_save(argument0, argument1, fname);
return FS_export_image_adv(fname, argument2, argument3);


#define _sprite_save_strip
/**
* _sprite_save_strip(ind, fname)
* @argType    r, s
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".png");
sprite_save_strip(argument0,  fname);
return FS_export_image(fname, argument1);


#define _sprite_save_strip_adv
/**
* _sprite_save_strip_adv(ind, fname, param)
* @argType    r, s, r
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".png");
sprite_save_strip(argument0,  fname);
return FS_export_image_adv(fname, argument1, argument2);


#define _std_load
/**
* _std_load(script, fname)
* @argType    real, string
* @returnType real
* @hidden     false
*/
var file = FS_copy_fast(argument1);
return script_execute(argument0, file);


#define _std_load_arg
/**
* _std_load_arg(script, fname, argument)
* @argType    real, string, real
* @returnType real
* @hidden     false
*/
var fname = FS_copy_fast(argument1);

return script_execute(argument0, fname, argument2);


#define _std_save
/**
* _std_save(script, fname)
* @argType    real, string
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("","");
script_execute(argument1, fname);
return FS_export_raw(fname, argument0);


#define _std_save_arg
/**
* _std_save_arg(script, fname, argument)
* @argType    real, string, real
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("","");
script_execute(argument0, fname, argument2);
return FS_export_raw(fname, argument1);


#define _surface_save
/**
* _surface_save(id, fname)
* @argType    r, s,
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".bmp");
surface_save(argument0, fname);
return FS_export_image(fname, argument1);


#define _surface_save_adv
/**
* _surface_save_adv(id, fname, param)
* @argType    r, s, r
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".bmp");
surface_save(argument0, fname);
return FS_export_image_adv(fname, argument1, argument2);


#define _surface_save_part
/**
* _surface_save_part(id, fname, x, y, w, h)
* @argType    r, s, r, r, r, r
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".bmp");
surface_save_part(argument0, fname, argument2, argument3, argument4, argument5);
return FS_export_image(fname, argument1);


#define _surface_save_part_adv
/**
* _surface_save_part_adv(id, fname, x, y, w, h, param)
* @argType    r, s, r, r, r, r, r
* @returnType real
* @hidden     false
*/

var fname = FS_unique_fname("",".bmp");
surface_save_part(argument0, fname, argument2, argument3, argument4, argument5);
return FS_export_image_adv(fname, argument1, argument6);


