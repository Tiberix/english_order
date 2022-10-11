import 'package:english_order/util/constants.dart';
import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  final String titel;
  MyAppBar(
    this.titel, {
    Key? key,
  }) : super(
            key: key,
            leading: const BackButton(),
            toolbarHeight: 85,
            backgroundColor: primaryColor, //const Color(0xFFF8F8F8),
            elevation: 0,
            centerTitle: true,
            title:
                Text(titel, style: const TextStyle(color: Color(0xFFEAEAEA))),
            iconTheme: const IconThemeData(color: Color(0xFFEAEAEA)));
}
