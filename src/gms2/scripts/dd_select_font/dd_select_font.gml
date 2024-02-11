// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_select_font()
{
	file = file_find_first("fonts/*.ild", 0);
	num = 0;
	while (file != "")
	{
		if (num == argument[0])
		{
			log("Imported font: ", num);
			file = "fonts/" + file;
			controller.selected_font_name = filename_change_ext(filename_name(file), "");
			with (controller) 
				import_font(file);
		}
		
		num++;
		file = file_find_next();
	}
}