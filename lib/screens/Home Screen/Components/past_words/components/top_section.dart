// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

var now = DateTime.now().add(Duration(days: -1));
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
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
              ),
              Text(
                'Yesterday',
                style: TextStyle(
                  fontSize: 33.0,
                ),
              )
            ],
          ),
        ));
  }
}
