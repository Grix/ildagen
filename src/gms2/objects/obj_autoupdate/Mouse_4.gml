if (instance_exists(obj_dropdown))
    exit;
if (file_exists(ini_filename))
{
    ini_open(ini_filename);
    updatecheckenabled = ini_read_real("main","updatecheck", 1);
    updatecheckenabled = !updatecheckenabled;
    ini_write_real("main","updatecheck",updatecheckenabled);
    ini_close();
}
image_index = updatecheckenabled;

