import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'bilder.g.dart';

@HiveType(typeId: 2)
class Bilder {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final Uint8List bild;

  Bilder({required this.name, required this.bild});
}
