// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, annotate_overrides, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables,

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:word_app/models/definition.dart';
import 'package:word_app/models/word.dart';
import 'package:word_app/key.dart';
import 'dart:convert';

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

  final response = await Future.wait(dates.map((d) => http.get(
      'https://api.wordnik.com/v4/words.json/wordOfTheDay?date=$d&api_key=$apiKey')));

  return response.map((r) {
    if (r.statusCode == 200) {
      return Word.fromJson(json.decode(r.body));
    } else {
      throw Exception('Failed to load word ');
    }
  }).toList();
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late Future<List<Word>> futureWord;
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
                      word: snapshot.data![i].word,
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
                  child: Text('Could not get words!'),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        color: Colors.white,
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
                          '${word.word[0].toUpperCase()}${word.word.substring(1)}'),
                      Text(
                        '${word.definitions[0].partOfSpeech}',
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
                      /*   Text(
                        '${word.definitions[0].text}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      */
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.share),
                      Icon(Icons.favorite),
                    ],
                  ),
                ],
              ),
              Text(
                '${word.definitions[0].partOfSpeech}',
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
                '${word.definitions[0].text}',
                style: TextStyle(
                  fontSize: 16.0,
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

