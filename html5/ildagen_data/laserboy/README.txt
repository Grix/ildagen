Note: To run LaserBoy, edit the file LaserBoy.bat so that it calls the executable (LaserBoy.exe in Windows) with the two arguments following that are the width and the height in pixels of the screen that LaserBoy will open and populate.

..........................................

LaserBoy is compiled (in Windows) with:

MinGW with GCC 4.7.2
http://www.mingw.org/

libSDL version 1.2.15.0
http://www.libsdl.org/

boost C++ version 1.53.0
http://www.boost.org/

using Dev-C++ dev environment
http://www.bloodshed.net/devcpp.html

..........................................

The Simple DirectMedia Layer (SDL for short) is a cross-platfrom library
designed to make it easy to write multi-media software, such as games and
emulators.

The Simple DirectMedia Layer library source code is available from:
http://www.libsdl.org/

This library is distributed under the terms of the GNU LGPL license:
http://www.gnu.org/copyleft/lesser.html

..........................................

LaserBoy, (since 03-22-2012), can be built in Mac-OSX!

1. Install xcode.
2. Install MacPorts.
3. Install SDL through MacPorts.
4. Install boost through MacPorts.
5. Go to the LaserBoy src folder in terminal and type:

bash# make -f Makefile.osx

..........................................
This version of LaserBoy, (since 12-08-2009), adds the /rescales/ directory under the ./txt/ directory and allows a user to make plain ASCII text file tables of 256 unique, even, signed short integers for LaserBoy wave color signal remapping.

..........................................

This version of LaserBoy, (since 10-15-2009), adds the /wtf/ directory and allows a user to save wtf files of any name and open them during the run of LaserBoy!

..........................................

This version of LaserBoy, (since 07-22-2009), deprecates the /cpp/ subdirectory. Now LaserBoy generated C++ files will be saved in the txt directory.

..........................................

This version of LaserBoy, (since 07-03-2009), changes some things about the directory structure inside the LaserBoy directory.

The subdirectory, /pal/ has been removed and a new subdirectory named /txt/ has been added. Saving palette information is now part of LaserBoy's new ability to save frames, frame sets, palettes and color tables in plain ASCII.

..........................................


This version of LaserBoy, (since 03-06-2009), changes some things about the directory structure inside the LaserBoy directory.

The directory names use to look like this:

bmp
cpp
dxf
ild
pal
src
wav
wav\ADAT
wav\split

Now LaserBoy will look for files in a directory structure that looks like this:

bmp
cpp
dxf
ild
pal
src
wav
wav\audio
wav\unformatted

Note:

The directories ADAT and split have been removed from inside of the wav directory.
Their contents should be combined inside the new unformatted directory.

Stereo audio wave recordings should be placed inside the audio directory.


..........................................


This version of LaserBoy, (10-26-2008), changes some things about the directory structure inside the LaserBoy directory.

The directory names use to look like this:

ADAT
bmp
cpp
dxf
frames
palettes
src
waves
waves\split

Now LaserBoy will look for files in a directory structure that looks like this:

bmp
cpp
dxf
ild
pal
src
wav
wav\ADAT
wav\split

Note:

The directory ADAT has been moved to inside of the wav directory.
The frames directory has been renamed ild.
The palettes directory has been renamed pal.
The waves directory has been renames wav.

I hope this doesn't mess up your stuff!

James.  :o)
