import 'package:flutter/material.dart';

import 'WordPage.dart';
import 'FavoritesPage.dart';

import '../classes/Word.dart';
import '../globals/WordManager.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  WordManager wm = new WordManager();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final List<Tab> tabList = <Tab>[
      new Tab(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.bookmark),
            new Padding(
              padding: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new Text("Dagens Ord"),
            )
          ],
        )
      ),
      new Tab(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.list),
            new Padding(
              padding: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new Text("Favoritter"),
            ),
          ],
        )
      )
    ];


    TabController _tabController = new TabController(
      length: tabList.length,
      vsync: this
    );
    
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        bottom: new TabBar(
          controller: _tabController,
          tabs: tabList
        )
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new WordPage(
            word: wm.wordList[0]
          ),
          new FavoritesPage(),
        ]
      ),
    );
  }
}
