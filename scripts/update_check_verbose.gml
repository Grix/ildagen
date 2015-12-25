if (os_browser != browser_not_a_browser) exit;

show_debug_message("Checking for updates");
updatereceived = 0;

with (controller)   
    {
    updatenotes = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/versionnotes.txt");
    }
