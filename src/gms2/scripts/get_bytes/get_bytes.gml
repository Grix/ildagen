function get_bytes() {
	//returns two next bytes combined

	byte0 = get_byte();
	byte1 = buffer_peek(ild_file, i+1, buffer_u8);
	return((byte0 << 8) + byte1);



}
