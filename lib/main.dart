import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_scanner/media_scanner.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(Abc());
}

eatItSnackBar(context, String message) {
  var snackBar = SnackBar(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    dismissDirection: DismissDirection.startToEnd,
    backgroundColor: const Color.fromARGB(213, 5, 5, 5),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    content: Text(
      message,
      style: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 16,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class Abc extends StatelessWidget {
  still(context) async {
    var file_paths;
    var saving_path;

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var whatsAppBusuiness =
        '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses';
    var whatsApp =
        '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses';
    if (Directory(whatsAppBusuiness).existsSync()) {
      file_paths = whatsAppBusuiness;
    } else if (Directory(whatsApp).existsSync()) {
      file_paths = whatsApp;
    } else {
      eatItSnackBar(context, "your phone sucks");
    }

    var camera = '/storage/emulated/0/DCIM/Camera';
    var screenShot = '/storage/emulated/0/DCIM/Screenshots';
    var pictures = '/storage/emulated/0/Pictures';
    var download = '/storage/emulated/0/Download';

    if (Directory(camera).existsSync()) {
      saving_path = camera;
    } else if (Directory(screenShot).existsSync()) {
      saving_path = screenShot;
    } else if (Directory(pictures).existsSync()) {
      saving_path = pictures;
    } else if (Directory(download).existsSync()) {
      saving_path = download;
    } else if (Directory(download).existsSync()) {
      saving_path = download;
    } else {
      saving_path = '/storage/emulated/0';
    }

    var directory = Directory(file_paths);
    var files = directory.listSync();
    var count = 0;
    for (var e in files) {
      var name = e.path.split('/').last;
      if (name == ".nomedia") continue;
      // var newLocation = '${saved}/${count.toString()}.${name.split(".").last}';
      var newLocation = '$saving_path/${count.toString()}.$name';
      var file = File(e.path);
      file.copySync(newLocation);
      MediaScanner.loadMedia(path: newLocation.toString());
      count++;
    }
    eatItSnackBar(context, "Done");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onLongPress: () {
                        eatItSnackBar(context, "Just Click it Man");
                      },
                      child: const Text("Click"),
                      onPressed: () {
                        still(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
