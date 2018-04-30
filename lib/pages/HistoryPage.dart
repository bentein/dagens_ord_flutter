import 'package:flutter/material.dart';
import 'dart:async';
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

  ScrollController controller = new ScrollController();

  List<Word> historyList = initHistoryList();

  static List<Word> initHistoryList() {
    List<Word> histList = <Word>[];

    for (int i = 0; i < 6; i++) {
      histList.add(wm.wordList[i]);
    }

    return histList;
  }

  Future<List<Word>> newWordsFuture = new Future((){});
  bool dbExhausted = false;
  bool doUpdate = true;

  Future<List<Word>> getNewWords() {
    Future<List<Word>> newWords = new Future(() {
      List<Word> newWordsList = <Word>[];

      if (historyList.length < wm.wordList.length) {
        int index = 0;
        for (int i = historyList.length; i < wm.wordList.length && index < 2; i++) {
          newWordsList.add(wm.wordList[i]);
          index++;
        }
      } else if (!dbExhausted) {
        int lastEntry = Word.getDaysSince(wm.wordList.last);
        return dao.getWords(Word.getPastDate(lastEntry + 10), Word.getPastDate(lastEntry+1));
      }
      return newWordsList;
    });

    setState(() {
      newWordsFuture = newWords;
    });

    return newWords;
  }

  void _getHistory() async {
    List<Word> newWords = await getNewWords();

    setState(() {
      if (newWords.length == 0) {
        dbExhausted = true;
      } else {
        historyList.addAll(newWords);
      }
    });
    
    wm.addWordList(newWords);

    new Future.delayed(new Duration(milliseconds: 100), () {
      doUpdate = true;
    });

  }

  Widget getListView(int listLength) {
    return new ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
      controller: controller,
      itemCount: listLength,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index < historyList.length) return new WordCard(word: historyList[index]);
        else return new Center(
          child: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: new CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new NotificationListener(
        onNotification: (ScrollUpdateNotification n) {
          if (!dbExhausted && doUpdate && controller.position.pixels > controller.position.maxScrollExtent * (4/5)) {
            doUpdate = false;
            _getHistory();
          }
          return true;
        },
        child: getListView(dbExhausted ? historyList.length : historyList.length + 1),
      ),
    );
  }
}
