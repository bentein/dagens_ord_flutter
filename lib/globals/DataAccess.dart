import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../classes/Word.dart';

class DataAccess {
  static final DataAccess _instance = new DataAccess._internal();

  factory DataAccess() {
    return _instance;
  }

  DataAccess._internal();

  Future<List<Word>> getWords(String startdate, String enddate) async {
    List<Word> wordList = [];

    String url = "https://a71n4w0dwf.execute-api.eu-west-1.amazonaws.com/testing";
    url += "?startdate=$startdate&enddate=$enddate";

    var items = (await http.get(url)).body;
    List _words = json.decode(items)['Items'];
    _words.forEach((word) {
      if (word['categories'] != null && word['categories'].length > 0) word['categories'] = word['categories']['values'];
      wordList.add(new Word.json(word));
    });

    return wordList;
  }

  Future<List<Word>> searchWords(String query) async {
    List<Word> wordList = [];

    String url = "https://a71n4w0dwf.execute-api.eu-west-1.amazonaws.com/testing/search";
    url += "?query=$query";

    var items = (await http.get(url)).body;
    List _words = json.decode(items)['Items'];
    _words.forEach((word) {
      if (word['categories'] != null && word['categories'].length > 0) word['categories'] = word['categories']['values'];
      wordList.add(new Word.json(word));
    });

    return wordList;
  }
}