import 'package:flutter/material.dart';
import '../classes/Word.dart';
import '../globals/WordManager.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => new _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  WordManager wm = new WordManager();

  _changeWord() {
    setState(() {
      wm.wordList[0] = new Word(
        word: 'new test word',
        pronounciation: 'how to pronounce the word',
        type: 'type of the word',
        description: 'description of the word',
        example: 'example of the word in use',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text(wm.wordList[0].word),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _changeWord,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
