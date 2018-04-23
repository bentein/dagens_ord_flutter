import 'package:flutter/material.dart';

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
  WordManager wm = new WordManager();
  DataAccess dao = new DataAccess();
  LocalStorage lst = new LocalStorage();

  String _refreshMessage = " Last inn eldre ord";
  IconData ico = Icons.refresh;

  _getHistory() async {
    int lastEntry = Word.getDaysSince(wm.wordList.last);
    List<Word> list = (await dao.getWords(Word.getPastDate(lastEntry + 10), Word.getPastDate(lastEntry+1)));
    setState(() {
      if (list.length == 0) {
        _refreshMessage = " Det er dessverre ingen eldre ord";
        ico = Icons.close;
      }
      wm.addWordList(list);
    });
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
            itemCount: wm.wordList.length + 1,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (index < wm.wordList.length) return new WordCard(word: wm.wordList[index]);
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
              );
            },
          ), 
        ),
      ),
    );
  }
}
