import 'dart:convert';
import 'dart:typed_data';

import 'package:english_order/models/bilder.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

Set<String> bilder = {};

void addBild(String name) {
  bilder.add(name);
}

void removeBild(String name) {
  bilder.remove(name);
}

bool getBildURL(String text) {
  final Box box = Hive.box<Bilder>('bilderBox');
  for (int i = 0; i < box.length; i++) {
    if (box.getAt(i).name.toString() == text) {
      return false;
    }
  }
  return true;
}

Uint8List getBildByte(String text) {
  final Box box = Hive.box<Bilder>('bilderBox');
  for (int i = 0; i < box.length; i++) {
    if (box.getAt(i).name.toString() == text) {
      return box.getAt(i).bild;
    }
  }
  return box.getAt(0).bild;
}

Future initImages() async {
  Set<String> _bilder = {};
  final Box box = Hive.box<Bilder>('bilderBox');
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  final imagePaths =
      manifestMap.keys.where((String key) => key.contains('images/')).toList();
  for (var i in imagePaths) {
    String s = i.substring(i.indexOf('images/') + 7);
    _bilder.add(s);
  }
  for (int i = 0; i < box.length; i++) {
    _bilder.add(box.getAt(i).name.toString());
  }
  bilder = _bilder;
}
