///@description sSendNoteOff(channel,note)
function sMIDISendNoteOff(channel,note){
	var velocity;
	velocity = 0//note off velocity isn't widely used, so just skip it to avoid issues

	channel += 128//note off is 128 + channel
	
	rtmidi_send_message(channel,note,velocity)
}