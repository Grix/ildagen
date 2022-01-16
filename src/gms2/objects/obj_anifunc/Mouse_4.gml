if (instance_exists(obj_dropdown))
    exit;
if (!_visible)
    exit;

switch (floor( (mouse_x-x)/(255/9)))
{
    case 0: controller.anifunc = "saw"; break;
    case 1: controller.anifunc = "tri"; break;
    case 2: controller.anifunc = "easeout"; break;
    case 3: controller.anifunc = "easein"; break;
    case 4: controller.anifunc = "easeinout"; break;
    case 5: controller.anifunc = "cos"; break;
	case 6: controller.anifunc = "sine"; break;
    case 7: controller.anifunc = "bounce"; break;  
    case 8: controller.anifunc = "step"; break;  
}
    
switch (controller.anifunc)
{
    case "saw": image_index = 0; break;
    case "tri": image_index = 1; break;
    case "easeout": image_index = 2; break;
    case "easein": image_index = 3; break;
    case "easeinout": image_index = 4; break;
    case "cos": image_index = 5; break;
    case "sine": image_index = 6; break;
    case "bounce": image_index = 7; break;
    case "step": image_index = 8; break;
}

