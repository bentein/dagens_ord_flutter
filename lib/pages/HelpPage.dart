import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new Padding(
      padding: new EdgeInsets.fromLTRB(25.0,20.0,25.0,3.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "Om Dagens Ord",
            style: Theme.of(context).textTheme.headline
          ),
          new Text(
            "En applikasjon av Asgeir Lehmann og Bentein Thomassen",
            style: Theme.of(context).textTheme.caption
          ),
          new Padding(padding:EdgeInsets.only(top: 10.0)),
          new Text(
            "Denne applikasjonen ble designet og utviklet av Asgeir Lehmann av Bentein Thomassen. Applikasjonen er open source, tilgjengelig på både iOS og Android, og er utviklet i Googles flutter-rammeverk for hybridutvikling.",
            style: Theme.of(context).textTheme.body1
          ),
          new Padding(padding:EdgeInsets.only(top: 30.0)),
          new Text(
            "Hvordan søke etter ord",
            style: Theme.of(context).textTheme.subhead
          ),
          new Padding(padding:EdgeInsets.only(top: 10.0)),
          new Text(
            "Du kan søke i ordarkivet ved å navigere til søkesiden, og deretter trykke på søkeikonet på action baren. Tast inn det du vil søke etter, og du vil motta samtlige matchende oppføringer. Trykk på filterknappen for å bestemme hvilke ordkategorier som du vil se. Huk av på kategoriene du ønsker å vise. Hvis alle kategoriene er umarkert vil ingen ord filtreres vekk.",
            style: Theme.of(context).textTheme.body1
          ),
          new Padding(padding:EdgeInsets.only(top: 30.0)),
          new Text(
            "Kildekoden til applikasjonen",
            style: Theme.of(context).textTheme.subhead
          ),
          new Padding(padding:EdgeInsets.only(top: 10.0)),
          new Text(
            "Koden for denne applikasjonen finner du på GitHub, under navnet bentein/dagens_ord_flutter. Ta gjerne kontakt om du lurer på noe angående koden eller utvikling i flutter. Backenden ligger på AWS, og er ikke offentlig tilgjengelig. Ta kontakt om du ønsker innsikt i denne koden.",
            style: Theme.of(context).textTheme.body1
          ),
        ],
      )
    );
  }
}