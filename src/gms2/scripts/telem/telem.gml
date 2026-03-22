function telem() {
	http_post_string(   "https://www.bitlasers.com/lasershowgen/check.php", 
	                    "serial=" + controller.serial + "&version=" + controller.version + "&os=" + string(os_type)+ "&pcid=" + string(os_get_info()[? "udid"]));



}
