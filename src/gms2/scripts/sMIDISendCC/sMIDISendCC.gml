///@description sSendCC(channel,number,value)

function sMIDISendCC(channel,number,value){

	channel += 176//CC change is 176 + channel
	
	rtmidi_send_message(channel,number,value)
}