if !(controller.regflag)
    {
    if file_exists("serial")
        {
        controller.registeredstring = "Registered. Thank you for purchasing!";
        controller.regflag = 1;
        }
    else
        {
        controller.registeredstring = "Not Registered. Exporting is disabled.";
        controller.regflag = 1;
        }
    }
    
controller.message = 
"LasershowGen - ILDA laser frame creation tool#"+
"Created by Gitle Mikkelsen / Grix / gitlem@gmail.com##"+
"See manual for list of credits and licenses.##"+
"Version: "+string(controller.version)+
"#Released on: "+string(controller.versiondate)+
"##"+controller.registeredstring;

show_message_async(controller.message);
