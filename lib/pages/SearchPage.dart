import 'package:flutter/material.dart';
import 'dart:async';

import '../classes/Word.dart';

import '../widgets/WordCard.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.results}) : super(key: key);

  final Future<List<Word>> results;

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
          case ConnectionState.waiting: return new Text('Awaiting result...');
          default:
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            else if (snapshot.data.length > 0){
              return new Scrollbar(
                child: new ListView.builder(
                  padding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  itemCount: snapshot.data.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return new WordCard(word: snapshot.data[index]);
                  },
                ), 
              );
            } 
            else {
              return new Text(
                "Ingen ord matcher søket",
                style: Theme.of(context).textTheme.display1,
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