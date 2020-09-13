/// @description FMODGMS_Util_SecondsToSamples(seconds, samplingRate)
/// @function FMODGMS_Util_SecondsToSamples
/// @param seconds
/// @param  samplingRate
function FMODGMS_Util_SecondsToSamples() {

	// Converts time measured in seconds to samples. Can be used in conjuction with FMODGMS_Snd_Set_LoopPoints
	// for precise loop point control.

	{
	    return argument[0] * argument[1];
	}



}
