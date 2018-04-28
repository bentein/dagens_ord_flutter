import 'package:flutter/material.dart';
import 'dart:math';

import '../classes/Word.dart';

import '../globals/WordManager.dart';
import '../globals/DataAccess.dart';
import '../globals/LocalStorage.dart';

import '../widgets/WordCard.dart';


class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => new _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  static WordManager wm = new WordManager();
  static DataAccess dao = new DataAccess();
  static LocalStorage lst = new LocalStorage();

  bool wordListExhausted = false;
  bool doSearch = false;
  int listLength = min(5, wm.wordList.length);

  _getHistory() async {
    setState(() {
      if (!wordListExhausted && listLength < wm.wordList.length + 10) {
        listLength = min(listLength + 10, wm.wordList.length);
      } else {
        wordListExhausted = true;
        doSearch = true;
      }
    });

    if (doSearch) {
      int lastEntry = Word.getDaysSince(wm.wordList.last);
      List<Word> receivedWords = (await dao.getWords(Word.getPastDate(lastEntry + 10), Word.getPastDate(lastEntry+1)));
    
      setState(() {
        if (receivedWords.length == 0) {
          doSearch = false;
        } else {
          wm.addWordList(receivedWords);
          listLength = wm.wordList.length;
        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new NotificationListener(
        onNotification: (OverscrollNotification n) {
          if (n.overscroll > 1) {
            _getHistory();
          }
          return true;
        },
        child: new Scrollbar(
          child: new ListView.builder(
            padding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
            itemCount: listLength,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return new WordCard(word: wm.wordList[index]);
              /* if (index < wm.wordList.length) 
              else return new Padding(
                padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                child: new GestureDetector(
                  child: new Container(
                    color: Colors.transparent,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(ico),
                        new Text(_refreshMessage),
                      ],
                    ),
                  ),
                  onTap: _getHistory,
                ),
              ); */
            },
          ), 
        ),
      ),
    );
  }
}
