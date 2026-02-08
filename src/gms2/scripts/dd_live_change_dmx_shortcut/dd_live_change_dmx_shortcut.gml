// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_live_change_dmx_shortcut(){

	livecontrol.selectedfile_dialog = livecontrol.selectedfile;
	live_dialog_num("dmx_shortcut","Enter the DMX trigger ID for this file (from 1 to 239) ", livecontrol.filelist[| livecontrol.selectedfile][| 14]);
}