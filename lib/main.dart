import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_scanner/media_scanner.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(Abc());
}

void eatItSnackBar(String message) {
  SnackBar snackBar = SnackBar(
    backgroundColor: const Color.fromARGB(213, 0, 0, 0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    dismissDirection: DismissDirection.startToEnd,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    content: Text(message),
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}

class Abc extends StatelessWidget {
  snackeatit(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  still() async {
    var file_paths;
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
      print("WhatsApp Business");
    } else if (Directory(whatsApp).existsSync()) {
      file_paths = whatsApp;
      print("WhatsApp");
    } else {
      print("No WhatsApp folder found");
      eatItSnackBar("Path not found");
    }

    var saved = '/storage/emulated/0/Dcim/Camera';
    var directory = Directory(file_paths);
    var files = directory.listSync();
    var count = 0;
    for (var e in files) {
      var name = e.path.split('/').last;
      print(name);
      if (name == ".nomedia") continue;
      var newLocation = '${saved}/${count.toString()}.${name.split(".").last}';
      print("f  " + newLocation);
      var file = File(e.path);
      file.copySync(newLocation);
      MediaScanner.loadMedia(path: newLocation.toString());
      print("Copied");
      eatItSnackBar("Done");
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(builder: (context) {
          return Center(
            child: ElevatedButton(
              child: const Text("Button"),
              onPressed: () {
                still();
              },
            ),
          );
        }),
      ),
    );
  }
}
