if (moving)
{
    redy_upper = y+52-controller.red_scale*52;
    greeny_upper = y+52-controller.green_scale*52;
    bluey_upper = y+52-controller.blue_scale*52;
    
    redy_lower = y+52-controller.red_scale_lower*52;
    greeny_lower = y+52-controller.green_scale_lower*52;
    bluey_lower = y+52-controller.blue_scale_lower*52;
    
    save_profile();
}    


moving = 0;

