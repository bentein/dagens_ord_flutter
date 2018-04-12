import '../classes/Word.dart';

class WordManager/*  extends Object with ChangeNotifier */ {
  static final WordManager _instance = new WordManager._internal();

  factory WordManager() {
    return _instance;
  }

  //@reflectable
  List<Word> wordList;

  WordManager._internal() {
    //this.changes.listen((List<ChangeRecord> record) => record.forEach(print));
    initWordList();
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

  void addWord(Word word) {
    if (word.isValid())wordList.add(word);
  }
  
}