// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:word_app/screens/Home%20Screen/Components/past_words/components/main.dart';
import 'package:word_app/screens/Home%20Screen/Components/past_words/components/top_section.dart';

class PastWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          TopSection(),
          Main(),
        ],
      ),
    );
  }
}
