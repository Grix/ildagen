/// @description load_profile([dont update caches])
/// @function load_profile
/// @param [dont update caches]

load_profile_temp(controller.projector);

if (argument_count == 0)
{
    update_colors_scalesettings();
        
	if (instance_exists(obj_profiles))
		surface_free(obj_profiles.surf_profilelist);
}
else if (!argument[0])
{ 
    update_colors_scalesettings();
    
	if (instance_exists(obj_profiles))
		surface_free(obj_profiles.surf_profilelist);
}
