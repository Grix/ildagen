with (seqcontrol)
{
	if (surface_exists(frame_surf))
		surface_free(frame_surf);
	if (surface_exists(frame3d_surf))
		surface_free(frame3d_surf);
	if (surface_exists(frame_surf_large))
		surface_free(frame_surf_large);
	if (surface_exists(frame3d_surf_large))
		surface_free(frame3d_surf_large)
	if (surface_exists(timeline_surf))
		surface_free(timeline_surf)
	if (surface_exists(timeline_surf_temp))
		surface_free(timeline_surf_temp)
	if (surface_exists(timeline_surf_audio_temp))
		surface_free(timeline_surf_audio_temp)
	if (surface_exists(timeline_surf_audio))
		surface_free(timeline_surf_audio)
}
with (controller)
{
	if (surface_exists(frame_surf))
		surface_free(frame_surf);
	if (surface_exists(frame3d_surf))
		surface_free(frame3d_surf);
	if (surface_exists(minitimeline_surf))
		surface_free(minitimeline_surf)	
}