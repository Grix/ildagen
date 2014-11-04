controller.onion_number = clamp(get_integer("Enter the number of previous frames to preview",controller.onion_number),1,controller.maxframes);
with (controller) refresh_surfaces();
