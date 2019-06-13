
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}

Padding padThis(Widget kid){
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    child: kid,
  );
}

Text whiteThis(String text){
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
       fontSize: 20.0
    )
  );
}

//This is just to demonstrate circular loading widget transitioning to ver numbers
//TODO: eventually remove this
Future sleepFetch() {
  return Future.delayed(const Duration(seconds: 5), () => "5");
}