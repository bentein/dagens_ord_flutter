import 'package:flutter/material.dart';
import 'dart:async';

import 'classes/Word.dart';

import 'pages/MyHomePage.dart';

import 'globals/WordManager.dart';
import 'globals/AdsManager.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static final WordManager wm = new WordManager();
  static final AdsManager ads = new AdsManager();

  static final Future<bool> future = new Future<bool>(() async {
    bool adsFuture = await ads.load();
    List<Word> wotdFuture = await wm.initWOTD();
    bool wlFuture = await wm.initWordList();

    if (adsFuture && wlFuture && wotdFuture != null) {
      return true;
    } else {
      return false;
    }
  });

  static final Widget loadingBody = new Scaffold(
    appBar: new AppBar(),
    body: new Center(
      child: new Builder(
        builder: (BuildContext context) {
          return new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
              new Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
              new Text(
                "Laster inn...",
                style: Theme.of(context).textTheme.display1,
              )
            ],
          );
        },
      ),
    ),
  );

  final Widget body = new FutureBuilder<bool>(
    future: future,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none: return new Text('Press button to start');
        case ConnectionState.waiting: return loadingBody;
        
        default:
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          else if (snapshot.data) return new MyHomePage();
      }
    }
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Dagens Ord',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: body,
    );
  }
}
