import 'package:flutter/material.dart';

import 'WordPage.dart';
import 'FavoritesPage.dart';
import 'HistoryPage.dart';

import '../classes/Word.dart';
import '../globals/WordManager.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static WordManager wm = new WordManager();
  Widget body = new FutureBuilder<List<Word>>(
    future: wm.initWOTD(),
    builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none: return new Text('Press button to start');
        case ConnectionState.waiting: return new Text('Awaiting result...');
        default:
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          else return new WordPage.base(snapshot.data[0]);
      }
    }
  );
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text("Naviger"),
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
            ),
            new ListTile(
              title: new Row(
                children: <Widget>[
                  new Icon(Icons.bookmark_border),
                  new Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: new Text("Dagens Ord"),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  body = new WordPage.base(wm.wotd);
                  Navigator.pop(context);                  
                });
              },
            ),
            new ListTile(
              title: new Row(
                children: <Widget>[
                  new Icon(Icons.history),
                  new Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: new Text("Historie"),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  body = new HistoryPage();
                  Navigator.pop(context);           
                });
              },
            ),
            new ListTile(
              title: new Row(
                children: <Widget>[
                  new Icon(Icons.favorite_border),
                  new Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: new Text("Favoritter"),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  body = new FavoritesPage();
                  Navigator.pop(context);                  
                });
              },
            ),
            new ListTile(
              title: new Row(
                children: <Widget>[
                  new Icon(Icons.search),
                  new Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: new Text("Søk"),
                  ),
                ],
              ),
              onTap: () {

              },
            ),
            new ListTile(
              title: new Row(
                children: <Widget>[
                  new Icon(Icons.settings),
                  new Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: new Text("Instillinger"),
                  ),
                ],
              ),
              onTap: () {

              },
            ),
          ],
        ),
        
      ),
      body: body,
    );
  }
}
