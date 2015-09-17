//GM7 ONLY, GM8 see bottom
//export double FMODSnapShotToDsList(double startpos, double size, double ds)
//returns 0 on error; probable error because...
//... returns the variation of the data (maxv-minv) which can be used to normalise the data 

//This is the fastest means to get snapshot data because it populates a ds list

//FMODGroup/InstanceGetWave/SpectrumSnapshot2(...,1024)
//l = ds_list_create(); //MAKE SURE YOU DO THIS OR IT WILL BLOW UP!!!
//FMODSnapShotToDsList(0,1024,l)
//var i; i=0;
//repeat(ds_list_size(l))
//{
//  thevalue = ds_list_find_value(l,i);
//  i+=1;
//}
//ds_list_destroy(l); //it is faster to destroy and recreate lists than clearing them
//hack for Studio. may be better to use the string method
var i = 0;
repeat(argument1)
{
    ds_list_add(argument2,FMODGetSnapshotEntry(i+argument0))
    i+=1;
}
return 1;

return external_call(global.dll_FMODSnapShotToDsList,argument0,argument1,argument2);

/*
//////////////////////////////
//GM8 version
//export double FMODSnapShotToDsList(double startpos, double size, double ds)
//returns 0 on error; probable error because...
//... returns the variation of the data (maxv-minv) which can be used to normalise the data 

//This is the fastest means to get snapshot data because it populates a ds list

//FMODGroup/InstanceGetWave/SpectrumSnapshot2(...,1024)
//l = ds_list_create(); //MAKE SURE YOU DO THIS OR IT WILL BLOW UP!!!
//FMODSnapShotToDsList(0,1024,l)
//var i; i=0;
//repeat(ds_list_size(l))
//{
//  thevalue = ds_list_find_value(l,i);
//  i+=1;
//}
//ds_list_destroy(l); //it is faster to destroy and recreate lists than clearing them

var; i = argument0;
repeat(argument1)
{
    ds_list_add(argument2,FMODGetSnapshotEntry(i));
    i+=1;
}

//return external_call(global.dll_FMODSnapShotToDsList,argument0,argument1,argument2);
*/
