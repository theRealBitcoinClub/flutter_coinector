import 'package:flutter/material.dart';

import 'AddPlaceTagSearchDelegate.dart';
import 'Dialogs.dart';
import 'Tag.dart';
import 'Toaster.dart';
import 'UrlLauncher.dart';

class AddNewPlaceWidget extends StatefulWidget {
  final int selectedType;
  final Color accentColor;
  final Color actionBarColor;
  final String typeTitle;

  const AddNewPlaceWidget(
      {Key key,
      this.selectedType,
      this.accentColor,
      this.typeTitle,
      this.actionBarColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddNewPlaceWidgetState(
        selectedType, accentColor, typeTitle, actionBarColor);
  }
}

class _AddNewPlaceWidgetState extends State<AddNewPlaceWidget> {
  final int selectedType;
  final Color accentColor;
  final String typeTitle;
  final Color actionBarColor;
  final AddPlaceTagSearchDelegate searchTagsDelegate =
      AddPlaceTagSearchDelegate();
  static const TEXT_COLOR = Colors.white;

  String inputName;
  String inputAdr;
  bool showSubmitBtn = false;
  bool showInputAdr = false;
  bool showInputTags = false;

  Set<String> allSelectedTags = Set.from([]);

  _AddNewPlaceWidgetState(
      this.selectedType, this.accentColor, this.typeTitle, this.actionBarColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: wrapBuildSubmitBtn(),
      appBar: AppBar(
        backgroundColor: actionBarColor,
        title: Text("ADD: " + typeTitle),
      ),
      body: Builder(
          builder: (ctx) => Padding(
                padding: EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      buildColumnName(),
                      wrapBuildColumnAdr(),
                      wrapBuildColumnTag(ctx),
                      wrapBuildSelectedTagsList()
                    ],
                  ),
                ),
              )),
    );
  }

  Widget wrapBuildColumnTag(ctx) =>
      (showInputTags ? buildColumnTag(ctx) : buildEmptyPaddingAsPlaceholder());

  Widget wrapBuildColumnAdr() =>
      (showInputAdr ? buildColumnAdr() : buildEmptyPaddingAsPlaceholder());

  Widget wrapBuildSubmitBtn() =>
      (showSubmitBtn ? buildSubmitBtn() : buildEmptyPaddingAsPlaceholder());

  Padding buildEmptyPaddingAsPlaceholder() {
    return Padding(
      padding: EdgeInsets.all(0.0),
    );
  }

  Column buildColumnName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "What is the name of that place?",
          style: textStyleLabel(),
        ),
        SizedBox(height: 10.0),
        Text(
          "Use the same name as in Google Maps",
          style: textStyleHint(),
        ),
        buildTextField(Icons.title, 50, "name", updateInputName),
      ],
    );
  }

  Column buildColumnTag(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "OK, now choose four words that best describe your products/service.",
          style: textStyleLabel(),
        ),
        SizedBox(height: 10.0),
        Text(
          "Hit the button, scroll the list, select a tag",
          style: textStyleHint(),
        ),
        SizedBox(height: 10.0),
        buildSearchTagButton(ctx),
        SizedBox(height: 10.0)
      ],
    );
  }

  Widget wrapBuildSelectedTagsList() {
    return allSelectedTags.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildTagsRow(),
          )
        : buildEmptyPaddingAsPlaceholder();
  }

  List<Widget> buildTagsRow() {
    var counter = 0;
    return allSelectedTags.map<Widget>((String tag) {
      counter++;
      return Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(counter.toString() + " - " + tag + "  "),
      );
    }).toList();
  }

  Widget buildSubmitBtn() {
    return FloatingActionButton.extended(
        onPressed: () {
          if (inputName.length < 5) {
            Toaster.showAddName();
            return;
          }
          if (inputAdr.length < 20) {
            Toaster.showAddFullAdr();
            return;
          }
          if (allSelectedTags.length < 4) {
            Toaster.showAddExactlyFourTags();
            return;
          }

          UrlLauncher.launchEmailClientAddPlace(buildJsonToSubmitViaEmail(),
              () {
            Toaster.showToastEmailNotConfigured();
          });
        },
        icon: Icon(Icons.send),
        label: Text(" SEND"));
  }

  Column buildColumnAdr() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "What is the postal address?",
          style: textStyleLabel(),
        ),
        SizedBox(height: 10.0),
        Text(
          "Street + Number, State, Country",
          style: textStyleHint(),
        ),
        buildTextField(Icons.local_post_office, 50, "address", updateInputAdr),
      ],
    );
  }

  RaisedButton buildSearchTagButton(ctx) {
    return RaisedButton(
      onPressed: () async {
        if (allSelectedTags.length >= 4) {
          Toaster.showToastMaxTagsReached();
          Dialogs.confirmShowResetTags(ctx, () {
            allSelectedTags = Set.from([]);
          });
          return;
        }

        final String selected = await showSearch<String>(
          context: ctx,
          delegate: searchTagsDelegate,
        );
        if (selected == null || selected.isEmpty) return;

        int sizeBefore = allSelectedTags.length;

        addSelectedTag(selected);
        if (sizeBefore == allSelectedTags.length)
          Toaster.showWarning(
              "You selected the same tag twice! Please choose again!");

        showSubmitBtn = true;

        if (allSelectedTags.length >= 4) {
          setState(() {
            showInputTags = false;
          });
        }
      },
      textColor: TEXT_COLOR,
      color: actionBarColor,
      shape: StadiumBorder(
          side: BorderSide(
              color: TEXT_COLOR, style: BorderStyle.solid, width: 1.0)),
      splashColor: accentColor,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.search),
            allSelectedTags.length == 0
                ? Text("   TOUCH HERE TO CHOOSE A TAG")
                : allSelectedTags.length == 1
                    ? Text("   CHOOSE ANOTHER TAG")
                    : allSelectedTags.length == 2
                        ? Text("   CHOOSE THIRD TAG")
                        : allSelectedTags.length == 3
                            ? Text("   CHOOSE LAST TAG")
                            : Text("   RESET TAGS")
          ],
        ),
      ),
    );
  }

  TextField buildTextField(icon, maxLength, String label, updateInputCallback) {
    return TextField(
      decoration: InputDecoration(
          icon: Icon(icon),
          contentPadding: EdgeInsets.all(10.0),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
          labelText: "Insert " + label + " here."),
      cursorColor: Colors.white70,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      maxLengthEnforced: true,
      maxLength: maxLength,
      maxLines: 1,
      onChanged: updateInputCallback,
      style: textStyleInput(),
    );
  }

  TextStyle textStyleInput() =>
      TextStyle(color: TEXT_COLOR, fontWeight: FontWeight.w300);

  TextStyle textStyleLabel() => TextStyle(
      color: TEXT_COLOR,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);
  TextStyle textStyleHint() => TextStyle(
      color: TEXT_COLOR.withOpacity(0.8),
      fontSize: 14.0,
      fontWeight: FontWeight.w300);

  void showInputAddress() {
    setState(() {
      showInputAdr = true;
    });
  }

  void showInputTag() {
    setState(() {
      showInputTags = true;
    });
  }

  void updateInputAdr(String input) {
    if (input.length > 20) {
      showInputTag();
    }

    this.inputAdr = input;
  }

  void updateInputName(String input) {
    if (input.length > 5) {
      showInputAddress();
    }

    this.inputName = input;
  }

  void addSelectedTag(String selected) {
    setState(() {
      allSelectedTags.add(selected);
    });
  }

  String buildJsonToSubmitViaEmail() {
    return Uri.encodeComponent('{"name":"' +
        inputName +
        '","type":"' +
        typeTitle +
        '","address":"' +
        inputAdr +
        '","tags":"[' +
        buildJsonTag(allSelectedTags.elementAt(0)) +
        ',' +
        buildJsonTag(allSelectedTags.elementAt(1)) +
        ',' +
        buildJsonTag(allSelectedTags.elementAt(2)) +
        ',' +
        buildJsonTag(allSelectedTags.elementAt(3)) +
        ']}');
  }

  String buildJsonTag(tag) {
    return '{"tag":"' +
        tag +
        '", "id":"' +
        Tag.findTagIndex(tag).toString() +
        '"}';
  }
}
