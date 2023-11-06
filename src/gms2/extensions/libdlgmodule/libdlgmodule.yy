{
  "resourceType": "GMExtension",
  "resourceVersion": "1.2",
  "name": "libdlgmodule",
  "optionsFile": "options.json",
  "options": [],
  "exportToGame": true,
  "supportedTargets": 202375362,
  "extensionVersion": "1.0.0",
  "packageId": "",
  "productId": "ACBD3CFF4E539AD869A0E8E3B4B022DD",
  "author": "",
  "date": "2020-03-01T10:40:41",
  "license": "Free to use, also for commercial games.",
  "description": "",
  "helpfile": "",
  "iosProps": false,
  "tvosProps": false,
  "androidProps": false,
  "html5Props": false,
  "installdir": "",
  "files": [
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"libdlgmod.dll","origname":"extensions\\DialogModule.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_message","externalName":"show_message","kind":12,"help":"show_message(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_question","externalName":"show_question","kind":12,"help":"show_question(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_error","externalName":"show_error","kind":12,"help":"show_error(str,abort)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_string","externalName":"get_string","kind":12,"help":"get_string(str,def)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_password","externalName":"get_password","kind":12,"help":"get_password(str,def)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_integer","externalName":"get_integer","kind":12,"help":"get_integer(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_passcode","externalName":"get_passcode","kind":12,"help":"get_passcode(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_open_filename","externalName":"get_open_filename","kind":12,"help":"get_open_filename(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_open_filename_ext","externalName":"get_open_filename_ext","kind":12,"help":"get_open_filename_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_open_filenames","externalName":"get_open_filenames","kind":12,"help":"get_open_filenames(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_open_filenames_ext","externalName":"get_open_filenames_ext","kind":12,"help":"get_open_filenames_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_save_filename","externalName":"get_save_filename","kind":12,"help":"get_save_filename(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_save_filename_ext","externalName":"get_save_filename_ext","kind":12,"help":"get_save_filename_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_directory","externalName":"get_directory","kind":12,"help":"get_directory(dname)","hidden":false,"returnType":1,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_directory_alt","externalName":"get_directory_alt","kind":12,"help":"get_directory_alt(capt,root)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_color","externalName":"get_color","kind":12,"help":"get_color(defcol)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_color_ext","externalName":"get_color_ext","kind":12,"help":"get_color_ext(defcol,title)","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_message_cancelable","externalName":"show_message_cancelable","kind":12,"help":"show_message_cancelable(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_question_cancelable","externalName":"show_question_cancelable","kind":12,"help":"show_question_cancelable(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_get_system","externalName":"widget_get_system","kind":12,"help":"widget_get_system()","hidden":false,"returnType":1,"argCount":-1,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_set_system","externalName":"widget_set_system","kind":12,"help":"widget_set_system(sys)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_attempt","externalName":"show_attempt","kind":12,"help":"show_attempt(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_get_caption","externalName":"widget_get_caption","kind":12,"help":"widget_get_caption()","hidden":false,"returnType":1,"argCount":0,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_set_caption","externalName":"widget_set_caption","kind":12,"help":"widget_set_caption(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_get_owner","externalName":"widget_get_owner","kind":12,"help":"widget_get_owner()","hidden":false,"returnType":1,"argCount":-1,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_set_owner","externalName":"widget_set_owner","kind":12,"help":"widget_set_owner(hwnd)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_get_icon","externalName":"widget_get_icon","kind":12,"help":"widget_get_icon()","hidden":false,"returnType":1,"argCount":-1,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_set_icon","externalName":"widget_set_icon","kind":12,"help":"widget_set_icon(icon)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_message_async","externalName":"show_message_async","kind":12,"help":"show_message_async(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_question_async","externalName":"show_question_async","kind":12,"help":"show_question_async(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_error_async","externalName":"show_error_async","kind":12,"help":"show_error_async(str,abort)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_string_async","externalName":"get_string_async","kind":12,"help":"get_string_async(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_password_async","externalName":"get_password_async","kind":12,"help":"get_password_async(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_integer_async","externalName":"get_integer_async","kind":12,"help":"get_integer_async(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_passcode_async","externalName":"get_passcode_async","kind":12,"help":"get_passcode_async(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_open_filename_async","externalName":"get_open_filename_async","kind":12,"help":"get_open_filename_async(filter,fname)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_open_filename_ext_async","externalName":"get_open_filename_ext_async","kind":12,"help":"get_open_filename_ext_async(filter,fname,dir,title)","hidden":false,"returnType":2,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_open_filenames_async","externalName":"get_open_filenames_async","kind":12,"help":"get_open_filenames_async(filter,fname)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_open_filenames_ext_async","externalName":"get_open_filenames_ext_async","kind":12,"help":"get_open_filenames_ext_async(filter,fname,dir,title)","hidden":false,"returnType":2,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_save_filename_async","externalName":"get_save_filename_async","kind":12,"help":"get_save_filename_async(filter,fname)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_save_filename_ext_async","externalName":"get_save_filename_ext_async","kind":12,"help":"get_save_filename_ext_async(filter,fname,dir,title)","hidden":false,"returnType":2,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_directory_async","externalName":"get_directory_async","kind":12,"help":"get_directory_async(dname)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_directory_alt_async","externalName":"get_directory_alt_async","kind":12,"help":"get_directory_alt_async(capt,root)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_color_async","externalName":"get_color_async","kind":12,"help":"get_color_async(defcol)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"get_color_ext_async","externalName":"get_color_ext_async","kind":12,"help":"get_color_ext_async(defcol,title)","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_message_cancelable_async","externalName":"show_message_cancelable_async","kind":12,"help":"show_message_cancelable_async(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_question_cancelable_async","externalName":"show_question_cancelable_async","kind":12,"help":"show_question_cancelable_async(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"show_attempt_async","externalName":"show_attempt_async","kind":12,"help":"show_attempt_async(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"RegisterCallbacks","externalName":"RegisterCallbacks","kind":12,"help":"RegisterCallbacks(arg1,arg2,arg3,arg4)","hidden":false,"returnType":2,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_get_button_name","externalName":"widget_get_button_name","kind":1,"help":"widget_get_button_name(type)","hidden":false,"returnType":1,"argCount":0,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"widget_set_button_name","externalName":"widget_set_button_name","kind":1,"help":"widget_set_button_name(type,name)","hidden":false,"returnType":2,"argCount":0,"args":[
            2,
            1,
          ],"documentation":"",},
      ],"constants":[
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"ws_win32","value":"\"Win32\"","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"ws_cocoa","value":"\"Cocoa\"","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"ws_x11_zenity","value":"\"Zenity\"","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"ws_x11_kdialog","value":"\"KDialog\"","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"hwnd_main","value":"string(int64(window_handle()))","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"hwnd_default","value":"string(int64(pointer_null))","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"btn_abort","value":"0","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"btn_ignore","value":"1","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"btn_ok","value":"2","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"btn_cancel","value":"3","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"btn_yes","value":"4","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"btn_no","value":"5","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"btn_retry","value":"6","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"ws_x11","value":"\"X11\"","hidden":false,},
      ],"ProxyFiles":[
        {"resourceType":"GMProxyFile","resourceVersion":"1.0","name":"libdlgmod.dylib","TargetMask":1,},
        {"resourceType":"GMProxyFile","resourceVersion":"1.0","name":"libdlgmod_arm.so","TargetMask":7,},
        {"resourceType":"GMProxyFile","resourceVersion":"1.0","name":"libdlgmod_arm64.so","TargetMask":7,},
        {"resourceType":"GMProxyFile","resourceVersion":"1.0","name":"libdlgmod.so","TargetMask":7,},
      ],"copyToTargets":202375362,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"libdlgmod.zip","origname":"","init":"","final":"","kind":4,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"dlgmod","origname":"","init":"","final":"","kind":4,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":2,"usesRunnerInterface":false,"order":[],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"dlgmod.zip","origname":"","init":"","final":"","kind":4,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"usesRunnerInterface":false,"order":[],},
  ],
  "HTML5CodeInjection": "",
  "classname": "",
  "tvosclassname": "",
  "tvosdelegatename": "",
  "iosdelegatename": "",
  "androidclassname": "",
  "sourcedir": "",
  "androidsourcedir": "",
  "macsourcedir": "",
  "maccompilerflags": "",
  "tvosmaccompilerflags": "",
  "maclinkerflags": "",
  "tvosmaclinkerflags": "",
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
    "Sprites\\DialogModule\\spr_example",
    "Objects\\DialogModule\\obj_example",
    "Rooms\\DialogModule\\rm_example",
    "Included Files\\icon.png",
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