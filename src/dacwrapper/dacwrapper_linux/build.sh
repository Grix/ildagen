g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserdockDeviceManager.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserdockDeviceManager_desktop.cpp  &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserdockDevice_desktop.cpp  &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserdockDevice.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/Device_LaserDock.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/LaserCubeNetwork.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/Device_LaserDockNetwork.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/HeliosDac.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/Device_Helios.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/plt-posix.c &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/idn.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/idnServerList.cpp &&
gcc -Wall -fPIC -O2 -c ../dacwrapper/etherdream.c &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/Device_Etherdream_unix.cpp &&
g++ -Wall -std=c++14 -fPIC -O2 -c ../dacwrapper/dacwrapper.cpp &&
g++ -shared -o libdacwrapper.so ./dacwrapper.o ./LaserdockDevice.o ./LaserdockDevice_desktop.o ./LaserdockDeviceManager.o ./LaserdockDeviceManager_desktop.o ./Device_LaserDock.o ./LaserCubeNetwork.o ./Device_LaserDockNetwork.o ./HeliosDac.o ./Device_Helios.o ./plt-posix.o ./idn.o ./idnServerList.o ./etherdream.o ./Device_Etherdream_unix.o ./libusb-1.0.so &&
patchelf --set-rpath '$ORIGIN' ./libdacwrapper.so

