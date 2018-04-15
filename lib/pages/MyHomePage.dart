import 'package:flutter/material.dart';

import 'WordPage.dart';
import 'FavoritesPage.dart';
import 'HistoryPage.dart';
import 'SearchPage.dart';

import '../classes/Word.dart';
import '../globals/WordManager.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static WordManager wm = new WordManager();
  static String title = "";


  Widget body = new FutureBuilder<List<Word>>(
    future: wm.initWOTD(),
    builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none: return new Text('Press button to start');
        case ConnectionState.waiting: return new Text('Awaiting result...');
        default:
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          else if (snapshot.data.length > 0) return new WordPage.base(snapshot.data[0]);
          else {
            title = "Dagens Ord";
            return new WordPage.base(wm.wordList[0]);
          }
      }
    }
  );

  @override
  Widget build(BuildContext context) {
    
    MaterialColor selectedColor = Colors.purple;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
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
              leading: new Icon(
                Icons.bookmark_border,
                color: (body is WordPage ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Dagens Ord",
                style: new TextStyle(
                  color: (body is WordPage ? selectedColor : Colors.black)
                ), 
              ),
              onTap: () {
                setState(() {
                  title = "Dagens Ord";
                  body = new WordPage.base(wm.wotd);
                  Navigator.pop(context);                  
                });
              },
            ),
            new ListTile(
              leading: new Icon(
                Icons.history,
                color: (body is HistoryPage ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Historie",
                style: new TextStyle(
                  color: (body is HistoryPage ? selectedColor : Colors.black)
                ), 
              ),
              onTap: () {
                  title = "Historie";
                setState(() {
                  body = new HistoryPage();
                  Navigator.pop(context);           
                });
              },
            ),
            new ListTile(
              leading: new Icon(
                Icons.favorite_border,
                color: (body is FavoritesPage ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Favoritter",
                style: new TextStyle(
                  color: (body is FavoritesPage ? selectedColor : Colors.black)
                ),
              ),
              onTap: () {
                setState(() {
                  title = "Favoritter";
                  body = new FavoritesPage();
                  Navigator.pop(context);                  
                });
              },
            ),
            new ListTile(
              leading: new Icon(
                Icons.search,
                color: (body is SearchPage ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Søk",
                style: new TextStyle(
                  color: (body is SearchPage ? selectedColor : Colors.black)
                ),
              ),
              onTap: () {
                setState(() {
                  title = "Søk";
                  body = new SearchPage();
                  Navigator.pop(context);
                });
              },
            ),
            new Divider(),
            new ListTile(
              leading: new Icon(
                Icons.settings,
                color: (body is Word ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Instillinger",
                style: new TextStyle(
                  color: (body is Word ? selectedColor : Colors.black)
                ),
              ),
              onTap: () {

              },
            ),
            new ListTile(
              leading: new Icon(
                Icons.feedback,
                color: (body is Word ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Send tilbakemelding",
                style: new TextStyle(
                  color: (body is Word ? selectedColor : Colors.black)
                ), 
              ),
              onTap: () {

              },
            ),
            new ListTile(
              leading: new Icon(
                Icons.help,
                color: (body is Word ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Hjelp",
                style: new TextStyle(
                  color: (body is Word ? selectedColor : Colors.black)
                ),
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
