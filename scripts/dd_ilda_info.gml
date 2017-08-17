if !(controller.regflag)
{
    if file_exists("serial")
    {
        controller.registeredstring = "Full Edition. Thank you for purchasing!";
        controller.regflag = 1;
    }
    else
    {
        controller.registeredstring = "Free Edition.";
        controller.regflag = 1;
    }
}
    
controller.message = 
"LaserShowGen - ILDA laser frame creation tool#"+
"Created by Gitle Mikkelsen / Grix / gitlem@gmail.com##"+
"See manual for list of credits and licenses.##"+
"Version: "+string(controller.version)+
"#Released on: "+string(controller.versiondate)+
"##"+controller.registeredstring;

show_message_new(controller.message);
