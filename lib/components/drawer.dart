// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace
//NAVIGATION PANEL
import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 100.0,
          child: DrawerHeader(
            child: Text(
              'Word of the Day',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.lightBlue[50]),
          height: 50.0,
          child: ListTile(
            title: const Text('About'),
            onTap: () {
              //will open about page on click

              Navigator.pop(context); //closes drawer onclick
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.lightBlue[50]),
          height: 50.0,
          child: ListTile(
            title: const Text('Settings'),
            onTap: () {
              //will open settings page on click

              Navigator.pop(context); //closes drawer onclick
            },
          ),
        )
      ],
    ));
  }
}
