function parse_word(argument0) {
	minus = 1-2*((argument0 & $8000) == $8000);
	xpn = round(argument0 & $7FFF);
	return (xpn*minus);



}
