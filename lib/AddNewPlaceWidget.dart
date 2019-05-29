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
  bool showInputDASHyBCH = false;
  bool showInputAdr = false;
  bool showInputTags = false;

  Set<String> allSelectedTags = Set.from([]);

  String inputBCH = "";
  String inputDASH = "";

  static const int MIN_INPUT_ADR = 20;
  static const int MIN_INPUT_NAME = 5;
  static const int MIN_INPUT_TAGS = 4;
  static const int MIN_INPUT_BCHyDASH = 32;
  static const int MAX_INPUT_ADR = 50;
  static const int MAX_INPUT_NAME = 50;
  static const int MAX_INPUT_DASH =
      36; //dash:XintDskT8uV59N9HNvbpJ27nKNtbyHiyUn
  static const int MAX_INPUT_BCH =
      54; //bitcoincash:qpm2qsznhks23z7629mms6s4cwef74vcwvy22gdx6a
  static const int MAX_INPUT_TAGS = 4;

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
                      wrapBuildSelectedTagsList(),
                      wrapBuildColumnDASHyBCH()
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

  Widget wrapBuildColumnDASHyBCH() => (showInputDASHyBCH
      ? buildColumnDASHyBCH()
      : buildEmptyPaddingAsPlaceholder());

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
        buildSizedBoxSeparator(),
        Text(
          "Use the same name as in Google Maps",
          style: textStyleHint(),
        ),
        buildTextField(Icons.title, MAX_INPUT_NAME, "name", updateInputName),
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
        buildSizedBoxSeparator(),
        Text(
          "Hit the button, scroll the list, select a tag",
          style: textStyleHint(),
        ),
        buildSizedBoxSeparator(),
        buildSearchTagButton(ctx),
        buildSizedBoxSeparator()
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
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(counter.toString() + " - " + tag + "  "),
      );
    }).toList();
  }

  Widget buildSubmitBtn() {
    return FloatingActionButton.extended(
        onPressed: () async {
          if (inputName.length < MIN_INPUT_NAME) {
            Toaster.showAddName();
            return;
          }
          if (inputAdr.length < MIN_INPUT_ADR) {
            Toaster.showAddFullAdr();
            return;
          }
          if (allSelectedTags.length < MIN_INPUT_TAGS) {
            Toaster.showAddExactlyFourTags();
            return;
          }
          if (inputBCH.length < MIN_INPUT_BCHyDASH &&
              inputDASH.length < MIN_INPUT_BCHyDASH) {
            Toaster.showAddAtleastOneReceivingAddress();
            return;
          }

          await UrlLauncher.launchEmailClientAddPlace(
              inputDASH.length > MIN_INPUT_BCHyDASH,
              inputBCH.length > MIN_INPUT_BCHyDASH,
              buildJsonToSubmitViaEmail(), () {
            Toaster.showToastEmailNotConfigured();
          });
          Toaster.showToastThanksForSubmitting();
        }, -
        icon: Icon(Icons.send),
        label: Text(" SEND"));
  }

  Column buildColumnDASHyBCH() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "What is your DASH wallet receiving address?",
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          "Open your DASH wallet, go to the receive view and use the share function (top right)",
          style: textStyleHint(),
        ),
        buildTextField(Icons.monetization_on, MAX_INPUT_DASH, "DASH address",
            updateInputDASH),
        Text(
          "What is your BCH wallet receiving address?",
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          "Open your BCH wallet, go to the receive view and use the share/copy function (top right)",
          style: textStyleHint(),
        ),
        buildTextField(Icons.monetization_on, MAX_INPUT_BCH, "BCH address",
            updateInputBCH),
      ],
    );
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
        buildSizedBoxSeparator(),
        Text(
          "Street + Number, State, Country",
          style: textStyleHint(),
        ),
        buildTextField(
            Icons.local_post_office, MAX_INPUT_ADR, "address", updateInputAdr),
      ],
    );
  }

  SizedBox buildSizedBoxSeparator() => SizedBox(height: 10.0);

  void handleAddTagButton(ctx) async {
    if (allSelectedTags.length >= MIN_INPUT_TAGS) {
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

    if (allSelectedTags.length == MAX_INPUT_TAGS) showInputDASHyBCH = true;

    setState(() {
      showSubmitBtn = true;
    });
  }

  RaisedButton buildSearchTagButton(ctx) {
    return RaisedButton(
      onPressed: () {
        handleAddTagButton(ctx);
      },
      textColor: TEXT_COLOR,
      color: actionBarColor,
      shape: StadiumBorder(
          side: BorderSide(
              color: TEXT_COLOR, style: BorderStyle.solid, width: 1.0)),
      splashColor: accentColor,
      child: Padding(
        padding: buildEdgeInsetsTextField(),
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
          contentPadding: buildEdgeInsetsTextField(),
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

  EdgeInsets buildEdgeInsetsTextField() => EdgeInsets.all(10.0);

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

  void updateInputBCH(String input) {
    this.inputBCH = input;
  }

  void updateInputDASH(String input) {
    this.inputDASH = input;
  }

  void updateInputAdr(String input) {
    if (input.length > MIN_INPUT_ADR) {
      showInputTag();
    }

    this.inputAdr = input;
  }

  void updateInputName(String input) {
    if (input.length > MIN_INPUT_NAME) {
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
        '","bch":"' +
        inputBCH +
        '","dash":"' +
        inputDASH +
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
