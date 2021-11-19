// ignore_for_file: deprecated_member_use, prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_final_fields, use_key_in_widget_constructors, unused_field
//favorites screen
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:word_app/components/drawer.dart';
import 'package:word_app/screens/Home%20Screen/Components/home_screen.dart';
import 'package:word_app/screens/Home%20Screen/Components/past_words/past_words.dart';
import 'package:word_app/models/saved_words.dart';

class Nav extends StatefulWidget {
  static final _savedWords = SavedWords.savedWords;
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    PastWords(),
  ];
  var _savedWords = Nav._savedWords;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openFavoriteWords() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Favorite Words',
            ),
            elevation: 0.0,
          ),
          body: Container(
            child: _savedWords.isNotEmpty
                ? ListView(
                    children: _savedWords
                        .map(
                          (word) => Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Card(
                              color: Colors.lightBlue[
                                  50], //color of each past word term box
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                ),
                              ),
                              elevation: 2.0,
                              child: Text(
                                ' ${word[0].toUpperCase()}${word.substring(1)}',
                                style: TextStyle(fontSize: 35.0),
                              ),
                            ),
                          ),
                        )
                        .toList())
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'No Favorite Words! Try clicking the heart next to your favorite word :)',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Mydrawer(),
      appBar: AppBar(
        title: Text('Word of the Day'),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: _openFavoriteWords,
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.calendarWeek,
            ),
            title: Text('WOTD'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            title: Text('Past Words'),
          ),
        ],
        selectedItemColor: Colors.white,
        selectedFontSize: 16.0,
        unselectedItemColor: Colors.white,
        unselectedFontSize: 12.0,
        backgroundColor: Colors.blue[900],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
