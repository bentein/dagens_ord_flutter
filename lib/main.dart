import 'package:flutter/material.dart';

import 'pages/MyHomePage.dart';

import 'globals/WordManager.dart';
import 'globals/AdsManager.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static WordManager wm = new WordManager();
  static AdsManager ads = new AdsManager();

  Widget body = new FutureBuilder<bool>(
    future: ads.load(),
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none: return new Text('Press button to start');
        case ConnectionState.waiting: return new Center(
          child: new Column(
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
          ),
        );
        
        default:
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          else return new MyHomePage();
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
