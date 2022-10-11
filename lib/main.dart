import 'package:english_order/controllers/bild_controller.dart';
import 'package:english_order/views/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:english_order/controllers/route_controller.dart';
import 'package:english_order/util/constants.dart';
import 'package:english_order/controllers/cart_controller.dart';
import 'package:provider/provider.dart';
import 'package:english_order/models/bilder.dart';
import 'package:english_order/models/product.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(BilderAdapter());
  await Hive.openBox<Bilder>('bilderBox');
  await Hive.openBox<Product>('peopleBox');

  runApp(ChangeNotifierProvider(
    create: (context) => CartController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initImages();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EzOrder',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFFEAEAEA)),
          toolbarTextStyle: const TextTheme(
            headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
          ).bodyText2,
          titleTextStyle: const TextTheme(
            headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
          ).headline6,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        primarySwatch: Colors.blueGrey,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            shape: const StadiumBorder(),
            backgroundColor: primaryColor,
          ),
        ),
      ),
      onGenerateRoute: Approuter.onGeneratedRoute,
      initialRoute: HomeScreen.routeName,
    );
  }
}
