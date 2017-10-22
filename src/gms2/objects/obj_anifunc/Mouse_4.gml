if (instance_exists(obj_dropdown))
    exit;
if (!_visible)
    exit;

switch (floor( (mouse_x-x)/32.14))
{
    case 0: controller.anifunc = "saw"; break;
    case 1: controller.anifunc = "tri"; break;
    case 2: controller.anifunc = "easeout"; break;
    case 3: controller.anifunc = "easein"; break;
    case 4: controller.anifunc = "easeinout"; break;
    case 5: controller.anifunc = "sine"; break;
    case 6: controller.anifunc = "bounce"; break;  
}
    
switch (controller.anifunc)
{
    case "saw": image_index = 0; break;
    case "tri": image_index = 1; break;
    case "easeout": image_index = 2; break;
    case "easein": image_index = 3; break;
    case "easeinout": image_index = 4; break;
    case "sine": image_index = 5; break;
    case "bounce": image_index = 6; break;
}

