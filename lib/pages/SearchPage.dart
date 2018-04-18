import 'package:flutter/material.dart';
import 'dart:async';

import '../classes/Word.dart';

import '../widgets/WordCard.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.results, this.filters}) : super(key: key);

  final Future<List<Word>> results;
  final List<String> filters;

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget getSearchBody() {
    return new FutureBuilder<List<Word>>(
      future: widget.results,
      builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
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
                  "Søker",
                  style: Theme.of(context).textTheme.display1,
                )
              ],
            ),
          );
          default:
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            else if (snapshot.data.length > 0){
              int items = 0;
              List<Widget> cardList = [];

              snapshot.data.sort((a,b) => b.date.compareTo(a.date));
              snapshot.data.forEach((Word word) {
                if (widget.filters.length == 0 || widget.filters.contains(word.type)) {
                  cardList.add(new WordCard(word: word));
                  items++;
                } else if (word.categories.length > 0) {
                  word.categories.forEach((str) {
                    if (widget.filters.contains(str)) {
                      cardList.add(new WordCard(word: word));
                      items++;
                    }
                  });
                }
              });
              
              Widget sb = new Scrollbar(
                child: new ListView(
                  padding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  physics: AlwaysScrollableScrollPhysics(),
                  children: cardList,
                ), 
              );

              Widget error = new Center(
                child: new Text(
                  "Ingen ord matcher søket",
                  style: Theme.of(context).textTheme.display1,
                ),
              );
              
              if (items == 0) return error;
              else return sb;
            } 
            else {
              return new Center(
                child: new Text(
                "Ingen ord matcher søket",
                style: Theme.of(context).textTheme.display1,
                ),
              );
            }
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: (widget.results != null
          ? getSearchBody()
          : new Center(
              child: new Text(
                "Klikk på knappene over\n for å søke eller\n filtrere resultatene",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display1,
              )
            )
        ),
    );
  }

}