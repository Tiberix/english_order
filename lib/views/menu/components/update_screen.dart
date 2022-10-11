import 'package:english_order/components/my_app_bar.dart';
import 'package:english_order/models/product.dart';
import 'package:english_order/views/menu/components/update_form.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final Product person;

  const UpdateScreen({
    Key? key,
    required this.index,
    required this.person,
  }) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar('Edit Item'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UpdateForm(
          index: widget.index,
          person: widget.person,
        ),
      ),
    );
  }
}
