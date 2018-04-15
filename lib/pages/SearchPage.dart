import 'package:flutter/material.dart';

import '../classes/Word.dart';

import '../globals/WordManager.dart';
import '../globals/DataAccess.dart';
import '../globals/LocalStorage.dart';

import '../widgets/WordCard.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  WordManager wm = new WordManager();
  
  @override
  Widget build(BuildContext context) {
    return new Text("UNDER CONSTRUCTION");
  }

}