// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, annotate_overrides, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables,

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:word_app/models/definition.dart';
import 'package:word_app/models/word.dart';
import 'package:word_app/key.dart';
import 'dart:convert';
import 'package:word_app/models/saved_words.dart';
import 'package:share_plus/share_plus.dart'; //library for share button

var now = DateTime.now();
var formatter = DateFormat('yyyy-MM-dd');
String dayOne = formatter.format(now.add(Duration(days: -1)));
String dayTwo = formatter.format(now.add(Duration(days: -2)));
String dayThree = formatter.format(now.add(Duration(days: -3)));
String dayFour = formatter.format(now.add(Duration(days: -4)));
String dayFive = formatter.format(now.add(Duration(days: -5)));
String daySix = formatter.format(now.add(Duration(days: -6)));
String daySeven = formatter.format(now.add(Duration(days: -7)));

Future<List<Word>> getAllWords() async {
  List<String> dates = [
    dayOne,
    dayTwo,
    dayThree,
    dayFour,
    dayFive,
    daySix,
    daySeven
  ];

  final response = await Future.wait(dates.map((d) => http.get(Uri.parse(
      'https://api.wordnik.com/v4/words.json/wordOfTheDay?date=$d&api_key=$apiKey'))));

  return response.map((r) {
    if (r.statusCode == 200) {
      return Word.fromJson(json.decode(r.body));
    } else {
      throw Exception('Failed to load word ');
    }
  }).toList();
}

class Main extends StatefulWidget {
  static final _savedWords = SavedWords.savedWords;
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late Future<List<Word>> futureWord;
  final _savedWords = Main._savedWords;
  @override
  void initState() {
    super.initState();
    futureWord = getAllWords();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<List<Word>>(
            future: futureWord,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Word> words = <Word>[];
                for (int i = 0; i < 7; i++) {
                  words.add(
                    Word(
                      word: snapshot.data![i].word, //word is instantiated
                      definitions: [
                        Definition(
                          text: snapshot.data![i].definitions[0].text,
                          partOfSpeech:
                              snapshot.data![i].definitions[0].partOfSpeech,
                          source: 'Powered by WordNik API',
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  child: Column(
                    children: words.map((word) => wordTemplate(word)).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Could not get any words!'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget wordTemplate(word) {
    final alreadySaved = _savedWords.contains(word.word);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        color: Colors.lightBlue[50], //color of each past word term box
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${word.word[0].toUpperCase()}${word.word.substring(1)}',
                        style: TextStyle(
                          ////word tect edit
                          fontFamily: 'Roboto',
                          fontSize: 20, //word size
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Text(
                        '${word.definitions[0].partOfSpeech}',
                        style: TextStyle(
                          //parts of speech text edit
                          fontFamily: 'Roboto',
                          fontSize: 15, //parts of speech size
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          Share.share(
                              'Check out our app http://localhost:50666/#/',
                              subject: 'Vernacular: Word of the Day App');
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          alreadySaved ? Icons.favorite : Icons.favorite_border,
                          color: alreadySaved ? Colors.red : null,
                        ),
                        onPressed: () => {
                          setState(() {
                            if (alreadySaved) {
                              print('Removing: ' + word.word);
                              _savedWords.remove(word.word);
                              print(_savedWords);
                            } else {
                              print('Adding: ' + word.word);
                              _savedWords.add(word.word);
                              print(_savedWords);
                            }
                          })
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '${word.definitions[0].text}',
                //past text definitions text edit
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*

  Text(
                word.definitions[0].partOfSpeech,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                word.definitions[0].text,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
*/

