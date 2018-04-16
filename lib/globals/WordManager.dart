import 'dart:async';

import '../classes/Word.dart';

import 'DataAccess.dart';
import 'LocalStorage.dart';

class WordManager {
  static final WordManager _instance = new WordManager._internal();

  factory WordManager() {
    return _instance;
  }

  Word wotd;
  List<Word> wordList;
  List<Word> favorites;

  WordManager._internal() {
    initWordList();
    initFavorites();
  }

  DataAccess dao = new DataAccess();
  LocalStorage lst = new LocalStorage();

  void initWordList() async {
    wordList = (await lst.getWordList());
    wordList = (await dao.getWords(Word.getPastDate(10), Word.getCurrentDate()));
    lst.writeWordList(wordList);
    wordList.sort((a,b) => b.date.compareTo(a.date));
  }

  void initFavorites() async {
    favorites = (await lst.getFavorites());
    if (favorites.length == 0) {
      favorites = <Word>[];
    }
  }

  Future<List<Word>> initWOTD() {
    Future<List<Word>> future = dao.getWords(Word.getCurrentDate(), Word.getCurrentDate());
    future.then((wordList){ 
      wotd = wordList[0];
      addWord(wotd);
    });
    return future;
  }

  void addWordList(List<Word> _wordList) {
    _wordList.forEach((word) {
      addWord(word);
    });
    wordList.sort((a,b) => b.date.compareTo(a.date));
    lst.writeWordList(wordList);
  }

  bool addWord(Word word) {
    bool added = false;
    if (word.isValid() && !isInWordList(word)) {
      wordList.add(word);
      added = true;
    }
    return added;
  }

  bool addFavorite(Word word) {
    bool added = false;
    if (word.isValid() && !isFavorite(word)) {
      favorites.add(word);
      added = true;
    }
    favorites.sort((a,b) => b.date.compareTo(a.date));
    lst.writeFavorites(favorites);
    return added;
  }

  bool removeFavorite(Word word) {
    bool removed = false;
    for (var _word in favorites) {
      if (_word.word == word.word && _word.date == word.date) {
        removed = true;
        word = _word;
      }
    } 
    if (removed) removed = favorites.remove(word);
    lst.writeFavorites(favorites);
    return removed;
  }

  bool isInWordList(Word word) {
    bool isInList = false;
    for (var _word in wordList) {
      if (_word.word == word.word && _word.date == word.date) isInList = true;
    } 
    return isInList;
  }

  bool isFavorite(Word word) {
    bool isFavorite = false;
    for (var _word in favorites) {
      if (_word.word == word.word && _word.date == word.date) isFavorite = true;
    } 
    return isFavorite;
  }
  
}