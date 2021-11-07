// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:word_app/components/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vernacular+',
      theme: ThemeData(
        primaryColor: Color(0xffffffff),
      ),
      debugShowCheckedModeBanner: false,
      home: Nav(),
    );
  }
}
