import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import '../classes/Word.dart';
import '../globals/WordManager.dart';

import '../pages/WordPage.dart';

class WordCard extends StatefulWidget  {
  WordCard({this.word});
  final Word word;

  @override
  _WordCardState createState() => new _WordCardState();
}

class _WordCardState extends State<WordCard> {
  WordManager wm = new WordManager();
  bool _favorite = false;
  final double iconSize = 30.0;

  void _favoriteWord() {
    setState(() {
      if (!_favorite && wm.addFavorite(widget.word)) _favorite = !_favorite;
      else if (_favorite && wm.removeFavorite(widget.word)) _favorite = !_favorite;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (wm.isFavorite(widget.word)) _favorite = true;

    return new Material(
      child: new Card(
        child: new InkWell(
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new WordPage(word:widget.word, title: true)));
          },
          child: new Padding(
            padding: new EdgeInsets.all(15.0),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text(
                      widget.word.word,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                ),
                new Padding(
                  padding: new EdgeInsets.symmetric(vertical: 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        widget.word.description,
                      ),
                    ],
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        (_favorite ? Icons.favorite : Icons.favorite_border),
                        color : (_favorite ? Colors.red : Colors.black),
                        size: iconSize,
                      ),
                      onPressed: _favoriteWord,
                    ),
                    new IconButton(
                      icon: new Icon(
                        Icons.search,
                        size: iconSize,
                      ),
                      onPressed: () async {
                        var url = 'https://www.google.com/search?q=' + widget.word.word;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    new IconButton(
                      icon: new Icon(
                        Icons.share,
                        size: iconSize,
                      ),
                      onPressed: () {
                        share('Vet du hva ordet "' + widget.word.word + '" betyr? Lær det i dag med Dagens Ord!');
                      },
                    ),
                    new Expanded(
                      child: new Text(
                        widget.word.date.toString(),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}