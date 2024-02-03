///@description sMIDIPanic()
/*sends note off messages for all 128 notes on all 16 channels. MIDI takes a couple seconds to send
2048 messages due to limitations of the format, it was designed in the early 80s, so this probably
isn't something you want in regular use in a project for public release.
*/
function sMIDIPanic(){
	var i,j;
	for (i = 0; i < 16; i += 1){
		for (j = 0; j < 128; j += 1){
			sMIDISendNoteOff(i,j)
			}
		}
	}