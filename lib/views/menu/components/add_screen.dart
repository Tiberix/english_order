import 'package:english_order/components/my_app_bar.dart';
import 'package:english_order/views/menu/components/add_form.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar('Add Item'),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AddForm(),
      ),
    );
  }
}
