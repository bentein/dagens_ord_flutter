class Word {
  Word({this.word, this.pronounciation, this.type, this.description, this.example, this.date});

  factory Word.json(dynamic json) {
    return new Word(word: json['word'], pronounciation: json['pronounciation'],
      type: json['type'], description: json['description'], example: json['example'], date: json['date']);
  }

  final String word;
  final String pronounciation;
  final String type;
  final String description;
  final String example;
  final String date;

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