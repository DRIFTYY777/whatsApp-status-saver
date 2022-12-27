import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_scanner/media_scanner.dart';

void main() {
  runApp(Abc());
}

class Abc extends StatelessWidget {
  snackeatit(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  still() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var file_paths =
        '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses';
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
