if (verify_serial(false)) || (controller.adclosed)
    instance_destroy();
    
md5query = -1;
adquery = -1;
ad = choose(spr_ad1, spr_ad2, spr_ad3, spr_ad4);
highlight_close = false;

//todo?
/*if (!file_exists("ad1.png") || !file_exists("ad2.png") || !file_exists("ad3.png") || !file_exists("ad4.png"))
{
    adquery = http_get_file("https://raw.githubusercontent.com/Grix/ildagen/master/ads/ad1.png", "ad1.png");
    http_get_file("https://raw.githubusercontent.com/Grix/ildagen/master/ads/ad2.png", "ad2.png");
    http_get_file("https://raw.githubusercontent.com/Grix/ildagen/master/ads/ad3.png", "ad3.png");
    http_get_file("https://raw.githubusercontent.com/Grix/ildagen/master/ads/ad4.png", "ad4.png");
    exit;
}
else
{
    md5query = http_get_file("https://raw.githubusercontent.com/Grix/ildagen/master/ads/md5.ini", "md5.ini");
}*/

alarm[0] = 2;

