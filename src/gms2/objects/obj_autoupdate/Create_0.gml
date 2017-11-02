image_speed = 0;
ini_filename = "settings.ini";
if (file_exists(ini_filename))
{
    ini_open(ini_filename);
    updatecheckenabled = ini_read_real("main","updatecheck",0);
    ini_close();
}
image_index = updatecheckenabled;

