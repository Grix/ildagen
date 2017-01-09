///load_profile([dont update caches])

load_profile_temp(controller.projector);

if (argument_count == 0)
{
    update_colors_scalesettings();
        
    with (obj_profiles)
        surface_free(surf_profilelist);
}
else if (!argument[0])
{ 
    update_colors_scalesettings();
    
    with (obj_profiles)
        surface_free(surf_profilelist);
}
