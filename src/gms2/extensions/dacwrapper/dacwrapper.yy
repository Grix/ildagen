{
  "optionsFile": "options.json",
  "options": [],
  "exportToGame": true,
  "supportedTargets": 194,
  "extensionVersion": "0.2.0",
  "packageId": "",
  "productId": "",
  "author": "",
  "date": "2017-09-14T08:51:35",
  "license": "Free to use, also for commercial games.",
  "description": "",
  "helpfile": "",
  "iosProps": false,
  "tvosProps": false,
  "androidProps": false,
  "installdir": "",
  "files": [
    {"filename":"RiyaNetServer.dll","origname":"extensions\\RiyaNetServer.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":1048640,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"EtherDream.dll","origname":"extensions\\EtherDream.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"dacwrapper.dll","origname":"extensions\\dacwrapper.dll","init":"InitDacwrapper","final":"FreeDacwrapper","kind":1,"uncompress":false,"functions":[
        {"externalName":"InitDacwrapper","kind":12,"help":"","hidden":false,"returnType":2,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"InitDacwrapper","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"FreeDacwrapper","kind":12,"help":"","hidden":false,"returnType":2,"argCount":0,"args":[],"resourceVersion":"1.0","name":"FreeDacwrapper","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ScanDevices","kind":12,"help":"dacwrapper_scandevices()","hidden":false,"returnType":2,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"dacwrapper_scandevices","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"DeviceOpen","kind":12,"help":"dacwrapper_opendevice(num)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"resourceVersion":"1.0","name":"dacwrapper_opendevice","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"OutputFrame","kind":12,"help":"dacwrapper_outputframe(num, pps, size, address)","hidden":false,"returnType":2,"argCount":4,"args":[
            2,
            2,
            2,
            1,
          ],"resourceVersion":"1.0","name":"dacwrapper_outputframe","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"Stop","kind":12,"help":"dacwrapper_stop(num)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"resourceVersion":"1.0","name":"dacwrapper_stop","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"GetName","kind":12,"help":"dacwrapper_getname(num)","hidden":false,"returnType":1,"argCount":1,"args":[
            2,
          ],"resourceVersion":"1.0","name":"dacwrapper_getname","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"SetName","kind":12,"help":"dacwrapper_setname(num,name)","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"dacwrapper_setname","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"GetFirmwareVersion","kind":12,"help":"dacwrapper_getfirmware(num)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"resourceVersion":"1.0","name":"dacwrapper_getfirmware","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"ReturnOne","kind":1,"help":"dacwrapper_returnone()","hidden":false,"returnType":2,"argCount":0,"args":[],"resourceVersion":"1.0","name":"dacwrapper_returnone","tags":[],"resourceType":"GMExtensionFunction",},
      ],"constants":[],"ProxyFiles":[
        {"TargetMask":1,"resourceVersion":"1.0","name":"libdacwrapper.dylib","tags":[],"resourceType":"GMProxyFile",},
        {"TargetMask":7,"resourceVersion":"1.0","name":"libdacwrapper.so","tags":[],"resourceType":"GMProxyFile",},
      ],"copyToTargets":194,"order":[
        {"name":"InitDacwrapper","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"FreeDacwrapper","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"dacwrapper_scandevices","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"dacwrapper_opendevice","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"dacwrapper_outputframe","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"dacwrapper_stop","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"dacwrapper_getname","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"dacwrapper_setname","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"dacwrapper_getfirmware","path":"extensions/dacwrapper/dacwrapper.yy",},
        {"name":"dacwrapper_returnone","path":"extensions/dacwrapper/dacwrapper.yy",},
      ],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"EasyLase.dll","origname":"extensions\\EasyLase.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"EzAudDac.dll","origname":"extensions\\EzAudDac.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"OLSC_EasyLase.dll","origname":"extensions\\OLSC_EasyLase.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"OLSC_EzAudDac.dll","origname":"extensions\\OLSC_EzAudDac.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"SDL.dll","origname":"extensions\\SDL.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"ftd2xx.dll","origname":"extensions\\ftd2xx.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"EzAudDacDEFAULT.ini","origname":"extensions\\EzAudDacDEFAULT.ini","init":"","final":"","kind":4,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":144150372447944768,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"libusb-1.0.0.dylib","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":2,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"OLSD.dll","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"OLSC.dll","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":35184372088896,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"libusb-1.0.dll","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":-1,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
  ],
  "classname": "",
  "tvosclassname": null,
  "tvosdelegatename": null,
  "iosdelegatename": null,
  "androidclassname": "",
  "sourcedir": "",
  "androidsourcedir": "",
  "macsourcedir": "",
  "maccompilerflags": "",
  "tvosmaccompilerflags": null,
  "maclinkerflags": "",
  "tvosmaclinkerflags": null,
  "iosplistinject": "",
  "tvosplistinject": null,
  "androidinject": "",
  "androidmanifestinject": "",
  "androidactivityinject": "",
  "gradleinject": "",
  "iosSystemFrameworkEntries": [],
  "tvosSystemFrameworkEntries": [],
  "iosThirdPartyFrameworkEntries": [],
  "tvosThirdPartyFrameworkEntries": [],
  "IncludedResources": [
    "Included Files\\dacwrapper.dll",
    "Included Files\\RiyaNetServer.dll",
  ],
  "androidPermissions": [],
  "copyToTargets": 194,
  "iosCocoaPods": "",
  "tvosCocoaPods": "",
  "iosCocoaPodDependencies": "",
  "tvosCocoaPodDependencies": "",
  "parent": {
    "name": "Extensions",
    "path": "folders/Extensions.yy",
  },
  "resourceVersion": "1.2",
  "name": "dacwrapper",
  "tags": [],
  "resourceType": "GMExtension",
}