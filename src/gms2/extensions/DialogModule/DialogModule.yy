{
  "optionsFile": "options.json",
  "options": [],
  "exportToGame": true,
  "supportedTargets": 194,
  "extensionVersion": "1.0.0",
  "packageId": "",
  "productId": "F3D00DAD3DDB83EFFDD568E8093FC7AA",
  "author": "",
  "date": "2019-09-08T04:39:41",
  "license": "Free to use, also for commercial games.",
  "description": "",
  "helpfile": "",
  "iosProps": false,
  "tvosProps": false,
  "androidProps": false,
  "installdir": "",
  "files": [
    {"filename":"DialogModule.dll","origname":"extensions\\DialogModule.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[
        {"externalName":"show_message","kind":12,"help":"show_message(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_message","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_question","kind":12,"help":"show_question(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_question","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_error","kind":12,"help":"show_error(str,abort)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"show_error","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_string","kind":12,"help":"get_string(str,def)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_string","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_password","kind":12,"help":"get_password(str,def)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_password","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_integer","kind":12,"help":"get_integer(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"get_integer","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_passcode","kind":12,"help":"get_passcode(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"get_passcode","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filename","kind":12,"help":"get_open_filename(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filename","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filename_ext","kind":12,"help":"get_open_filename_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filename_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filenames","kind":12,"help":"get_open_filenames(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filenames","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filenames_ext","kind":12,"help":"get_open_filenames_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filenames_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_save_filename","kind":12,"help":"get_save_filename(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_save_filename","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_save_filename_ext","kind":12,"help":"get_save_filename_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_save_filename_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_directory","kind":12,"help":"get_directory(dname)","hidden":false,"returnType":1,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"get_directory","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_directory_alt","kind":12,"help":"get_directory_alt(capt,root)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_directory_alt","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_color","kind":12,"help":"get_color(defcol)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"resourceVersion":"1.0","name":"get_color","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_color_ext","kind":12,"help":"get_color_ext(defcol,title)","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"get_color_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_message_cancelable","kind":12,"help":"show_message_cancelable(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_message_cancelable","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_question_cancelable","kind":12,"help":"show_question_cancelable(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_question_cancelable","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_system","kind":12,"help":"widget_get_system()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_system","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_system","kind":12,"help":"widget_set_system(sys)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_system","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_attempt","kind":12,"help":"show_attempt(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_attempt","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_caption","kind":12,"help":"widget_get_caption()","hidden":false,"returnType":1,"argCount":0,"args":[],"resourceVersion":"1.0","name":"widget_get_caption","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_caption","kind":12,"help":"widget_set_caption(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_caption","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_owner","kind":12,"help":"widget_get_owner()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_owner","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_owner","kind":12,"help":"widget_set_owner(hwnd)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_owner","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_icon","kind":12,"help":"widget_get_icon()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_icon","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_icon","kind":12,"help":"widget_set_icon(icon)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_icon","tags":[],"resourceType":"GMExtensionFunction",},
      ],"constants":[
        {"value":"\"Win32\"","hidden":false,"resourceVersion":"1.0","name":"ws_win32","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"Cocoa\"","hidden":false,"resourceVersion":"1.0","name":"ws_cocoa","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"Zenity\"","hidden":false,"resourceVersion":"1.0","name":"ws_x11_zenity","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"KDialog\"","hidden":false,"resourceVersion":"1.0","name":"ws_x11_kdialog","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"window_handle()","hidden":false,"resourceVersion":"1.0","name":"hwnd_main","tags":[],"resourceType":"GMExtensionConstant",},
      ],"ProxyFiles":[],"copyToTargets":1048640,"order":[
        {"name":"show_message","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_question","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_error","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_string","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_password","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_integer","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_passcode","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filename","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filename_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filenames","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filenames_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_save_filename","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_save_filename_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_directory","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_directory_alt","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_color","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_color_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_message_cancelable","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_question_cancelable","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_system","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_system","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_attempt","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_caption","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_caption","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_owner","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_owner","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_icon","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_icon","path":"extensions/DialogModule/DialogModule.yy",},
      ],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"DialogModule.dll.zip","origname":"extensions\\DialogModule.dll.zip","init":"","final":"","kind":4,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"DialogModule.dylib","origname":"extensions\\DialogModule.dylib","init":"","final":"","kind":1,"uncompress":false,"functions":[
        {"externalName":"show_message","kind":12,"help":"show_message(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_message","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_question","kind":12,"help":"show_question(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_question","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_error","kind":12,"help":"show_error(str,abort)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"show_error","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_string","kind":12,"help":"get_string(str,def)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_string","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_password","kind":12,"help":"get_password(str,def)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_password","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_integer","kind":12,"help":"get_integer(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"get_integer","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_passcode","kind":12,"help":"get_passcode(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"get_passcode","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filename","kind":12,"help":"get_open_filename(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filename","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filename_ext","kind":12,"help":"get_open_filename_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filename_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filenames","kind":12,"help":"get_open_filenames(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filenames","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filenames_ext","kind":12,"help":"get_open_filenames_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filenames_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_save_filename","kind":12,"help":"get_save_filename(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_save_filename","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_save_filename_ext","kind":12,"help":"get_save_filename_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_save_filename_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_directory","kind":12,"help":"get_directory(dname)","hidden":false,"returnType":1,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"get_directory","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_directory_alt","kind":12,"help":"get_directory_alt(capt,root)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_directory_alt","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_color","kind":12,"help":"get_color(defcol)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"resourceVersion":"1.0","name":"get_color","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_color_ext","kind":12,"help":"get_color_ext(defcol,title)","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"get_color_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_message_cancelable","kind":12,"help":"show_message_cancelable(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_message_cancelable","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_question_cancelable","kind":12,"help":"show_question_cancelable(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_question_cancelable","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_system","kind":12,"help":"widget_get_system()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_system","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_system","kind":12,"help":"widget_set_system(sys)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_system","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_attempt","kind":11,"help":"show_attempt(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_attempt","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_caption","kind":12,"help":"widget_get_caption()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_caption","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_caption","kind":12,"help":"widget_set_caption(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_caption","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_owner","kind":12,"help":"widget_get_owner()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_owner","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_owner","kind":12,"help":"widget_set_owner(hwnd)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_owner","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_icon","kind":12,"help":"widget_get_icon()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_icon","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_icon","kind":12,"help":"widget_set_icon(icon)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_icon","tags":[],"resourceType":"GMExtensionFunction",},
      ],"constants":[
        {"value":"\"Win32\"","hidden":false,"resourceVersion":"1.0","name":"ws_win32","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"Cocoa\"","hidden":false,"resourceVersion":"1.0","name":"ws_cocoa","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"Zenity\"","hidden":false,"resourceVersion":"1.0","name":"ws_x11_zenity","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"KDialog\"","hidden":false,"resourceVersion":"1.0","name":"ws_x11_kdialog","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"window_handle()","hidden":false,"resourceVersion":"1.0","name":"hwnd_main","tags":[],"resourceType":"GMExtensionConstant",},
      ],"ProxyFiles":[],"copyToTargets":67108866,"order":[
        {"name":"show_message","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_question","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_error","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_string","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_password","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_integer","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_passcode","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filename","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filename_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filenames","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filenames_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_save_filename","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_save_filename_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_directory","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_directory_alt","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_color","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_color_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_message_cancelable","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_question_cancelable","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_system","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_system","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_attempt","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_caption","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_caption","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_owner","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_owner","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_icon","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_icon","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_message","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_question","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_error","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_string","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_password","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_integer","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_passcode","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filename","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filename_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filenames","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filenames_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_save_filename","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_save_filename_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_directory","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_directory_alt","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_color","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_color_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_message_cancelable","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_question_cancelable","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_system","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_system","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_attempt","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_caption","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_caption","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_owner","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_owner","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_icon","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_icon","path":"extensions/DialogModule/DialogModule.yy",},
      ],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"DialogModule.dylib.zip","origname":"extensions\\DialogModule.dylib.zip","init":"","final":"","kind":4,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"DialogModule.so","origname":"extensions\\DialogModule.so","init":"","final":"","kind":1,"uncompress":false,"functions":[
        {"externalName":"show_message","kind":12,"help":"show_message(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_message","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_question","kind":12,"help":"show_question(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_question","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_error","kind":12,"help":"show_error(str,abort)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"show_error","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_string","kind":12,"help":"get_string(str,def)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_string","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_password","kind":12,"help":"get_password(str,def)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_password","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_integer","kind":12,"help":"get_integer(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"get_integer","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_passcode","kind":12,"help":"get_passcode(str,def)","hidden":false,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"resourceVersion":"1.0","name":"get_passcode","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filename","kind":12,"help":"get_open_filename(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filename","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filename_ext","kind":12,"help":"get_open_filename_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filename_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filenames","kind":12,"help":"get_open_filenames(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filenames","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_open_filenames_ext","kind":12,"help":"get_open_filenames_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_open_filenames_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_save_filename","kind":12,"help":"get_save_filename(filter,fname)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_save_filename","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_save_filename_ext","kind":12,"help":"get_save_filename_ext(filter,fname,dir,title)","hidden":false,"returnType":1,"argCount":4,"args":[
            1,
            1,
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_save_filename_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_directory","kind":12,"help":"get_directory(dname)","hidden":false,"returnType":1,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"get_directory","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_directory_alt","kind":12,"help":"get_directory_alt(capt,root)","hidden":false,"returnType":1,"argCount":2,"args":[
            1,
            1,
          ],"resourceVersion":"1.0","name":"get_directory_alt","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_color","kind":12,"help":"get_color(defcol)","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"resourceVersion":"1.0","name":"get_color","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"get_color_ext","kind":12,"help":"get_color_ext(defcol,title)","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            1,
          ],"resourceVersion":"1.0","name":"get_color_ext","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_system","kind":12,"help":"widget_get_system()","hidden":false,"returnType":1,"argCount":0,"args":[],"resourceVersion":"1.0","name":"widget_get_system","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_system","kind":12,"help":"widget_set_system(sys)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_system","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_message_cancelable","kind":12,"help":"show_message_cancelable(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_message_cancelable","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_question_cancelable","kind":12,"help":"show_question_cancelable(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_question_cancelable","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"show_attempt","kind":11,"help":"show_attempt(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"show_attempt","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_caption","kind":12,"help":"widget_get_caption()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_caption","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_caption","kind":12,"help":"widget_set_caption(str)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_caption","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_owner","kind":12,"help":"widget_get_owner()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"widget_get_owner","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_owner","kind":12,"help":"widget_set_owner(hwnd)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_owner","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_get_icon","kind":12,"help":"widget_get_icon()","hidden":false,"returnType":1,"argCount":0,"args":[],"resourceVersion":"1.0","name":"widget_get_icon","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"widget_set_icon","kind":12,"help":"widget_set_icon(icon)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"widget_set_icon","tags":[],"resourceType":"GMExtensionFunction",},
      ],"constants":[
        {"value":"\"Win32\"","hidden":false,"resourceVersion":"1.0","name":"ws_win32","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"Cocoa\"","hidden":false,"resourceVersion":"1.0","name":"ws_cocoa","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"Zenity\"","hidden":false,"resourceVersion":"1.0","name":"ws_x11_zenity","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"\"KDialog\"","hidden":false,"resourceVersion":"1.0","name":"ws_x11_kdialog","tags":[],"resourceType":"GMExtensionConstant",},
        {"value":"window_handle()","hidden":false,"resourceVersion":"1.0","name":"hwnd_main","tags":[],"resourceType":"GMExtensionConstant",},
      ],"ProxyFiles":[],"copyToTargets":134217856,"order":[
        {"name":"show_message","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_question","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_error","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_string","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_password","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_integer","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_passcode","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filename","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filename_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filenames","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_open_filenames_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_save_filename","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_save_filename_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_directory","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_directory_alt","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_color","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"get_color_ext","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_system","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_system","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_message_cancelable","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_question_cancelable","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"show_attempt","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_caption","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_caption","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_owner","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_owner","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_get_icon","path":"extensions/DialogModule/DialogModule.yy",},
        {"name":"widget_set_icon","path":"extensions/DialogModule/DialogModule.yy",},
      ],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
    {"filename":"DialogModule.so.zip","origname":"extensions\\DialogModule.so.zip","init":"","final":"","kind":4,"uncompress":false,"functions":[],"constants":[],"ProxyFiles":[],"copyToTargets":0,"order":[],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
  ],
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
    "Sprites\\spr_example",
    "Objects\\obj_example",
    "Rooms\\rm_example",
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
  "name": "DialogModule",
  "tags": [],
  "resourceType": "GMExtension",
}