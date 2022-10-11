import 'package:english_order/models/product.dart';
import 'package:hive/hive.dart';

class DbController {
  Box box = Hive.box<Product>('peopleBox');

  void addProductToDB(Product product) {
    box.add(product);
  }

  void updateProduct(int index, Product product) {
    box.putAt(index, product);
  }

  void deleteProductAt(int index) {
    box.deleteAt(index);
  }

  void deleteAllProducts() {
    box.deleteAll(box.keys);
  }

  void addListToHive(List<Product> proList) {
    for (var e in proList) {
      box.add(e);
    }
  }

  List hasTitle(String value) {
    return box.values.where((item) => item.title == value).toList();
  }
}
