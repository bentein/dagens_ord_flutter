import '../classes/Word.dart';

import 'DataAccess.dart';

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
    initWOTD();
  }

  DataAccess dao = new DataAccess();

  void initWordList() {
    wordList = <Word>[
      new Word(
        word: 'test word',
        pronounciation: 'how to pronounce the word',
        type: 'type of the word',
        description: 'description of the word',
        example: 'example of the word in use',
        date: Word.getCurrentDate(),
      ),
    ];
  }

  void initFavorites() {
    favorites = <Word>[];
  }

  void initWOTD() async {
    wotd = (await dao.getWords(Word.getCurrentDate(), Word.getCurrentDate()))[0];
  }

  bool addWord(Word word) {
    bool added = false;
    if (word.isValid()) {
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
    return removed;
  }

  bool isFavorite(Word word) {
    bool isFavorite = false;
    for (var _word in favorites) {
      if (_word.word == word.word && _word.date == word.date) isFavorite = true;
    } 
    return isFavorite;
  }
  
}