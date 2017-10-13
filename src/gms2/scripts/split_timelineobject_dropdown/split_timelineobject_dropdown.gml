//splitting timeline objects
tlpostemp = tlpos;

if (instance_exists(obj_dropdown))
    tlpos = round(tlx+obj_dropdown.x/tlw*tlzoom)/projectfps*1000;

split_timelineobject();

tlpos = tlpostemp;
