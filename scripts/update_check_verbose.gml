if (os_browser != browser_not_a_browser) exit;

show_debug_message("Checking for updates")

with (controller)   
    {
    updateget = http_get("http://github.com/Grix/ildagen/raw/master/version.txt");
    }