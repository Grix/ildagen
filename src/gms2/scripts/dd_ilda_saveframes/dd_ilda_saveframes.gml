ilda_cancel();

with (controller) 
{
    if (os_browser == browser_not_a_browser)
        save_frames();
    else 
        ilda_dialog_string("saveframes","Enter the name of the LaserShowGen frames IGF file","example.igf");
}
