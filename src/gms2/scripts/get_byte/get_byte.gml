function get_byte() {
	//returns byte at pos i
	gml_pragma("forceinline");
	return buffer_peek(ild_file, i, buffer_u8);



}
