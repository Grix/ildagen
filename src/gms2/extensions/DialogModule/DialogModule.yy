{
    "id": "125de3be-ec22-453d-b4e8-2a080b4bcf7d",
    "modelName": "GMExtension",
    "mvc": "1.0",
    "name": "DialogModule",
    "IncludedResources": [
        "Sprites\\spr_example",
        "Objects\\obj_example",
        "Rooms\\rm_example"
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
    "copyToTargets": 128,
    "date": "2019-39-08 04:09:41",
    "description": "",
    "extensionName": "",
    "files": [
        {
            "id": "950f6fed-bd15-47f9-a186-aa5a2b9a91b9",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                {
                    "id": "9137a3d3-5b30-4ec2-8e7f-082957966d68",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_win32",
                    "hidden": false,
                    "value": "\"Win32\""
                },
                {
                    "id": "cdf1ce5a-70fa-4682-bd62-0bbd275bd1bc",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_cocoa",
                    "hidden": false,
                    "value": "\"Cocoa\""
                },
                {
                    "id": "68d50c7f-91e0-4ca8-8a83-91fb5635bfeb",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_x11_zenity",
                    "hidden": false,
                    "value": "\"Zenity\""
                },
                {
                    "id": "30917fbe-c4a3-4718-bff1-962e2002620b",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_x11_kdialog",
                    "hidden": false,
                    "value": "\"KDialog\""
                },
                {
                    "id": "3a2af60c-b5fe-4b9a-9fc5-c1da7c3e0d06",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "hwnd_main",
                    "hidden": false,
                    "value": "window_handle()"
                }
            ],
            "copyToTargets": 1048640,
            "filename": "DialogModule.dll",
            "final": "",
            "functions": [
                {
                    "id": "3651be8c-0057-43c4-af19-de1cc2ec4b8f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_message",
                    "help": "show_message(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_message",
                    "returnType": 2
                },
                {
                    "id": "627d617b-16e8-4fac-8d80-549c58e3cacd",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_question",
                    "help": "show_question(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_question",
                    "returnType": 2
                },
                {
                    "id": "1d5025d3-a16b-49e1-9118-104b7af4abf4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "show_error",
                    "help": "show_error(str,abort)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_error",
                    "returnType": 2
                },
                {
                    "id": "406e642b-c629-4777-abde-9ab6fbc7cf0b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_string",
                    "help": "get_string(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_string",
                    "returnType": 1
                },
                {
                    "id": "c8df34f6-297b-4306-832b-6db566213219",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_password",
                    "help": "get_password(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_password",
                    "returnType": 1
                },
                {
                    "id": "bba1fbc2-9d6c-48d0-b2da-ec93d52171b3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "get_integer",
                    "help": "get_integer(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_integer",
                    "returnType": 2
                },
                {
                    "id": "e331ff08-c20b-4b95-b4e4-80282458b5a1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "get_passcode",
                    "help": "get_passcode(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_passcode",
                    "returnType": 2
                },
                {
                    "id": "61d2d6fc-f91d-49a6-8ae3-ff889d94bed3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_open_filename",
                    "help": "get_open_filename(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filename",
                    "returnType": 1
                },
                {
                    "id": "315fd8ce-bd6e-4d82-92ba-aa36ebaeb105",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_open_filename_ext",
                    "help": "get_open_filename_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filename_ext",
                    "returnType": 1
                },
                {
                    "id": "1a2e082a-3a6f-4ef3-93da-49fc381d7c1f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_open_filenames",
                    "help": "get_open_filenames(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filenames",
                    "returnType": 1
                },
                {
                    "id": "407848bd-0095-4b77-9aaf-8b4d950863ea",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_open_filenames_ext",
                    "help": "get_open_filenames_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filenames_ext",
                    "returnType": 1
                },
                {
                    "id": "524ccdcd-d15e-45ec-b75e-4553efe931c6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_save_filename",
                    "help": "get_save_filename(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_save_filename",
                    "returnType": 1
                },
                {
                    "id": "c1531a03-f033-4b41-bc7e-d77a86956b26",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_save_filename_ext",
                    "help": "get_save_filename_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_save_filename_ext",
                    "returnType": 1
                },
                {
                    "id": "05a626ad-76b3-4a43-aadb-61356245099f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "get_directory",
                    "help": "get_directory(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_directory",
                    "returnType": 1
                },
                {
                    "id": "2ec0f053-e149-43d0-9bd5-f9b2497f80d4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_directory_alt",
                    "help": "get_directory_alt(capt,root)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_directory_alt",
                    "returnType": 1
                },
                {
                    "id": "8145468c-4e90-4898-a0f4-867a77d9d70e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "get_color",
                    "help": "get_color(defcol)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_color",
                    "returnType": 2
                },
                {
                    "id": "e6126bc2-0cca-4ff5-914a-96aecd26e018",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        1
                    ],
                    "externalName": "get_color_ext",
                    "help": "get_color_ext(defcol,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_color_ext",
                    "returnType": 2
                },
                {
                    "id": "6f124b63-bc18-4f93-9de9-d29cb155013c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_message_cancelable",
                    "help": "show_message_cancelable(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_message_cancelable",
                    "returnType": 2
                },
                {
                    "id": "db06b567-ab9b-4c1d-86f2-677072545302",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_question_cancelable",
                    "help": "show_question_cancelable(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_question_cancelable",
                    "returnType": 2
                },
                {
                    "id": "719582ea-c2a3-43f6-ae87-f2b74e785d24",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_system",
                    "help": "widget_get_system()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_system",
                    "returnType": 1
                },
                {
                    "id": "1c6fce58-eeb0-4d10-8c39-082d92dfe460",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_system",
                    "help": "widget_set_system(sys)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_system",
                    "returnType": 2
                },
                {
                    "id": "61562096-de60-417a-a324-aca6665f2fc5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_attempt",
                    "help": "show_attempt(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_attempt",
                    "returnType": 2
                },
                {
                    "id": "a76e6b2a-eaf2-4883-ab15-a4e98191b61e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_caption",
                    "help": "widget_get_caption()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_caption",
                    "returnType": 1
                },
                {
                    "id": "e9d0ede9-e6ca-49a4-843a-111ef8436bb6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_caption",
                    "help": "widget_set_caption(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_caption",
                    "returnType": 2
                },
                {
                    "id": "2956610f-aa83-4ff9-9f75-d7b596ba75e3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_owner",
                    "help": "widget_get_owner()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_owner",
                    "returnType": 1
                },
                {
                    "id": "a9d600e3-403f-49a1-911c-e0e394ea5a4b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_owner",
                    "help": "widget_set_owner(hwnd)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_owner",
                    "returnType": 2
                },
                {
                    "id": "44d9077c-26ca-49a5-a417-fabaad3059c5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_icon",
                    "help": "widget_get_icon()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_icon",
                    "returnType": 1
                },
                {
                    "id": "8f355af3-8284-43c2-9931-c2f23b0e445f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_icon",
                    "help": "widget_set_icon(icon)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_icon",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "3651be8c-0057-43c4-af19-de1cc2ec4b8f",
                "627d617b-16e8-4fac-8d80-549c58e3cacd",
                "1d5025d3-a16b-49e1-9118-104b7af4abf4",
                "406e642b-c629-4777-abde-9ab6fbc7cf0b",
                "c8df34f6-297b-4306-832b-6db566213219",
                "bba1fbc2-9d6c-48d0-b2da-ec93d52171b3",
                "e331ff08-c20b-4b95-b4e4-80282458b5a1",
                "61d2d6fc-f91d-49a6-8ae3-ff889d94bed3",
                "315fd8ce-bd6e-4d82-92ba-aa36ebaeb105",
                "1a2e082a-3a6f-4ef3-93da-49fc381d7c1f",
                "407848bd-0095-4b77-9aaf-8b4d950863ea",
                "524ccdcd-d15e-45ec-b75e-4553efe931c6",
                "c1531a03-f033-4b41-bc7e-d77a86956b26",
                "05a626ad-76b3-4a43-aadb-61356245099f",
                "2ec0f053-e149-43d0-9bd5-f9b2497f80d4",
                "8145468c-4e90-4898-a0f4-867a77d9d70e",
                "e6126bc2-0cca-4ff5-914a-96aecd26e018",
                "6f124b63-bc18-4f93-9de9-d29cb155013c",
                "db06b567-ab9b-4c1d-86f2-677072545302",
                "719582ea-c2a3-43f6-ae87-f2b74e785d24",
                "1c6fce58-eeb0-4d10-8c39-082d92dfe460",
                "61562096-de60-417a-a324-aca6665f2fc5",
                "a76e6b2a-eaf2-4883-ab15-a4e98191b61e",
                "e9d0ede9-e6ca-49a4-843a-111ef8436bb6",
                "2956610f-aa83-4ff9-9f75-d7b596ba75e3",
                "a9d600e3-403f-49a1-911c-e0e394ea5a4b",
                "44d9077c-26ca-49a5-a417-fabaad3059c5",
                "8f355af3-8284-43c2-9931-c2f23b0e445f"
            ],
            "origname": "extensions\\DialogModule.dll",
            "uncompress": false
        },
        {
            "id": "ebf94d1b-4a84-4a6a-9778-e3fc1af9f709",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 0,
            "filename": "DialogModule.dll.zip",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "extensions\\DialogModule.dll.zip",
            "uncompress": false
        },
        {
            "id": "e6c7dc66-6803-46c8-ad28-75f6198057d0",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                {
                    "id": "38f84119-7109-48f6-a379-36d80594dddd",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_win32",
                    "hidden": false,
                    "value": "\"Win32\""
                },
                {
                    "id": "e983a507-0a87-4b76-883c-a8f593263bc8",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_cocoa",
                    "hidden": false,
                    "value": "\"Cocoa\""
                },
                {
                    "id": "ac210bd7-467e-4474-bb72-c14522512349",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_x11_zenity",
                    "hidden": false,
                    "value": "\"Zenity\""
                },
                {
                    "id": "4146e10c-a52b-441f-b71c-2678ebdab684",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_x11_kdialog",
                    "hidden": false,
                    "value": "\"KDialog\""
                },
                {
                    "id": "56312d80-1b89-4ecf-814c-d9569c9354f4",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "hwnd_main",
                    "hidden": false,
                    "value": "window_handle()"
                }
            ],
            "copyToTargets": 67108866,
            "filename": "DialogModule.dylib",
            "final": "",
            "functions": [
                {
                    "id": "4f2ef2bf-d919-4f04-9eeb-7ca81c448448",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_message",
                    "help": "show_message(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_message",
                    "returnType": 2
                },
                {
                    "id": "a04fcb40-d7ab-48ad-b7e8-4e7c3f1a8bc2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_question",
                    "help": "show_question(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_question",
                    "returnType": 2
                },
                {
                    "id": "a116da0f-89ad-4b97-bee9-e6bc7041ca48",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "show_error",
                    "help": "show_error(str,abort)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_error",
                    "returnType": 2
                },
                {
                    "id": "9e7db0bd-9674-468a-b8c8-f121bddf7cca",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_string",
                    "help": "get_string(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_string",
                    "returnType": 1
                },
                {
                    "id": "7d351f03-5e63-4af6-8c69-f6402f9df6d6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_password",
                    "help": "get_password(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_password",
                    "returnType": 1
                },
                {
                    "id": "e8e58330-3b5c-42ab-b3a4-73dfd956c981",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "get_integer",
                    "help": "get_integer(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_integer",
                    "returnType": 2
                },
                {
                    "id": "bd9c8d4b-ef78-46c8-826c-8b6f22100948",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "get_passcode",
                    "help": "get_passcode(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_passcode",
                    "returnType": 2
                },
                {
                    "id": "bf58558a-72e0-49bf-8e0c-dfd1882aa7fc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_open_filename",
                    "help": "get_open_filename(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filename",
                    "returnType": 1
                },
                {
                    "id": "25324f21-eacd-4fd7-ba30-565f7875405e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_open_filename_ext",
                    "help": "get_open_filename_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filename_ext",
                    "returnType": 1
                },
                {
                    "id": "8a4a411e-96f6-4de4-8488-80cb4264644e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_open_filenames",
                    "help": "get_open_filenames(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filenames",
                    "returnType": 1
                },
                {
                    "id": "c629ff26-2913-47a8-af11-ad441c5b6cb9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_open_filenames_ext",
                    "help": "get_open_filenames_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filenames_ext",
                    "returnType": 1
                },
                {
                    "id": "f5aa63fa-ebe2-423b-890f-075771c85c16",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_save_filename",
                    "help": "get_save_filename(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_save_filename",
                    "returnType": 1
                },
                {
                    "id": "d0714739-1db5-45da-b0bf-fec25acc8194",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_save_filename_ext",
                    "help": "get_save_filename_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_save_filename_ext",
                    "returnType": 1
                },
                {
                    "id": "1f117ea3-50fc-4758-bd84-7a38cea36059",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "get_directory",
                    "help": "get_directory(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_directory",
                    "returnType": 1
                },
                {
                    "id": "da50b27b-657e-484d-b6f8-b81f3ef79f51",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_directory_alt",
                    "help": "get_directory_alt(capt,root)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_directory_alt",
                    "returnType": 1
                },
                {
                    "id": "db3d912d-bc25-42e3-a37f-e876a5d57903",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "get_color",
                    "help": "get_color(defcol)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_color",
                    "returnType": 2
                },
                {
                    "id": "2165a3d1-0a86-4e75-8cca-7915ae66ce1f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        1
                    ],
                    "externalName": "get_color_ext",
                    "help": "get_color_ext(defcol,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_color_ext",
                    "returnType": 2
                },
                {
                    "id": "d1f10c4e-960e-40f6-8eed-0b9252b40228",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_message_cancelable",
                    "help": "show_message_cancelable(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_message_cancelable",
                    "returnType": 2
                },
                {
                    "id": "f8a56fef-1eef-4fcf-a80b-7778a1411831",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_question_cancelable",
                    "help": "show_question_cancelable(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_question_cancelable",
                    "returnType": 2
                },
                {
                    "id": "08d879d8-911f-456a-b2be-9164ca83c2f8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_system",
                    "help": "widget_get_system()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_system",
                    "returnType": 1
                },
                {
                    "id": "f5535fe6-80df-4e3e-9224-85a6c962dfa3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_system",
                    "help": "widget_set_system(sys)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_system",
                    "returnType": 2
                },
                {
                    "id": "7321eb01-8d15-491f-9440-e44b73c43305",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_attempt",
                    "help": "show_attempt(str)",
                    "hidden": false,
                    "kind": 11,
                    "name": "show_attempt",
                    "returnType": 2
                },
                {
                    "id": "384aea2f-dcbf-466a-9dc8-e22a3665fc8a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_caption",
                    "help": "widget_get_caption()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_caption",
                    "returnType": 1
                },
                {
                    "id": "8484aa16-faa5-45dc-b43a-ec6f1c13021d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_caption",
                    "help": "widget_set_caption(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_caption",
                    "returnType": 2
                },
                {
                    "id": "7fc333ef-b848-48fb-a285-4a1515eeb4b5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_owner",
                    "help": "widget_get_owner()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_owner",
                    "returnType": 1
                },
                {
                    "id": "de8ab128-2b75-4e83-a511-75cde966276e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_owner",
                    "help": "widget_set_owner(hwnd)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_owner",
                    "returnType": 2
                },
                {
                    "id": "8e622d57-4cb9-4602-b550-bceb147ee938",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_icon",
                    "help": "widget_get_icon()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_icon",
                    "returnType": 1
                },
                {
                    "id": "a68f181f-debf-4f15-8d5a-1e340d692838",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_icon",
                    "help": "widget_set_icon(icon)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_icon",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "4f2ef2bf-d919-4f04-9eeb-7ca81c448448",
                "a04fcb40-d7ab-48ad-b7e8-4e7c3f1a8bc2",
                "a116da0f-89ad-4b97-bee9-e6bc7041ca48",
                "9e7db0bd-9674-468a-b8c8-f121bddf7cca",
                "7d351f03-5e63-4af6-8c69-f6402f9df6d6",
                "e8e58330-3b5c-42ab-b3a4-73dfd956c981",
                "bd9c8d4b-ef78-46c8-826c-8b6f22100948",
                "bf58558a-72e0-49bf-8e0c-dfd1882aa7fc",
                "25324f21-eacd-4fd7-ba30-565f7875405e",
                "8a4a411e-96f6-4de4-8488-80cb4264644e",
                "c629ff26-2913-47a8-af11-ad441c5b6cb9",
                "f5aa63fa-ebe2-423b-890f-075771c85c16",
                "d0714739-1db5-45da-b0bf-fec25acc8194",
                "1f117ea3-50fc-4758-bd84-7a38cea36059",
                "da50b27b-657e-484d-b6f8-b81f3ef79f51",
                "db3d912d-bc25-42e3-a37f-e876a5d57903",
                "2165a3d1-0a86-4e75-8cca-7915ae66ce1f",
                "d1f10c4e-960e-40f6-8eed-0b9252b40228",
                "f8a56fef-1eef-4fcf-a80b-7778a1411831",
                "08d879d8-911f-456a-b2be-9164ca83c2f8",
                "f5535fe6-80df-4e3e-9224-85a6c962dfa3",
                "7321eb01-8d15-491f-9440-e44b73c43305",
                "384aea2f-dcbf-466a-9dc8-e22a3665fc8a",
                "8484aa16-faa5-45dc-b43a-ec6f1c13021d",
                "7fc333ef-b848-48fb-a285-4a1515eeb4b5",
                "de8ab128-2b75-4e83-a511-75cde966276e",
                "8e622d57-4cb9-4602-b550-bceb147ee938",
                "a68f181f-debf-4f15-8d5a-1e340d692838"
            ],
            "origname": "extensions\\DialogModule.dylib",
            "uncompress": false
        },
        {
            "id": "f3a4de6c-d08b-4976-8733-3354e5f16b46",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 0,
            "filename": "DialogModule.dylib.zip",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "extensions\\DialogModule.dylib.zip",
            "uncompress": false
        },
        {
            "id": "218c0564-9302-40c6-b4c7-c598a66c8ffa",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                {
                    "id": "d695043b-1c84-4daf-a9cd-2ec6d39f6ac3",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_win32",
                    "hidden": false,
                    "value": "\"Win32\""
                },
                {
                    "id": "e4c79706-4ba5-4ce3-9e70-d34fe183e4de",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_cocoa",
                    "hidden": false,
                    "value": "\"Cocoa\""
                },
                {
                    "id": "8d879f2e-ab39-41f6-a0ef-573422f70dcb",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_x11_zenity",
                    "hidden": false,
                    "value": "\"Zenity\""
                },
                {
                    "id": "5ec4e474-5f21-4ed2-b4db-8d475e6db28d",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "ws_x11_kdialog",
                    "hidden": false,
                    "value": "\"KDialog\""
                },
                {
                    "id": "67a416e6-8c7d-4e32-a633-57e57e43c967",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "hwnd_main",
                    "hidden": false,
                    "value": "window_handle()"
                }
            ],
            "copyToTargets": 134217856,
            "filename": "DialogModule.so",
            "final": "",
            "functions": [
                {
                    "id": "b2772d1c-ce82-4038-a576-aac165d48c82",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_message",
                    "help": "show_message(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_message",
                    "returnType": 2
                },
                {
                    "id": "d82da34a-e393-4189-bba7-1e712cf1d6d0",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_question",
                    "help": "show_question(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_question",
                    "returnType": 2
                },
                {
                    "id": "8a8789b5-efa4-440b-aac4-743202f57d6c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "show_error",
                    "help": "show_error(str,abort)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_error",
                    "returnType": 2
                },
                {
                    "id": "ade13f4d-6dbe-4865-80b9-a21212a37370",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_string",
                    "help": "get_string(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_string",
                    "returnType": 1
                },
                {
                    "id": "6522f705-d487-4005-ad43-e11f5477dd4c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_password",
                    "help": "get_password(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_password",
                    "returnType": 1
                },
                {
                    "id": "d8e874a9-c91d-4414-a3d8-9af7244be8cc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "get_integer",
                    "help": "get_integer(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_integer",
                    "returnType": 2
                },
                {
                    "id": "6d3f4f54-0136-4a4a-b9b9-ccfd1d0cedae",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "get_passcode",
                    "help": "get_passcode(str,def)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_passcode",
                    "returnType": 2
                },
                {
                    "id": "7dff7630-96fd-4fb5-9b23-762914b6ac7a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_open_filename",
                    "help": "get_open_filename(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filename",
                    "returnType": 1
                },
                {
                    "id": "e12f9057-a3be-444b-a3e6-300d403e9033",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_open_filename_ext",
                    "help": "get_open_filename_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filename_ext",
                    "returnType": 1
                },
                {
                    "id": "2d468d0e-0d29-426f-bf41-58a91018ddc0",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_open_filenames",
                    "help": "get_open_filenames(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filenames",
                    "returnType": 1
                },
                {
                    "id": "9aa26808-9f5a-4b88-ada1-853552bf64d8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_open_filenames_ext",
                    "help": "get_open_filenames_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_open_filenames_ext",
                    "returnType": 1
                },
                {
                    "id": "0da0f9b4-231e-4114-bea7-203f07212716",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_save_filename",
                    "help": "get_save_filename(filter,fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_save_filename",
                    "returnType": 1
                },
                {
                    "id": "e82a0450-6768-4276-8d69-159acad26158",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "get_save_filename_ext",
                    "help": "get_save_filename_ext(filter,fname,dir,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_save_filename_ext",
                    "returnType": 1
                },
                {
                    "id": "224b7c07-2b1b-4154-86fb-45f2a155003e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "get_directory",
                    "help": "get_directory(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_directory",
                    "returnType": 1
                },
                {
                    "id": "04ad5956-f105-4f55-8d6f-a49a2678c27c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "get_directory_alt",
                    "help": "get_directory_alt(capt,root)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_directory_alt",
                    "returnType": 1
                },
                {
                    "id": "f7dc900c-dedd-4af0-bebf-0b320158c99a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "get_color",
                    "help": "get_color(defcol)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_color",
                    "returnType": 2
                },
                {
                    "id": "0876fa5e-fa3c-4d38-a0e8-acef1e5aad01",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        1
                    ],
                    "externalName": "get_color_ext",
                    "help": "get_color_ext(defcol,title)",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_color_ext",
                    "returnType": 2
                },
                {
                    "id": "7d29e373-6d3f-405d-a2e1-1688611481fb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_system",
                    "help": "widget_get_system()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_system",
                    "returnType": 1
                },
                {
                    "id": "6c0b5874-93d2-4b2e-b26e-8a9e15df0f90",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_system",
                    "help": "widget_set_system(sys)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_system",
                    "returnType": 2
                },
                {
                    "id": "0f96cbc9-858b-4cd8-9494-a6acfb419d22",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_message_cancelable",
                    "help": "show_message_cancelable(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_message_cancelable",
                    "returnType": 2
                },
                {
                    "id": "c3964a4d-9f7d-44c3-b48e-2c9dc65aa746",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_question_cancelable",
                    "help": "show_question_cancelable(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "show_question_cancelable",
                    "returnType": 2
                },
                {
                    "id": "b30c70b1-4d67-4d5a-aa16-3c129946f178",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "show_attempt",
                    "help": "show_attempt(str)",
                    "hidden": false,
                    "kind": 11,
                    "name": "show_attempt",
                    "returnType": 2
                },
                {
                    "id": "48aceaed-debe-4641-bfd7-61fb4854b6a9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_caption",
                    "help": "widget_get_caption()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_caption",
                    "returnType": 1
                },
                {
                    "id": "d31cab83-e3b4-46cf-925f-eca582097153",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_caption",
                    "help": "widget_set_caption(str)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_caption",
                    "returnType": 2
                },
                {
                    "id": "68f42595-0175-4dd3-96d2-e573b29c6e43",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_owner",
                    "help": "widget_get_owner()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_owner",
                    "returnType": 1
                },
                {
                    "id": "e5c2f357-ea06-4fd2-8efc-507c7eefef5f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_owner",
                    "help": "widget_set_owner(hwnd)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_owner",
                    "returnType": 2
                },
                {
                    "id": "4b05f848-aef9-4492-a88d-e28bc1c39e4e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "widget_get_icon",
                    "help": "widget_get_icon()",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_get_icon",
                    "returnType": 1
                },
                {
                    "id": "326f907d-7587-4aed-9b05-217f15aeab88",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "widget_set_icon",
                    "help": "widget_set_icon(icon)",
                    "hidden": false,
                    "kind": 12,
                    "name": "widget_set_icon",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "b2772d1c-ce82-4038-a576-aac165d48c82",
                "d82da34a-e393-4189-bba7-1e712cf1d6d0",
                "8a8789b5-efa4-440b-aac4-743202f57d6c",
                "ade13f4d-6dbe-4865-80b9-a21212a37370",
                "6522f705-d487-4005-ad43-e11f5477dd4c",
                "d8e874a9-c91d-4414-a3d8-9af7244be8cc",
                "6d3f4f54-0136-4a4a-b9b9-ccfd1d0cedae",
                "7dff7630-96fd-4fb5-9b23-762914b6ac7a",
                "e12f9057-a3be-444b-a3e6-300d403e9033",
                "2d468d0e-0d29-426f-bf41-58a91018ddc0",
                "9aa26808-9f5a-4b88-ada1-853552bf64d8",
                "0da0f9b4-231e-4114-bea7-203f07212716",
                "e82a0450-6768-4276-8d69-159acad26158",
                "224b7c07-2b1b-4154-86fb-45f2a155003e",
                "04ad5956-f105-4f55-8d6f-a49a2678c27c",
                "f7dc900c-dedd-4af0-bebf-0b320158c99a",
                "0876fa5e-fa3c-4d38-a0e8-acef1e5aad01",
                "7d29e373-6d3f-405d-a2e1-1688611481fb",
                "6c0b5874-93d2-4b2e-b26e-8a9e15df0f90",
                "0f96cbc9-858b-4cd8-9494-a6acfb419d22",
                "c3964a4d-9f7d-44c3-b48e-2c9dc65aa746",
                "b30c70b1-4d67-4d5a-aa16-3c129946f178",
                "48aceaed-debe-4641-bfd7-61fb4854b6a9",
                "d31cab83-e3b4-46cf-925f-eca582097153",
                "68f42595-0175-4dd3-96d2-e573b29c6e43",
                "e5c2f357-ea06-4fd2-8efc-507c7eefef5f",
                "4b05f848-aef9-4492-a88d-e28bc1c39e4e",
                "326f907d-7587-4aed-9b05-217f15aeab88"
            ],
            "origname": "extensions\\DialogModule.so",
            "uncompress": false
        },
        {
            "id": "66cf8974-5f50-4650-bc63-d4385310408a",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 0,
            "filename": "DialogModule.so.zip",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "extensions\\DialogModule.so.zip",
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
    "iosdelegatename": "",
    "iosplistinject": "",
    "license": "Free to use, also for commercial games.",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "packageID": "",
    "productID": "F3D00DAD3DDB83EFFDD568E8093FC7AA",
    "sourcedir": "",
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosdelegatename": "",
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "1.0.0"
}