import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new Column(
      children: <Widget>[
        new ListBody(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0),
              child: new Text(
                "Kontakt oss",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.mail),
              title: new Text("Send mail"),
              onTap: () {
              
              },
            ),
            new Divider(),
          ],
        )
      ],
    );
  }
}