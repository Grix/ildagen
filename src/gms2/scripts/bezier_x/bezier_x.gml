function bezier_x(argument0) {
	//gets x pos in bezier curve
	//args: t

	t = argument0;
	return ((ax*t*t*t)+(bx*t*t)+(cx*t)+startx);



}
