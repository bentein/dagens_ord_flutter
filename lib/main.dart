import 'package:flutter/material.dart';

import 'pages/MyHomePage.dart';

import 'globals/WordManager.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static WordManager wm = new WordManager();

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new MyHomePage(),
    );
  }
}
