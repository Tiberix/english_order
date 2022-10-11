import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_order/controllers/db_controller.dart';
import 'package:english_order/models/product.dart';

List<String> menus = [];
bool titleExists = false;

Future saveMenu(List<Product>? proList, String name) async {
  for (int i = 0; i < proList!.length; i++) {
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(name + ':' + proList[i].title)
        .set(proList[i].toJsonName(name), SetOptions(merge: false));
  }
}

Future saveMenuTitle(String name) async {
  final data = {"MenuName": name};
  try {
    FirebaseFirestore.instance
        .collection("Menus")
        .doc(name)
        .set(data, SetOptions(merge: true));
  } catch (e) {
    rethrow;
  }
  //await FirebaseFirestore.instance.collection('Menus').add(data);
}

Future menuExists(String name) async {
  var data = await FirebaseFirestore.instance.collection('Menus').get();
  menus = List.from(data.docs.map((e) => e.data()['MenuName']));
  if (menus.contains(name)) {
    titleExists = true;
    return;
  }
  titleExists = false;
}

Future getMenu(String name) async {
  DbController db = DbController();
  var data = await FirebaseFirestore.instance
      .collection('Products')
      .where('MenuName', isEqualTo: name)
      .get();
  db.deleteAllProducts();
  db.addListToHive(List.from(data.docs.map((e) => Product.fromSnapshot(e))));
}

Future getMenuOptions() async {
  var data = await FirebaseFirestore.instance.collection('Menus').get();
  menus = List.from(data.docs.map((e) => e.data()['MenuName']));
}
