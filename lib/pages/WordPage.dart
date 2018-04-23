import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../classes/Word.dart';
import '../widgets/Favorite.dart';
import '../globals/AdsManager.dart';

class WordPage extends StatefulWidget {
  WordPage({Key key, this.word, this.title}) : super(key: key);
  final Word word;
  final bool title;

  factory WordPage.base(Word word) {
    return WordPage(word: word, title: false);
  }

  @override
  _WordPageState createState() => new _WordPageState();
}

class _WordPageState extends State<WordPage> {
  static AdsManager ads = new AdsManager();

  @override
  void dispose() {
    ads.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    ads.show();

    if (widget.word == null) return new Padding(
      padding: EdgeInsets.only(bottom: 0.0),
      child: new Center(
        child: new Text(
          "Ordet for i dag er ikke tilgjengelig enda",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
    
    else return new Scaffold(
      appBar: (widget.title 
        ? new AppBar(title: new Text(widget.word.word)) 
        : null),
      body: new Padding(
        padding: EdgeInsets.only(bottom: 100.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.fromLTRB(25.0,20.0,25.0,3.0),
              child: new Text(
                widget.word.word,
                style: Theme.of(context).textTheme.display1
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(25.0,3.0,25.0,3.0),
              child: new Text(
                widget.word.pronounciation,
                style: Theme.of(context).textTheme.caption
              )
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(25.0,3.0,25.0,3.0),
              child: new Text(
                widget.word.type,
                style: Theme.of(context).textTheme.caption
              ),
            ),
            new Padding(
              padding: new EdgeInsets.all(25.0),
              child: new Text(
                widget.word.description,
                style: Theme.of(context).textTheme.body2
              )
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(25.0,0.0,25.0,0.0),
              child: new Text(
                widget.word.example,
                style: Theme.of(context).textTheme.body1
              )
            ),
            new Padding(
              padding: new EdgeInsets.all(25.0),
              child: new SizedBox(
                height: 3.0,
                width: 50.0,
                child: new Container(
                  decoration: new BoxDecoration(
                    color: Colors.grey[400]
                  ),
                )
              )
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(25.0,0.0,25.0,0.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Favorite(word: widget.word),
                  ),
                  new Expanded(
                    child: new GestureDetector(
                      child: new Container(
                        color: Colors.transparent,
                          child: new Row(
                            children: <Widget>[
                              new Icon(
                                Icons.search,
                                size: 40.0
                              ),
                              new Flexible(
                                child: new Padding(
                                  padding: new EdgeInsets.symmetric(horizontal: 5.0),
                                  child: new Text("Søk etter " + widget.word.word.toLowerCase()),
                                )
                              ),
                            ],
                          ),
                        ),
                      onTap: () async {
                        var url = 'https://www.google.com/search?q=' + widget.word.word;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}