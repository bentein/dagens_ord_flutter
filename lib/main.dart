import 'package:flutter/material.dart';

import 'pages/MyHomePage.dart';

import 'globals/WordManager.dart';
import 'globals/AdsManager.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static WordManager wm = new WordManager();
  static AdsManager ads = new AdsManager();

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Dagens Ord',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new MyHomePage(),
    );
  }
}
