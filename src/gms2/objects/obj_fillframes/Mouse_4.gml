if (instance_exists(oDropDown))
    exit;
controller.fillframes = !controller.fillframes;

if (controller.fillframes == 1) 
    image_index = 0;
else 
    image_index = 1;
    
controller.refresh_miniaudio_flag = 1;

