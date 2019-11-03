g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserdockDeviceManager.cpp
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserdockDeviceManager_desktop.cpp 
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserdockDevice_desktop.cpp 
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserdockDevice.cpp
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/Device_LaserDock.cpp
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/HeliosDac.cpp
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/Device_Helios.cpp
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/plt-posix.c
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/idn.cpp
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/Device_IDN.cpp
gcc -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/etherdream.c
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/Device_Etherdream.cpp
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/dacwrapper.cpp
g++ -shared -o libdacwrapper.so ./dacwrapper.o ./LaserdockDevice.o ./LaserdockDevice_desktop.o ./LaserdockDeviceManager.o ./LaserdockDeviceManager_desktop.o ./Device_LaserDock.o ./HeliosDac.o ./Device_Helios.o ./plt-posix.o ./idn.o ./Device_IDN.o ./etherdream.o ./Device_Etherdream_unix.o ./libusb-1.0.so



