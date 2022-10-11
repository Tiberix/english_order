import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final double preis;
  @HiveField(3)
  String? kategorie;
  @HiveField(4)
  String? beschreibung;

  Product(
      {required this.title,
      required this.image,
      required this.preis,
      this.kategorie,
      this.beschreibung});

  Map<String, dynamic> toJsonName(String name) => {
        'title': title,
        'image': image,
        'preis': preis,
        'kategorie': kategorie,
        'beschreibung': beschreibung,
        'MenuName': name
      };

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'preis': preis,
        'kategorie': kategorie,
        'beschreibung': beschreibung,
      };

  Product.fromSnapshot(snapshot)
      : title = snapshot.data()['title'],
        image = snapshot.data()['image'],
        preis = snapshot.data()['preis'].toDouble(),
        kategorie = snapshot.data()['kategorie'],
        beschreibung = snapshot.data()['beschreibung'];
}

List<Product> getProdukte() {
  late final Box box;
  box = Hive.box<Product>('peopleBox');
  if (box.isEmpty) {
    return demoProducts;
  }

  Map boxmap = box.toMap();
  List<Product> list = [];
  boxmap.forEach((key, value) {
    list.add(value);
  });
  return list;
}

List<Product> demoProducts = [
  Product(
      title: "Latte Macchiato",
      image: "Latte_Macchiato.png",
      preis: 2.59,
      kategorie: "HOT ESPRESSO",
      beschreibung: "Strong espresso over foamed milk"),
  Product(
    title: "Cappuccino",
    image: "Cappuccino.png",
    preis: 2.63,
    kategorie: "HOT ESPRESSO",
    beschreibung: "Strong espresso with velvety frothed milk",
  ),
  Product(
      title: "Vanilla Latte",
      image: "Vanilla_Latte.png",
      preis: 4.49,
      kategorie: "HOT ESPRESSO",
      beschreibung:
          "Strong espresso with velvety foamed milk and vanilla syrup"),
  Product(
    title: "Mocha",
    image: "Kaffe_Mocha.png",
    preis: 4.79,
    kategorie: "HOT ESPRESSO",
    beschreibung:
        "Strong espresso with velvety frothed milk, mocha sauce and cream",
  ),
  Product(
    title: "White Mocha",
    image: "White_Mocha.png",
    preis: 4.79,
    kategorie: "HOT ESPRESSO",
    beschreibung:
        "Strong espresso with velvety frothed milk, white mocha sauce and cream",
  ),
  Product(
    title: "Espresso",
    image: "Esspresso.png",
    preis: 2.50,
    kategorie: "HOT ESPRESSO",
    beschreibung: "Strong espresso",
  ),
  Product(
    title: "Caffe",
    image: "Kaffe.png",
    preis: 2.40,
    kategorie: "Filterkaffe",
    beschreibung: "Medium roast coffee with a smooth, balanced and rich taste",
  ),
  Product(
    title: "White Chocolate",
    image: "White_chocolate.png",
    preis: 3.00,
    kategorie: "HEISSE SCHOKOLADE",
    beschreibung: "White chocolate powder with milk and cream",
  ),
  Product(
    title: "Premium Chocolate",
    image: "Premium_heisse_Schokolade.png",
    preis: 3.10,
    kategorie: "HEISSE SCHOKOLADE",
    beschreibung: "Our premium hot chocolate with milk and chocolate powder",
  ),
  Product(
    title: "Premium Hazelnut Chocolate",
    image: "Premium_Hasselnuss_heisse_Schokolade.png",
    preis: 3.10,
    kategorie: "HEISSE SCHOKOLADE",
    beschreibung:
        "Our Premium Hazelnut Chocolate with milk, hazelnut syrup and cream",
  ),
  Product(
    title: "Premium Caramel Chocolate",
    image: "Premium_Caramel_heisse_Schokolade.png",
    preis: 3.10,
    kategorie: "HEISSE SCHOKOLADE",
    beschreibung:
        "Our premium caramel chocolate with milk, caramel syrup and cream",
  ),
  Product(
    title: "Green Ice Tea",
    image: "Eistee_Gruener_Tee.png",
    preis: 2.49,
    kategorie: "KALTGETRÄNKE",
    beschreibung: "Green tea shaken by hand",
  ),
  Product(
    title: "Green peaches Ice Tea",
    image: "Eistee_gruener_Pirsich_Limonade.png",
    preis: 2.49,
    kategorie: "KALTGETRÄNKE",
    beschreibung: "Green tea shaken by hand with lemonade and peach syrup",
  ),
  Product(
    title: "Ice Tea Caramel Latte Macchiato",
    image: "Eiskaffe_Caramel_Latte_Macchiato.png",
    preis: 2.59,
    kategorie: "KALTGETRÄNKE",
    beschreibung:
        "Strong espresso with milk, vanilla syrup, ice cubes and caramel topping",
  ),
  Product(
    title: "Iced Coffee Mocha",
    image: "Eiskaffe_weiss_Mocha.png",
    preis: 3.59,
    kategorie: "KALTGETRÄNKE",
    beschreibung:
        "Strong espresso with milk and white mocha sauce, served with cream and ice cubes",
  ),
  Product(
    title: "Caramel Macchiato",
    image: "Latte_Macchiato.png",
    preis: 2.59,
    kategorie: "HOT ESPRESSO BEVERAGES",
    beschreibung:
        "Strong espresso with milk and mocha sauce, served with cream and ice cubes",
  ),
];
