import '../classes/Word.dart';

class WordManager {
  static final WordManager _instance = new WordManager._internal();

  factory WordManager() {
    return _instance;
  }

  List<Word> wordList;
  List<Word> favorites;

  WordManager._internal() {
    initWordList();
    initFavorites();
  }

  void initWordList() {
    wordList = <Word>[
      new Word(
        word: 'test word',
        pronounciation: 'how to pronounce the word',
        type: 'type of the word',
        description: 'description of the word',
        example: 'example of the word in use',
      ),
    ];
  }

  void initFavorites() {
    favorites = <Word>[];
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
    if (word.isValid() && !favorites.contains(word)) {
      favorites.add(word);
      added = true;
    }
    return added;
  }

  bool removeFavorite(Word word) {
    bool removed = false;
    if (favorites.remove(word)) removed = true;
    return removed;
  }

  bool isFavorite(Word word) {
    bool isFavorite = false;
    if (favorites.contains(word)) isFavorite = true;
    return isFavorite;
  }
  
}