/// colors_compare_cie94( color_one, color_two );

/*

Compare how different two colors are using the CIE94 formula. 

The value obtained is known as "Delta-E" (De).

The lower the number, the more similar the two colors are.

A value of 2.3 constitutes a "just noticeable difference".

See here for more information:
https://en.wikipedia.org/wiki/Color_difference

*/

// INITIALISE EVERYTHING


var chqColorA = argument0;
var chqColorB = argument1;

if (chqColorA == chqColorB) return 0;

var chqSimilarity = -1;
var chqR1 = color_get_red(chqColorA);
var chqG1 = color_get_green(chqColorA);
var chqB1 = color_get_blue(chqColorA);
var chqR2 = color_get_red(chqColorB);
var chqG2 = color_get_green(chqColorB);
var chqB2 = color_get_blue(chqColorB);

// CONVERT RGB1 TO XYZ1

chqR1 = chqR1 / 255;
chqG1 = chqG1 / 255;
chqB1 = chqB1 / 255;

if (chqR1 > 0.04045) {
    chqR1 = power(((chqR1 + 0.055)/1.055),2.4);
} else {
    chqR1 = chqR1 / 12.92;
}

if (chqG1 > 0.04045) {
    chqG1 = power(((chqG1 + 0.055)/1.055),2.4);
} else {
    chqG1 = chqG1 / 12.92;
}

if (chqB1 > 0.04045) {
    chqB1 = power(((chqB1 + 0.055)/1.055),2.4);
} else {
    chqB1 = chqB1 / 12.92;
}

chqR1*=100;
chqG1*=100;
chqB1*=100;

var chqX1 = (chqR1 * 0.4124) + (chqG1 * 0.3576) + (chqB1 * 0.1805);
var chqY1 = (chqR1 * 0.2126) + (chqG1 * 0.7152) + (chqB1 * 0.0722);
var chqZ1 = (chqR1 * 0.0193) + (chqG1 * 0.1192) + (chqB1 * 0.9505);

// CONVERT RGB2 TO XYZ2

chqR2 = chqR2 / 255;
chqG2 = chqG2 / 255;
chqB2 = chqB2 / 255;

if (chqR2 > 0.04045) {
    chqR2 = power(((chqR2 + 0.055)/1.055),2.4);
} else {
    chqR2 = chqR2 / 12.92;
}

if (chqG2 > 0.04045) {
    chqG2 = power(((chqG2 + 0.055)/1.055),2.4);
} else {
    chqG2 = chqG2 / 12.92;
}

if (chqB2 > 0.04045) {
    chqB2 = power(((chqB2 + 0.055)/1.055),2.4);
} else {
    chqB2 = chqB2 / 12.92;
}

chqR2*=100;
chqG2*=100;
chqB2*=100;

var chqX2 = (chqR2 * 0.4124) + (chqG2 * 0.3576) + (chqB2 * 0.1805);
var chqY2 = (chqR2 * 0.2126) + (chqG2 * 0.7152) + (chqB2 * 0.0722);
var chqZ2 = (chqR2 * 0.0193) + (chqG2 * 0.1192) + (chqB2 * 0.9505);

// CONVERT XYZ1 to CIE-LAB1

chqX1 = chqX1 / 95.047;
chqY1 = chqY1 / 100;
chqZ1 = chqZ1 / 108.883;

if (chqX1 > 0.008856) {
    chqX1 = power(chqX1,1/3);
} else {
    chqX1 = (7.787*chqX1) + (16 / 116);
}

if (chqY1 > 0.008856) {
    chqY1 = power(chqY1,1/3);
} else {
    chqY1 = (7.787*chqY1) + (16 / 116);
}

if (chqZ1 > 0.008856) {
    chqZ1 = power(chqZ1,1/3);
} else {
    chqZ1 = (7.787*chqZ1) + (16 / 116);
}

var chqL1 = (116 * chqY1) - 16;
var chqA1 = 500 * (chqX1 - chqY1);
var chqB1 = 200 * (chqY1 - chqZ1);

// CONVERT XYZ2 to CIE-LAB2

chqX2 = chqX2 / 95.047;
chqY2 = chqY2 / 100;
chqZ2 = chqZ2 / 108.883;

if (chqX2 > 0.008856) {
    chqX2 = power(chqX2,1/3);
} else {
    chqX2 = (7.787*chqX2) + (16 / 116);
}

if (chqY2 > 0.008856) {
    chqY2 = power(chqY2,1/3);
} else {
    chqY2 = (7.787*chqY2) + (16 / 116);
}

if (chqZ2 > 0.008856) {
    chqZ2 = power(chqZ2,1/3);
} else {
    chqZ2 = (7.787*chqZ2) + (16 / 116);
}

var chqL2 = (116 * chqY2) - 16;
var chqA2 = 500 * (chqX2 - chqY2);
var chqB2 = 200 * (chqY2 - chqZ2);

// FINALLY, RUN THE COLOR COMPARISON USING CIE94

var chqDeltaL = chqL1 - chqL2;
var chqC1 = sqrt(max(power(chqA1,2)+power(chqB1,2),0));
var chqC2 = sqrt(max(power(chqA2,2)+power(chqB2,2),0));
var chqCAB = chqC1 - chqC2;
var chqHAB = sqrt(max(power(chqA1 - chqA2,2)+power(chqB1 - chqB2,2)-power(chqCAB,2),0));

var chqEquation1 = power(chqDeltaL,2);
var chqEquation2 = power(chqCAB/(1+(0.045*chqC1)),2);
var chqEquation3 = power(chqHAB/(1+(0.015*chqC1)),2);

chqSimilarity = sqrt(max(chqEquation1 + chqEquation2 + chqEquation3,0));

return chqSimilarity;
