import 'package:flutter/material.dart';
import '../classes/Word.dart';
import '../globals/WordManager.dart';
import '../globals/DataAccess.dart';
import '../widgets/WordCard.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => new _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  WordManager wm = new WordManager();
  DataAccess dao = new DataAccess();

  _changeWord() async {
    var list = (await dao.getWords(Word.getCurrentDate(), Word.getCurrentDate()));
    setState(() {
      list.forEach((word) {
        wm.addFavorite(word);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        padding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        itemCount: wm.favorites.length,
        itemBuilder: (BuildContext context, int index) {
          return new WordCard(word: wm.favorites[index]);
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _changeWord,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
