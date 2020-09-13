function projectionwindow_reset() {
	with (controller)
	{
		scale_left_top = 0;
		scale_left_bottom = 0;
		scale_right_top = $FFFF;
		scale_right_bottom = $FFFF;
		scale_top_left = 0;
		scale_top_right = 0;
		scale_bottom_left = $FFFF;
		scale_bottom_right = $FFFF;
	}

	save_profile();



}
