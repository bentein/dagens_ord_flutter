class Word {
  Word({this.word, this.pronounciation, this.type, this.description, this.example, this.date, this.categories});

  factory Word.json(dynamic json) {
    List<String> cat = <String>[];
    if (json['categories'] != null) {
      List<dynamic> list = json['categories'];
      print(list);
      for (int i = 0; i < list.length; i++) {
        cat.add(list[i] + "");
      }
    }

    return new Word(word: json['word'], pronounciation: json['pronounciation'], type: json['type'], 
      description: json['description'], example: json['example'], date: json['date'], categories: cat);
  }

  final String word;
  final String pronounciation;
  final String type;
  final String description;
  final String example;
  final String date;
  final List<String> categories;

  Map toJson() {
    return {
      "word" : word,
      "pronounciation" : pronounciation,
      "type" : type,
      "description" : description,
      "example" : example,
      "date" : date,
      "categories" : categories,
    };
  }

  bool isValid() {
    bool isValid = true;

    if (isValid && word == "") isValid = false;
    if (isValid && pronounciation == "") isValid = false;
    if (isValid && type == "") isValid = false;
    if (isValid && description == "") isValid = false;
    if (isValid && example == "") isValid = false;
    if (isValid && date == "") isValid = false;

    return isValid;
  }

  static int getDaysSince(Word word) {
    DateTime now = new DateTime.now();

    int year = int.parse(word.date.substring(0,4));
    int month = int.parse(word.date.substring(5,7));
    int day = int.parse(word.date.substring(8,10));

    DateTime then = new DateTime(year, month, day);

    return now.difference(then).inDays;
  }

  static String getPastDate(int daysInPast) {
    DateTime dt = new DateTime.now().subtract(new Duration(days: daysInPast));
    return getDate(dt);
  }

  static String getCurrentDate() {
    DateTime dt = new DateTime.now();
    return getDate(dt);
  }

  static String getDate(DateTime dt) {
    String date = "";

    date += dt.year.toString() + "-";
    date += (dt.month.toString().length > 1 ? dt.month.toString() : "0" + dt.month.toString()) + "-";
    date += (dt.day.toString().length > 1 ? dt.day.toString() : "0" + dt.day.toString());

    return date;
  }
}