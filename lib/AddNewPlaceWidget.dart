import 'package:flutter/material.dart';

import 'AddPlaceTagSearchDelegate.dart';
import 'Dialogs.dart';
import 'Tag.dart';
import 'Toaster.dart';
import 'UrlLauncher.dart';

const OPACITY_ITEM_VALIDATED = 0.5;
const OPACITY_ITEM_DEACTIVATED = 0.0;
const DEFAULT_DURATION_SCROLL_ANIMATION = Duration(milliseconds: 3000);
const DEFAULT_ANIMATION_CURVE = Curves.decelerate;
const DEFAULT_DURATION_OPACITY_FADE = Duration(milliseconds: 5000);
const DURATION_OPACITY_FADE_SUBMIT_BTN = Duration(milliseconds: 10000);
const INPUT_DASH_POS = 550.0;
const INPUT_TAGS_POS = 200.0;

const int MIN_INPUT_ADR = 20;
const int MIN_INPUT_NAME = 5;
const int MIN_INPUT_TAGS = 4;
const int MIN_INPUT_BCHyDASH = 32;
const int MAX_INPUT_ADR = 50;
const int MAX_INPUT_NAME = 50;
const int MAX_INPUT_DASH = 36; //dash:XintDskT8uV59N9HNvbpJ27nKNtbyHiyUn
const int MAX_INPUT_BCH =
    54; //bitcoincash:qpm2qsznhks23z7629mms6s4cwef74vcwvy22gdx6a
const int MAX_INPUT_TAGS = 4;

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
  FocusNode focusNodeInputDASH;

  String inputName;
  String inputAdr;
  String inputBCH = "";
  String inputDASH = "";
  bool showSubmitBtn = false;
  bool showInputDASHyBCH = false;
  bool showInputAdr = false;
  bool showInputTags = false;

  Set<String> allSelectedTags = Set.from([]);

  var scrollController = ScrollController();

  _AddNewPlaceWidgetState(
      this.selectedType, this.accentColor, this.typeTitle, this.actionBarColor);

  @override
  void initState() {
    super.initState();
    focusNodeInputDASH = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    focusNodeInputDASH.dispose();

    super.dispose();
  }

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
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      wrapBuildColumnName(),
                      wrapBuildColumnAdr(),
                      wrapBuildColumnTag(ctx),
                      wrapBuildSelectedTagsList(),
                      wrapBuildColumnDASHyBCH(),
                    ],
                  ),
                ),
              )),
    );
  }

  Widget wrapBuildColumnName() => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: showInputAdr ? OPACITY_ITEM_VALIDATED : 1.0,
      child: buildColumnName());

  Widget wrapBuildColumnTag(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: !showInputTags
          ? OPACITY_ITEM_DEACTIVATED
          : hasInputAllTags() ? OPACITY_ITEM_VALIDATED : 1.0,
      child: buildColumnTag(ctx));

  Widget wrapBuildColumnAdr() => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: !showInputAdr
          ? OPACITY_ITEM_DEACTIVATED
          : showInputTags ? OPACITY_ITEM_VALIDATED : 1.0,
      child: buildColumnAdr());

  bool hasInputAllTags() => allSelectedTags.length == 4;

  Widget wrapBuildColumnDASHyBCH() => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: !showInputDASHyBCH ? OPACITY_ITEM_DEACTIVATED : 1.0,
      child: buildColumnDASHyBCH());

  Widget wrapBuildSubmitBtn() => AnimatedOpacity(
        curve: DEFAULT_ANIMATION_CURVE,
        duration: DURATION_OPACITY_FADE_SUBMIT_BTN,
        opacity: showSubmitBtn
            ? allSelectedTags.length == MIN_INPUT_TAGS ? 1.0 : 0.5
            : 0.0,
        child: buildSubmitBtn(),
      );

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
        buildTextField(
            null, 0.1, Icons.title, MAX_INPUT_NAME, "name", updateInputName),
      ],
    );
  }

  Column buildColumnTag(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildSizedBoxSeparator(multiplier: 3.0),
        Text(
          "OK, now choose four words that best describe your products/service.",
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          "Hit the button, scroll the list, choose a tag",
          style: textStyleHint(),
        ),
        buildSizedBoxSeparator(),
        buildSearchTagButton(ctx),
      ],
    );
  }

  //TODO translate all tags to spanish, japanese, french and german
  //TODO email service in atleast 3 languages, English, Spanish, German

  Widget wrapBuildSelectedTagsList() {
    return allSelectedTags.length > 0
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AnimatedOpacity(
              curve: DEFAULT_ANIMATION_CURVE,
              duration: DEFAULT_DURATION_OPACITY_FADE,
              opacity: hasInputAllTags() ? OPACITY_ITEM_VALIDATED : 1.0,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAnimatedOpacityTag(0),
                    buildAnimatedOpacityTag(1),
                    buildAnimatedOpacityTag(2),
                    buildAnimatedOpacityTag(3),
                  ],
                ),
              ),
            ),
          )
        : buildEmptyPaddingAsPlaceholder();
  }

  AnimatedOpacity buildAnimatedOpacityTag(index) {
    return AnimatedOpacity(
        curve: DEFAULT_ANIMATION_CURVE,
        duration: DEFAULT_DURATION_OPACITY_FADE,
        opacity: hasTagWithThatIndexThenShowIt(index),
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(allSelectedTags.length <= index
              ? ""
              : allSelectedTags.elementAt(index) + "  "),
        ));
  }

  double hasTagWithThatIndexThenShowIt(index) =>
      allSelectedTags.length > index ? 1.0 : 0.0;

  List<Widget> buildTagsRow() {
    return allSelectedTags.map<Widget>((String tag) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(tag + "  "),
      );
    }).toList();
  }

  Widget buildSubmitBtn() {
    return FloatingActionButton.extended(
        onPressed: () async {
          if (!showSubmitBtn) return;

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
          if (!hasMinInput(inputBCH) && !hasMinInput(inputDASH)) {
            Toaster.showAddAtleastOneReceivingAddress();
            return;
          }

          UrlLauncher.launchEmailClientAddPlace(
              inputDASH, inputBCH, buildJsonToSubmitViaEmail(), () {
            Toaster.showToastEmailNotConfigured();
          });
          Dialogs.confirmDownloadPdf(context, () {
            UrlLauncher.launchQrCodeGeneratorUrl(
                dash: hasMinInput(inputDASH) ? inputDASH : "",
                bch: hasMinInput(inputBCH) ? inputBCH : "");
          });
        },
        icon: Icon(Icons.send),
        label: Text(" SEND"));
  }

  bool hasMinInput(input) => input.length > MIN_INPUT_BCHyDASH;

  Column buildColumnDASHyBCH() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildSizedBoxSeparator(multiplier: 3.0),
        Text(
          "What is your DASH wallet receiving address?",
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          "1: Open your DASH wallet! 2: Choose receive to see the QR-Code! 3: Select share/copy! 4: Paste the address here!",
          style: textStyleHint(),
        ),
        buildTextField(
            focusNodeInputDASH,
            INPUT_DASH_POS,
            Icons.monetization_on,
            MAX_INPUT_DASH,
            "DASH address",
            updateInputDASH),
        buildSizedBoxSeparator(multiplier: 2.0),
        Text(
          "What is your BCH wallet receiving address?",
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          "1: Open your BCH wallet! 2: Choose receive to see the QR-Code! 3: Select share/copy! 4: Paste the address here!",
          style: textStyleHint(),
        ),
        buildTextField(null, 700.0, Icons.monetization_on, MAX_INPUT_BCH,
            "BCH address", updateInputBCH),
        buildSizedBoxSeparator(multiplier: 5.0),
      ],
    );
  }

  Column buildColumnAdr() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildSizedBoxSeparator(multiplier: 3.0),
        Text(
          "What is the postal address?",
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          "Street + Number, State, Country",
          style: textStyleHint(),
        ),
        buildTextField(null, 150.0, Icons.local_post_office, MAX_INPUT_ADR,
            "address", updateInputAdr),
      ],
    );
  }

  SizedBox buildSizedBoxSeparator({multiplier = 1.0}) =>
      SizedBox(height: 10.0 * multiplier);

  void handleAddTagButton(ctx) async {
    if (allSelectedTags.length >= MIN_INPUT_TAGS) {
      Dialogs.confirmShowResetTags(ctx, () {
        setState(() {
          allSelectedTags = Set.from([]);
          searchTagsDelegate.alreadySelected = Set.from([]);
          showInputDASHyBCH = false;
          showSubmitBtn = false;
        });
      });
      return;
    }

    final String selected = await showSearch<String>(
      context: ctx,
      delegate: searchTagsDelegate,
    );

    if (selected == null || selected.isEmpty) return;

    addSelectedTag(selected);

    if (allSelectedTags.length == MAX_INPUT_TAGS) {
      setState(() {
        showInputDASHyBCH = true;
      });
      FocusScope.of(ctx).requestFocus(focusNodeInputDASH);
      scrollController.jumpTo(INPUT_DASH_POS);
    } else {
      scrollController.jumpTo(INPUT_TAGS_POS);
    }

    setState(() {
      showSubmitBtn = true;
    });
  }

  void scrollToWithAnimation(pos) {
    if (scrollController.positions.isNotEmpty) {
      scrollController.animateTo(pos,
          duration: DEFAULT_DURATION_SCROLL_ANIMATION,
          curve: DEFAULT_ANIMATION_CURVE);
    }
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

  TextField buildTextField(focusNode, onTapScrollToThisPosition, icon,
      maxLength, String label, updateInputCallback) {
    return TextField(
      focusNode: focusNode,
      //onSubmitted: updateInputCallback("c0mpl3te"),
      onTap: () {
        scrollToWithAnimation(onTapScrollToThisPosition);
      },
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

  //TODO listen to the duration of not receiving input and show the next field after 5 seconds of inactivity

  void showInputTag() {
    scrollToWithAnimation(INPUT_TAGS_POS);
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
    if (input == "c0mpl3te") {
      scrollToWithAnimation(150.0);
      return;
    }

    //TODO FIX THAT LOCATION IS AVAILABLE AT THE BEGINNING BY USNG SHARED PREFS TO save LOCATION!!

    if (input.length > MIN_INPUT_NAME) {
      showInputAddress();
    }

    this.inputName = input;
  }

  void addSelectedTag(String selected) {
    setState(() {
      allSelectedTags.add(selected);
    });
    searchTagsDelegate.alreadySelected.add(Tag.getTagIndex(selected));
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
        Tag.getTagIndex(tag).toString() +
        '"}';
  }
}
