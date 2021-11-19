// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, unused_import, prefer_const_constructors, sized_box_for_whitespace, annotate_overrides, avoid_print, unused_field, missing_required_param
// @dart=2.9
//main screen
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:word_app/models/word.dart';
import 'package:word_app/key.dart';
import 'dart:convert';
import 'package:word_app/models/saved_words.dart';
import 'package:share_plus/share_plus.dart'; //library for share button

var now = DateTime.now();
var formatter = DateFormat('yyyy-MM-dd');
String today = formatter.format(now);

final String url = 'https://api.wordnik.com/v4/words.json/wordOfTheDay?date=' +
    today +
    '&api_key=' +
    apiKey;

Future<Word> fetchWord() async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("got JSON");
    return Word.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Didnt get JSON :( ");
    throw Exception('Failed to load Word.');
  }
}

class Main extends StatefulWidget {
  static final _savedWords = SavedWords.savedWords;
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Future<Word> futureWord;
  final _savedWords = Main._savedWords;
  @override
  void initState() {
    super.initState();
    futureWord = fetchWord();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Card(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        elevation: 4.0,
        child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder<Word>(
                  future: futureWord,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //TODO display Data
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // ignore: unnecessary_string_interpolations
                                '${snapshot.data.word[0].toUpperCase()}${snapshot.data.word.substring(1)}',
                                style: TextStyle(
                                    fontSize: 50, //word size
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.mic,
                                size: 35.0,
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data.definitions[0].partOfSpeech,
                            style: TextStyle(
                              //mainscreen POS text edit
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            snapshot.data.definitions[0].text,
                            style: TextStyle(
                                //mainscreen defintion text edit
                                fontSize: 30,
                                fontFamily: 'Roboto',
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.w300),
                          ),
                          buildRow(snapshot.data.word),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('OOF! Could not fetch word of the day');
                      //   var myWord = futureWord.W
                      //   return Text("Word: $futureWord");
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )
              ],
            )),
      ),
    );
  }

  Widget buildRow(word) {
    final alreadySaved = _savedWords.contains(word);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.skip_next_rounded, size: 30),
          onPressed: () => {
            setState(() {
              Word();
            })
          },
        ),
        //share button
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            Share.share('Check out our app http://localhost:50666/#/');
          },
        ),
        //favorite button (main screen)
        IconButton(
          icon: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
          ),
          onPressed: () => {
            setState(() {
              if (alreadySaved) {
                print('Removing: ' + word);
                _savedWords.remove(word);
                print(_savedWords);
              } else {
                print('Adding: ' + word);
                _savedWords.add(word);
                print(_savedWords);
              }
            })
          },
        ),
      ],
    );
  }
}
