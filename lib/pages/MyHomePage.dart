import 'package:flutter/material.dart';
import 'dart:async';

import 'WordPage.dart';
import 'FavoritesPage.dart';
import 'HistoryPage.dart';
import 'SearchPage.dart';
import 'FeedbackPage.dart';
import 'HelpPage.dart';

import '../classes/Word.dart';
import '../globals/WordManager.dart';
import '../globals/DataAccess.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static WordManager wm = new WordManager();
  static DataAccess dao = new DataAccess();
  static String title = "Dagens Ord";
  static bool search = false;
  static Future<List<Word>> results;
  static List<String> filters = [];

  Widget body = new FutureBuilder<List<Word>>(
    future: wm.initWOTD(),
    builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none: return new Text('Press button to start');
        case ConnectionState.waiting: return new Text('Awaiting result...');
        default:
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          else if (snapshot.data.length > 0) {
            return new WordPage.base(snapshot.data[0]);
          } 
          else {
            return new WordPage.base(wm.wordList[0]);
          }
      }
    }
  );

  @override
  Widget build(BuildContext context) {    
    MaterialColor selectedColor = Colors.deepPurple;

    return new Scaffold(
      appBar: new AppBar(
        title: (!search 
        ? new Text(title)
        : new TextField(
          autofocus: true,
          onSubmitted: (String input) {
            results = dao.searchWords(input); 
            setState(() {
              body = new SearchPage(results: results);
              search = false;
            });
          },
        )),
        actions: (body is SearchPage
          ? <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              tooltip: "Søk",
              onPressed: () {
                setState(() {
                  search = true;
                });
              },
            ),
            new Builder(
              builder: (BuildContext context) {
                return new IconButton(
                  icon: new Icon(Icons.filter_list),
                  tooltip: "Filter",
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                    search = false;
                  },
                );
              },
            ),
            
          ]
        : null),
      ),
      endDrawer: (body is SearchPage
        ? new Drawer(
          child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              new DrawerHeader(
                child: new Text("Filtre"),
                decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
              ),
            ],
          ),
        )
        : null),
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
                  search = false;
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
                setState(() {
                  title = "Historie";
                  search = false;
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
                  search = false;
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
                  search = false;
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
                color: (body is FeedbackPage ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Send tilbakemelding",
                style: new TextStyle(
                  color: (body is FeedbackPage ? selectedColor : Colors.black)
                ), 
              ),
              onTap: () {
                setState(() {
                  title = "Tilbakemelding";
                  search = false;
                  body = new FeedbackPage();
                  Navigator.pop(context);
                });
              },
            ),
            new ListTile(
              leading: new Icon(
                Icons.help,
                color: (body is HelpPage ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Hjelp",
                style: new TextStyle(
                  color: (body is HelpPage ? selectedColor : Colors.black)
                ),
              ),
              onTap: () {
                setState(() {
                  title = "Hjelp";
                  search = false;
                  body = new HelpPage();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
        
      ),
      body: body,
    );
  }
}
