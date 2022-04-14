import 'LocationSuggestions.dart';

class SuggestionMatch {
  const SuggestionMatch(
      {this.title,
      this.searchMatch,
      this.state,
      this.continent,
      this.fileName,
      this.type,
      this.index,
      this.input});
  final String title;
  final String searchMatch;
  final String state;
  final String continent;
  final String fileName;
  final String type;
  final int index;
  final String input;

  String toStringDeep() {
    return input;
  }

  String toString() {
    return input;
  }

  static SuggestionMatch parseString(String input, int index) {
    var inputArray = input.split(LocationSuggestions.separator);
    var title = inputArray[0];
    var titleArray = inputArray[0].split(" - ");
    var state = titleArray.length > 1 ? titleArray[1] : null;
    var continent = titleArray.length > 2 ? titleArray[2] : null;
    return SuggestionMatch(
        title: title,
        searchMatch: titleArray[0],
        state: state,
        continent: continent,
        fileName: inputArray.length > 1 ? inputArray[1] : "",
        type: inputArray.length > 2 ? inputArray[2] : "",
        index: index,
        input: input);
  }
}
