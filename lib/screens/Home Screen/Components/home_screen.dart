// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:word_app/screens/Home%20Screen/Components/main.dart';
import 'package:word_app/screens/Home%20Screen/Components/top_section.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: ListView(
      children: [
        TopSection(),
        Main(),
      ],
    ));
  }
}
