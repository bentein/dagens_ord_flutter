import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import '../classes/Word.dart';

class LocalStorage {
  static final LocalStorage _instance = new LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  Future<File> writeWordList(List<Word> wordList) async {
    final file = await _wordList;
    String _json = json.encode(wordList);
    return file.writeAsString(_json);
  }

  Future<List<Word>> getWordList() async {
    try {
      final file = await _wordList;
      String contents = await file.readAsString();
      List<dynamic> _json = json.decode(contents);
      List<Word> wordList = <Word>[];

      for (int i = 0; i < _json.length; i++) {
        Word word = new Word.json(_json[i]);
        wordList.add(word);
      }
      /* if (_json != null && _json.length > 0) _json.forEach((word) {
        wordList.add(new Word.json(word));
      }); */

      return wordList;
    } catch (e) {
      return <Word>[];
    }
  }

  Future<File> writeFavorites(List<Word> favorites) async {
    final file = await _favorites;
    String _json = json.encode(favorites);
    return file.writeAsString(_json);
  }

  Future<List<Word>> getFavorites() async {
    try {
      final file = await _favorites;
      String contents = await file.readAsString();
      List _json = json.decode(contents);
      List<Word> favorites = <Word>[];

      _json.forEach((word) {
        favorites.add(new Word.json(word));
      });

      return favorites;
    } catch (e) {
      return <Word>[];
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _wordList async {
    final path = await _localPath;
    return new File('$path/wordlist.txt');
  }

  Future<File> get _favorites async {
    final path = await _localPath;
    return new File('$path/favorites.txt');
  }
}