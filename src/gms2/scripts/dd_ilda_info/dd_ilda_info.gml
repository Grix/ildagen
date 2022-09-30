function dd_ilda_info() {
	if (verify_serial(false))
	{
	    controller.registeredstring = "Pro edition registered. Thank you for purchasing!";
	}
	else
	{
	    controller.registeredstring = "Free Edition.";
	}
	
    
	controller.message = 
	"LaserShowGen - Laser show editor and player\n"+
	"Created by Gitle Mikkelsen / gitle@bitlasers.com\n\n"+
	"See manual for list of credits and licenses.\n\n"+
	"Version: "+string(controller.version)+
	"\nReleased on: "+string(controller.versiondate)+
	"\n\n"+controller.registeredstring;

	show_message_new(controller.message);



}
