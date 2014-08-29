main_surface = argument0;
t = surface_create( surface_get_width( main_surface ), surface_get_height( main_surface ) )
for( i = 0; i < surface_get_height( main_surface ); i += 1 )
surface_copy_part( t, 0, i, main_surface, 0, surface_get_height( main_surface )-1-i, surface_get_width( main_surface ), 1 )
surface_copy(main_surface,0,0,t)
surface_free(t)
