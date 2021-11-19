// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();
var formatter = DateFormat.yMMMd('en_US');
String today = formatter.format(now);

class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                today,
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 35.0,
                ),
              )
            ],
          ),
        ));
  }
}
