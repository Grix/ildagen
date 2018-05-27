{
    "id": "9e729640-f691-4915-adbb-92931c5bcbd8",
    "modelName": "GMExtension",
    "mvc": "1.0",
    "name": "dacwrapper",
    "IncludedResources": [
        "Included Files\\dacwrapper.dll",
        "Included Files\\RiyaNetServer.dll"
    ],
    "androidPermissions": [
        
    ],
    "androidProps": false,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": 66,
    "date": "2017-51-14 08:09:35",
    "description": "",
    "extensionName": "",
    "files": [
        {
            "id": "11211c5b-f53d-4d99-ae59-eeba64fcd284",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 1048640,
            "filename": "RiyaNetServer.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\RiyaNetServer.dll",
            "uncompress": false
        },
        {
            "id": "a40f173c-c847-4906-9f2a-d419da5b6dc2",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 64,
            "filename": "EtherDream.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\EtherDream.dll",
            "uncompress": false
        },
        {
            "id": "5de31079-0003-40df-9526-60a0285c2c98",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                {
                    "id": "b02e487a-55eb-48fb-addc-bd63946c00c1",
                    "modelName": "GMProxyFile",
                    "mvc": "1.0",
                    "TargetMask": 1,
                    "proxyName": "libdacwrapper.dylib"
                }
            ],
            "constants": [
                
            ],
            "copyToTargets": 66,
            "filename": "dacwrapper.dll",
            "final": "FreeDacwrapper",
            "functions": [
                {
                    "id": "6841e542-0835-4642-b803-51a59b11b550",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "InitDacwrapper",
                    "help": "",
                    "hidden": false,
                    "kind": 12,
                    "name": "InitDacwrapper",
                    "returnType": 2
                },
                {
                    "id": "fe7a35b5-fec4-40a4-8472-dd6275408b9c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "FreeDacwrapper",
                    "help": "",
                    "hidden": false,
                    "kind": 12,
                    "name": "FreeDacwrapper",
                    "returnType": 2
                },
                {
                    "id": "886fde93-e3fa-4576-8ca8-da076f4c6b81",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "ScanDevices",
                    "help": "dacwrapper_scandevices()",
                    "hidden": false,
                    "kind": 12,
                    "name": "dacwrapper_scandevices",
                    "returnType": 2
                },
                {
                    "id": "8b0b24e8-bf3f-4a60-9906-6fcbe805c0aa",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "DeviceOpen",
                    "help": "dacwrapper_opendevice(num)",
                    "hidden": false,
                    "kind": 12,
                    "name": "dacwrapper_opendevice",
                    "returnType": 2
                },
                {
                    "id": "2722c1ed-ffe8-4708-bb60-bca200988285",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "OutputFrame",
                    "help": "dacwrapper_outputframe(num, pps, size, address)",
                    "hidden": false,
                    "kind": 12,
                    "name": "dacwrapper_outputframe",
                    "returnType": 2
                },
                {
                    "id": "cadf2719-21b9-4b65-bce3-cab6ba95c1e7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "Stop",
                    "help": "dacwrapper_stop(num)",
                    "hidden": false,
                    "kind": 12,
                    "name": "dacwrapper_stop",
                    "returnType": 2
                },
                {
                    "id": "7baa393c-ebf6-497d-950a-cd392fba2adc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "GetName",
                    "help": "dacwrapper_getname(num)",
                    "hidden": false,
                    "kind": 12,
                    "name": "dacwrapper_getname",
                    "returnType": 1
                },
                {
                    "id": "6c56e040-b1db-476f-b2e9-9a4fe90e70b2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        1
                    ],
                    "externalName": "SetName",
                    "help": "dacwrapper_setname(num,name)",
                    "hidden": false,
                    "kind": 12,
                    "name": "dacwrapper_setname",
                    "returnType": 2
                },
                {
                    "id": "623595e4-2d86-4b5a-96c2-14059ee49ced",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "GetFirmwareVersion",
                    "help": "dacwrapper_getfirmware(num)",
                    "hidden": false,
                    "kind": 12,
                    "name": "dacwrapper_getfirmware",
                    "returnType": 2
                },
                {
                    "id": "12e0b64a-5790-4a62-9360-30151dc02be6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "ReturnOne",
                    "help": "dacwrapper_returnone()",
                    "hidden": false,
                    "kind": 1,
                    "name": "dacwrapper_returnone",
                    "returnType": 2
                }
            ],
            "init": "InitDacwrapper",
            "kind": 1,
            "order": [
                "6841e542-0835-4642-b803-51a59b11b550",
                "fe7a35b5-fec4-40a4-8472-dd6275408b9c",
                "886fde93-e3fa-4576-8ca8-da076f4c6b81",
                "8b0b24e8-bf3f-4a60-9906-6fcbe805c0aa",
                "2722c1ed-ffe8-4708-bb60-bca200988285",
                "cadf2719-21b9-4b65-bce3-cab6ba95c1e7",
                "7baa393c-ebf6-497d-950a-cd392fba2adc",
                "6c56e040-b1db-476f-b2e9-9a4fe90e70b2",
                "623595e4-2d86-4b5a-96c2-14059ee49ced",
                "12e0b64a-5790-4a62-9360-30151dc02be6"
            ],
            "origname": "extensions\\dacwrapper.dll",
            "uncompress": false
        },
        {
            "id": "cde19827-9680-4d43-8a51-c582048e81db",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 64,
            "filename": "EasyLase.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\EasyLase.dll",
            "uncompress": false
        },
        {
            "id": "d0482832-ad88-4da3-8c7c-7d19dc3c9c62",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 64,
            "filename": "EzAudDac.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\EzAudDac.dll",
            "uncompress": false
        },
        {
            "id": "3e264ab6-da49-4377-93b5-830ffaaf2c93",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 64,
            "filename": "OLSC_EasyLase.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\OLSC_EasyLase.dll",
            "uncompress": false
        },
        {
            "id": "841093cd-c887-40ec-b6c4-f454e1a37a02",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 64,
            "filename": "OLSC_EzAudDac.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\OLSC_EzAudDac.dll",
            "uncompress": false
        },
        {
            "id": "2f8e34ab-4e00-484c-8dfe-193cdac67032",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 64,
            "filename": "SDL.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\SDL.dll",
            "uncompress": false
        },
        {
            "id": "e678751a-1c36-4aa2-b129-a04ac24ca229",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 64,
            "filename": "ftd2xx.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\ftd2xx.dll",
            "uncompress": false
        },
        {
            "id": "8fc6de74-15e5-43a9-ba82-ea4522403239",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "EzAudDacDEFAULT.ini",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "extensions\\EzAudDacDEFAULT.ini",
            "uncompress": false
        },
        {
            "id": "385e7746-1287-42d6-9005-70b6aa2a34d6",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 2,
            "filename": "libusb-1.0.0.dylib",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "",
            "uncompress": false
        },
        {
            "id": "91e2484a-effe-4530-98d7-a8a642b1263d",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 598172980216040,
            "filename": "OLSD.dll",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": false,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosplistinject": "",
    "license": "Free to use, also for commercial games.",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "version": "0.2.0"
}