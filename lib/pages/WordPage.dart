import 'package:flutter/material.dart';

import '../classes/Word.dart';
import '../widgets/Favorite.dart';
import '../globals/Variables.dart' show APP_ID, WORD_PAGE_BANNER_ID, PROD;

import 'package:firebase_admob/firebase_admob.dart';

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
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: APP_ID != null ? [APP_ID] : null,
    keywords: ['Words', 'Learning', 'Information', 'Dictionary'],
  );

  BannerAd bannerAd;

  BannerAd buildBanner() {
    return BannerAd(
      adUnitId: (PROD
        ? WORD_PAGE_BANNER_ID
        : BannerAd.testAdUnitId),
      targetingInfo: targetingInfo,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        //print(event);
      }
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    bannerAd = buildBanner()..load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bannerAd..load()..show();
    return new Scaffold(
      appBar: (widget.title 
        ? new AppBar(title: new Text(widget.word.word)) 
        : null),
      body: new Column(
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
          ), new Padding(
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
                    child: new Row(
                      children: <Widget>[
                        new Icon(
                          Icons.search,
                          size: 40.0
                        ),
                        new Padding(
                          padding: new EdgeInsets.symmetric(horizontal: 5.0),
                          child: new Text("Søk etter " + widget.word.word.toLowerCase()),
                        )
                      ],
                    ),
                    onTap: () {
                      print("search");
                    }
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}