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

  Widget _getListView() {
    Widget widget;

    if (wm.favorites.length > 0) 
      widget = new ListView.builder(
        padding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        itemCount: wm.favorites.length,
        itemBuilder: (BuildContext context, int index) {
          return new WordCard(word: wm.favorites[index]);
        },
      );
    else 
      widget = new Center(
        child: new Text(
          "Du har ingen favorittord",
          style: Theme.of(context).textTheme.display1
        ),
      );
      
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _getListView(),
    );
  }
}
