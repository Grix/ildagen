///@description sSendNoteOn(channel,note,velocity)
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sMIDISendNoteOn(channel,note,velocity){

	channel += 144//note on is 144 + channel
	
	rtmidi_send_message(channel,note,velocity)
}