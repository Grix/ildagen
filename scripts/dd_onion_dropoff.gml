controller.onion_dropoff = clamp(get_integer("Enter the transparency dropoff factor per previewed frame, from 0 to 1",controller.onion_dropoff),0,1);
with (controller) refresh_surfaces();

