class Word {
  Word({this.word, this.pronounciation, this.type, this.description, this.example});

  final String word;
  final String pronounciation;
  final String type;
  final String description;
  final String example;

  final DateTime date = new DateTime.now();

  bool isValid() {
    bool isValid = true;

    if (isValid && word == "") isValid = false;
    if (isValid && pronounciation == "") isValid = false;
    if (isValid && type == "") isValid = false;
    if (isValid && description == "") isValid = false;
    if (isValid && example == "") isValid = false;
    if (isValid && date.toString() == "") isValid = false;

    return isValid;
  }
}