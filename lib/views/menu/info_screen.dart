import 'package:english_order/components/my_app_bar.dart';
import 'package:english_order/components/my_drawer.dart';
import 'package:english_order/components/price.dart';
import 'package:english_order/controllers/bild_controller.dart';
import 'package:english_order/controllers/firestore_controller.dart';
import 'package:english_order/util/constants.dart';
import 'package:english_order/models/product.dart';
import 'package:flutter/material.dart';
import 'package:english_order/views/menu/components/update_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:english_order/views/menu/components/add_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();

  static const String routeName = '/InfoScreen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const InfoScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }
}

class _InfoScreenState extends State<InfoScreen> {
  static Box contactBox = Hive.box<Product>('peopleBox');
  final _namecontroller = TextEditingController();

  List<Product>? proList = getProdukte();

  _deleteInfo(int index) {
    contactBox.deleteAt(index);
  }

  Future<void> loadMenuDialog() async {
    await getMenuOptions();
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Load Menu..'),
            content: setupAlertDialoadContainer(menus),
          );
        });
  }

  Future<void> saveMenuDialog() async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Save as..'),
            content: Column(
              children: [
                const Text('Menuname'),
                TextField(
                  controller: _namecontroller,
                  decoration: const InputDecoration(hintText: 'Enter Name'),
                ),
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () async {
                  await menuExists(_namecontroller.text);
                  if (!titleExists) {
                    saveMenuTitle(_namecontroller.text);
                    saveMenu(getProdukte(), _namecontroller.text);
                  }
                  Navigator.pop(context);
                },
                color: Colors.pink,
                child: const Text('Submit'),
              )
            ],
          );
        });
  }

  Widget setupAlertDialoadContainer(List<String> tlist) {
    return SizedBox(
      height: 300.0,
      width: 300.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tlist.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: MaterialButton(
            onPressed: () {
              getMenu(tlist[index]);
              Navigator.pop(context);
            },
            color: Colors.green,
            child: Text(tlist[index]),
          ));
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('Menu'),
      endDrawer: MyDrawer(con: context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          loadMenuDialog();
                        },
                        child: const Text('Load Menu')),
                    ElevatedButton(
                        onPressed: () {
                          saveMenuDialog();
                        },
                        child: const Text('Save Menu')),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: contactBox.listenable(),
                    builder: (context, Box box, widget) {
                      if (box.isEmpty) {
                        return const Center(
                          child: Text('Empty'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            var currentBox = box;
                            var personData = currentBox.getAt(index)!;

                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                    index: index,
                                    person: personData,
                                  ),
                                ),
                              ),
                              child: Card(
                                color: const Color(0xFFF8F8F8),
                                clipBehavior: Clip.antiAlias,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: getBildURL(
                                            personData.image.toString())
                                        ? AssetImage(
                                            bildPfad + personData.image)
                                        : Image.memory(
                                                getBildByte(personData.image))
                                            .image,
                                  ),
                                  title: Text(personData.title),
                                  subtitle: Price(
                                      amount:
                                          personData.preis.toStringAsFixed(2)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => UpdateScreen(
                                              index: index,
                                              person: personData,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
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
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
