controller.onion_alpha = clamp(get_integer("Enter the max transparency of the previewed frames, from 0 to 1",controller.onion_alpha),0,1);
with (controller) refresh_surfaces();

