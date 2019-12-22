if (os_type == os_macosx)
	return (keyboard_check(91) || keyboard_check(92));
else
	return (keyboard_check(vk_control));