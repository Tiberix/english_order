import 'dart:io';
import 'dart:typed_data';
import 'package:english_order/components/my_app_bar.dart';
import 'package:english_order/components/my_drawer.dart';
import 'package:english_order/controllers/bild_controller.dart';
import 'package:english_order/models/bilder.dart';
import 'package:english_order/models/product.dart';
import 'package:english_order/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';

late Directory directory;

class Imageloader extends StatefulWidget {
  const Imageloader({Key? key}) : super(key: key);

  static const String routeName = '/Imageloader';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const Imageloader(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<Imageloader> createState() => _ImageloaderState();
}

class _ImageloaderState extends State<Imageloader> {
  final Box box = Hive.box<Bilder>('bilderBox');
  final Box pbox = Hive.box<Product>('peopleBox');
  List<File> bilderListe = [];

  Future<void> pickImage(ImageSource source) async {
    final _picker = ImagePicker();
    XFile? xselected = await _picker.pickImage(source: source);

    Uint8List uimage = await xselected!.readAsBytes();
    Bilder bild = Bilder(
        name: (xselected.name) //DateTime.now().toString())
        ,
        bild: uimage);
    box.add(bild);
    addBild(bild.name);
    setState(() {});
  }

  void _deleteInfo(int index) {
    String name = box.getAt(index).name;
    for (int i = 0; i < pbox.length; i++) {
      if (pbox.getAt(i).image.toString() == name) {
        return;
      }
    }
    removeBild(name);

    box.deleteAt(index);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar('My Images'),
        endDrawer: MyDrawer(con: context),
        body: Container(
          color: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          color: Colors.green,
                          child: const Text("Choose Picture from Gallery",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: box.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            var bildData = box.getAt(index)!;
                            return Column(
                              children: [
                                Expanded(
                                  child: Image(
                                    image: Image.memory(bildData.bild).image,
                                    width: 120,
                                    height: 180,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _deleteInfo(index),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
