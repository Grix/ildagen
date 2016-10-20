//splitting timeline objects
tlpostemp = tlpos;

if (instance_exists(oDropDown))
    tlpos = round(tlx+oDropDown.x/tlw*tlzoom)/projectfps*1000;

split_timelineobject();

tlpos = tlpostemp;
