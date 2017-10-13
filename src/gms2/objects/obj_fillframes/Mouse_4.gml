if (instance_exists(obj_dropdown))
    exit;
controller.fillframes = !controller.fillframes;

if (controller.fillframes == 1) 
    image_index = 0;
else 
    image_index = 1;
    
controller.refresh_minitimeline_flag = 1;

