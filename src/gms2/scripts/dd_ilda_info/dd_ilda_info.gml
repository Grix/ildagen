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
"LaserShowGen - ILDA laser frame creation tool\n"+
"Created by Gitle Mikkelsen / gitlem@gmail.com\n\n"+
"See manual for list of credits and licenses.\n\n"+
"Version: "+string(controller.version)+
"\nReleased on: "+string(controller.versiondate)+
"\n\n"+controller.registeredstring;

show_message_new(controller.message);
