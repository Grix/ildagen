{
  "resourceType": "GMExtension",
  "resourceVersion": "1.2",
  "name": "dacwrapper",
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
  "html5Props": false,
  "installdir": "",
  "files": [
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"RiyaNetServer.dll","origname":"extensions\\RiyaNetServer.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"EtherDream.dll","origname":"extensions\\EtherDream.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":64,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"dacwrapper.dll","origname":"extensions\\dacwrapper.dll","init":"InitDacwrapper","final":"FreeDacwrapper","kind":1,"uncompress":false,"functions":[
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"InitDacwrapper","externalName":"InitDacwrapper","kind":12,"help":"","hidden":false,"returnType":2,"argCount":-1,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"FreeDacwrapper","externalName":"FreeDacwrapper","kind":12,"help":"","hidden":false,"returnType":2,"argCount":0,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"dacwrapper_scandevices","externalName":"ScanDevices","kind":12,"help":"dacwrapper_scandevices()","hidden":false,"returnType":2,"argCount":-1,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"dacwrapper_opendevice","externalName":"DeviceOpen","kind":12,"help":"dacwrapper_opendevice(num)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"dacwrapper_outputframe","externalName":"OutputFrame","kind":12,"help":"dacwrapper_outputframe(num, pps, size, address)","hidden":false,"returnType":2,"argCount":4,"args":[
            2,
            2,
            2,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"dacwrapper_stop","externalName":"Stop","kind":12,"help":"dacwrapper_stop(num)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"dacwrapper_getname","externalName":"GetName","kind":12,"help":"dacwrapper_getname(num)","hidden":false,"returnType":1,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"dacwrapper_setname","externalName":"SetName","kind":12,"help":"dacwrapper_setname(num,name)","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"dacwrapper_getfirmware","externalName":"GetFirmwareVersion","kind":12,"help":"dacwrapper_getfirmware(num)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"dacwrapper_returnone","externalName":"ReturnOne","kind":1,"help":"dacwrapper_returnone()","hidden":false,"returnType":2,"argCount":0,"args":[],"documentation":"",},
      ],"constants":[],"ProxyFiles":[
        {"resourceType":"GMProxyFile","resourceVersion":"1.0","name":"libdacwrapper.dylib","TargetMask":1,},
        {"resourceType":"GMProxyFile","resourceVersion":"1.0","name":"libdacwrapper.so","TargetMask":7,},
      ],"copyToTargets":194,"usesRunnerInterface":false,"order":[
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
      ],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"EasyLase.dll","origname":"extensions\\EasyLase.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"EzAudDac.dll","origname":"extensions\\EzAudDac.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"OLSC_EasyLase.dll","origname":"extensions\\OLSC_EasyLase.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"OLSC_EzAudDac.dll","origname":"extensions\\OLSC_EzAudDac.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"SDL.dll","origname":"extensions\\SDL.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"ftd2xx.dll","origname":"extensions\\ftd2xx.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"EzAudDacDEFAULT.ini","origname":"extensions\\EzAudDacDEFAULT.ini","init":"","final":"","kind":4,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":144115188075855872,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"libusb-1.0.0.dylib","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":2,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"OLSD.dll","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"OLSC.dll","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"libusb-1.0.dll","origname":"","init":"","final":"","kind":1,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":-1,"usesRunnerInterface":false,"order":[],},
  ],
  "HTML5CodeInjection": "",
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
  "tvosplistinject": "",
  "androidinject": "",
  "androidmanifestinject": "",
  "androidactivityinject": "",
  "gradleinject": "",
  "androidcodeinjection": "",
  "hasConvertedCodeInjection": true,
  "ioscodeinjection": "",
  "tvoscodeinjection": "",
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
}