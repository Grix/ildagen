//FMODBlockerAddGMObjects (ObjectIndex or instance ID)
//adds all the objects of type ObjectIndex or the instance ID to the blocker system
with(argument0)
{
    //var binstance;
    binstance = FMODBlockerAdd(x,y,0,bbox_left,bbox_top,-10,bbox_right-1,bbox_bottom-1,10);
    //show_message(FMODErrorStr(FMODGetLastError()));
    //show_message(string(binstance ));
}