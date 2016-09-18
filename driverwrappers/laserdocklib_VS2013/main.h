//visual studios 2013, windows 32bit DLL implementation of laserdock libraries

#include "LaserdockDeviceManager.h"
#include "LaserdockDevice.h"

#define EXPORT extern "C" __declspec (dllexport)

LaserdockDevice* laserdockDevice;
LaserdockDeviceManager* laserdockDeviceManager;
bool inited = false;
int previousRate = 0;
bool outputEnabled = false;

//opens connection, call before any other function
EXPORT bool initialize(); 

//send frame to dac (updating rate etc is handled in the function). 
//Data buffer struct can be found in LaserdockDevice.h.
//Length is number of points
//Rate is points per second
EXPORT bool sendFrame(uint8_t* data, uint32_t length, uint32_t rate);

//stop output until sendFrame is called again
EXPORT bool stop();

//close connection and free resources
EXPORT bool freeAll();
