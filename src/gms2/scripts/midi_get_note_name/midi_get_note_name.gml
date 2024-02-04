// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


global.midi_notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

function midi_get_note_name(note){

	var t_octave = floor((note / 12)) - 1;
	return global.midi_notes[(note % 12)]+string(t_octave);
}