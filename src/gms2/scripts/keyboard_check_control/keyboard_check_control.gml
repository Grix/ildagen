function keyboard_check_control() {
	if (os_type == os_macosx)
		return ((keyboard_check(91) || keyboard_check(92)) && !keyboard_check(vk_alt));
	else
		return (keyboard_check(vk_control) && !keyboard_check(vk_alt));


}
