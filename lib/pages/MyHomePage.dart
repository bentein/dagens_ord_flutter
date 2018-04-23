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
import '../globals/AdsManager.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static WordManager wm = new WordManager();
  static DataAccess dao = new DataAccess();
  static AdsManager ads = new AdsManager();
  static String title = "Dagens Ord";
  static bool search = false;
  static Future<List<Word>> results;
  static List<String> filters = [];
  static bool test = true;

  Widget body = new WordPage.base(wm.wotd);
  
  /*new FutureBuilder<List<Word>>(
    future: wm.wotdFuture,
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
                  "Henter dagens ord",
                  style: Theme.of(context).textTheme.display1,
                )
              ],
            ),
          );
        
        default:
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          else if (snapshot.data.length == 0) {
            return new WordPage.base(null);
          } else if (snapshot.data.length > 0) {
            return new WordPage.base(snapshot.data[0]);
          } else {
            return new WordPage.base(wm.wordList[0]);
          }
      }
    }
  ); */

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
              body = new SearchPage(results: results, filters: filters);
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
              new CheckboxListTile(
                value: filters.contains("Substantiv"),
                dense: true,
                title: new Text("Substantiv"),
                onChanged: (bool b) {
                  if (b) { filters.add("Substantiv"); }
                  else { filters.remove("Substantiv"); }
                  setState(() {
                    body = new SearchPage(results: results, filters: filters);             
                  });
                },
              ),
              new CheckboxListTile(
                value: filters.contains("Adjektiv"),
                dense: true,
                title: new Text("Adjektiv"),
                onChanged: (bool b) {
                  if (b) { filters.add("Adjektiv"); }
                  else { filters.remove("Adjektiv"); }
                  setState(() {
                    body = new SearchPage(results: results, filters: filters);
                  });
                },
              ),
              new CheckboxListTile(
                value: filters.contains("Verb"),
                dense: true,
                title: new Text("Verb"),
                onChanged: (bool b) {
                  if (b) { filters.add("Verb"); }
                  else { filters.remove("Verb"); }
                  setState(() {
                    body = new SearchPage(results: results, filters: filters);
                  });
                },
              ),
              new Divider(),
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
                color: (body is WordPage || body is FutureBuilder<List<Word>> ? selectedColor : Colors.black),
              ),
              title: new Text(
                "Dagens Ord",
                style: new TextStyle(
                  color: (body is WordPage || body is FutureBuilder<List<Word>> ? selectedColor : Colors.black)
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
                  if (body is! HistoryPage) body = new HistoryPage();
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
                  if (body is! FavoritesPage) body = new FavoritesPage();
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
                  results = null;
                  if (body is! SearchPage) body = new SearchPage();
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
                  if (body is! FeedbackPage) body = new FeedbackPage();
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
                  if (body is! HelpPage) body = new HelpPage();
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
