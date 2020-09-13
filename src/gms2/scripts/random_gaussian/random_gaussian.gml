/// @description random_gaussian(mean,standard deviation)
/// @function random_gaussian
/// @param mean
/// @param standard deviation
function random_gaussian(argument0, argument1) {
	//generates a random number around the mean with a gaussian probability

	gml_pragma("forceinline");
	return argument0 + argument1*sqrt(-2*ln(random(1)))*cos(random(2*pi));



}
