import 'package:flutter/material.dart';
import '../classes/Word.dart';

class Favorite extends StatefulWidget  {
  Favorite({this.word});
  final Word word;

  @override
  _FavoriteState createState() => new _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool _favorite = false;

  void _favoriteWord() {
    setState(() {
      _favorite = !_favorite;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Row(
        children: <Widget>[
          new Icon(
            (_favorite ? Icons.favorite : Icons.favorite_border),
            color: (_favorite ? Colors.red : Colors.black),
            size: 40.0,
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 5.0),
            child: new Text(
              (_favorite ? "Fjern favoritt" : "Favoritt")
            ),
          )
        ],
      ),
      onTap: _favoriteWord
    );
  }

}