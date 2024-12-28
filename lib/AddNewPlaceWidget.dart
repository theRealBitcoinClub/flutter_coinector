import 'dart:convert';
import 'dart:math';

import 'package:Coinector/GithubCoinector.dart';
import 'package:Coinector/GooglePlacesApiCoinector.dart';
import 'package:Coinector/Localizer.dart';
import 'package:Coinector/Merchant.dart';
import 'package:Coinector/TabPageCategory.dart';
import 'package:Coinector/TagCoinector.dart';
import 'package:Coinector/TagCoins.dart';
import 'package:Coinector/TagFactory.dart';
import 'package:Coinector/translator.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddPlaceTagSearchDelegate.dart';
import 'Dialogs.dart';
import 'ImportData.dart';
import 'ReviewPlaces.dart';
import 'TagBrands.dart';
import 'Toaster.dart';
import 'UrlLauncher.dart';

const OPACITY_ITEM_VALIDATED = 0.7;
const OPACITY_ITEM_DEACTIVATED = 0.0;
const DEFAULT_DURATION_SCROLL_ANIMATION = Duration(milliseconds: 2000);
const DEFAULT_ANIMATION_CURVE = Curves.decelerate;
const DEFAULT_DURATION_OPACITY_FADE = Duration(milliseconds: 3000);
const DURATION_OPACITY_FADE_SUBMIT_BTN = Duration(milliseconds: 5000);
const SCROLL_POS_IMAGES = 250.0;
const SCROLL_POS_TAGS = 200.0;
const SCROLL_POS_ADR = 130.0;
const SCROLL_POS_NAME = 0.0;
const KEYWORD_CONTROLLER_ACTION = "controller";
const int MAX_IMAGES_UPLOAD = 3;
const int MIN_INPUT_ADR = 5;
const int MIN_INPUT_NAME = 2;
const int MIN_INPUT_TAGS = 2;
const int MIN_INPUT_SELECT_IMAGES = 3;
const int MAX_INPUT_TAGS = 4;
const int MIN_INPUT_BCHyDASH =
    32; //TODO offer an address field for each coin right after checking its box, activates pay button for that place
const int MAX_INPUT_ADR = 250;
const int MAX_INPUT_NAME = 200;
const int MAX_INPUT_DASH = 36; //dash:XintDskT8uV59N9HNvbpJ27nKNtbyHiyUn
const int MAX_INPUT_BCH =
    54; //bitcoincash:qpm2qsznhks23z7629mms6s4cwef74vcwvy22gdx6a
const int IMAGE_HEIGHT = 336; //kReleaseMode ? 336 : 112;
const int IMAGE_WIDTH = 640; //kReleaseMode ? 640 : 213;

enum FormStep {
  IN_NAME,
  IN_ADR,
  HIT_SEARCH,
  HIT_GOOGLE,
  SELECT_TAGS,
  // SELECT_IMAGES,
  SELECT_BRAND,
  SELECT_COINS,
  SUBMIT
}

class AddNewPlaceWidget extends StatefulWidget {
  final String pId;
  final int selectedType;
  final Color accentColor;
  final Color actionBarColor;
  final String typeTitle;
  final Merchant merchantBmapDataset;
  final String lastReviewableIndex;
  final String lastReviewableCount;

  static const _kReviewablesCountAndCurrentIndex =
      "reviewablesCountAndCurrentIndex";

  static Future<String?> getLastReviewableCountAndIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kReviewablesCountAndCurrentIndex);
  }

  static setLastReviewableCountAndIndex(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kReviewablesCountAndCurrentIndex, value);
  }

  const AddNewPlaceWidget(
      {required Key key,
        required this.selectedType,
        required this.accentColor,
        required this.typeTitle,
        required this.actionBarColor,
        required this.pId,
        required this.merchantBmapDataset,
        required this.lastReviewableIndex,
        required this.lastReviewableCount})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddNewPlaceWidgetState(
        selectedType,
        accentColor,
        typeTitle,
        actionBarColor,
        pId,
        merchantBmapDataset,
        lastReviewableIndex,
        lastReviewableCount);
  }
}

class _AddNewPlaceWidgetState extends State<AddNewPlaceWidget> {
  late final int selectedType;
  late final Color accentColor;
  late final String typeTitle;
  late final Color actionBarColor;
  final AddPlaceTagSearchDelegate searchTagsDelegate =
      AddPlaceTagSearchDelegate();
  late final Merchant merchantBmapDataset;
  static const TEXT_COLOR = Colors.white;
  late FocusNode focusNodeInputDASH;
  late FocusNode focusNodeInputBCH;
  late FocusNode focusNodeInputAdr;
  late FocusNode focusNodeInputName;
  late TextEditingController controllerInputDASH;
  late TextEditingController controllerInputBCH;
  late TextEditingController controllerInputAdr;
  late TextEditingController controllerInputName;
  String inputName = "";
  String lastInputNameWithCommand = "";
  String lastInputName = "";
  String inputAdr = "";
  String lastInputAdrWithCommand = "";
  String lastInputAdr = "";
  String inputBCH = "";
  String lastInputBCH = "";
  String lastInputBCHWithCommand = "";
  String inputDASH = "";
  String lastInputDASH = "";
  String lastInputDASHWithCommand = "";
  bool showSubmitBtn = false;
  bool showInputDASHyBCH = false;
  bool showInputAdr = false;
  bool showInputTags = false;
  bool showSearchButton = false;
  late final String pId;
  late String placeId;
  List<Uint8List> images = [];
  List<Uint8List> selectedImages = [];
  var textStyleButtons = TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);
  Set<TagCoinector> allSelectedTags = {};
  var scrollController = ScrollController();
  bool hasTriedSearch = false;
  bool showRegisterOnGMapsButton = false;
  bool hasSelectedImages = false;
  bool cancelAllImageLoads = false;
  double _contiVisibility = 1.0;
  late Set<String> imagesSuccess;
  GithubCoinector githubCoinector = GithubCoinector();
  late Merchant _merchantGoogleData;
  int _currentContinent = 0;
  int _currentPlace = 0;

  int ?_selectedBrand;

  List<dynamic> _selectedCoin =
      List.filled(TagCoin.getTagCoins().length, false);

  // bool _uploadWithLessThanFourTags = false;
  // String _textSubmitButton = "";

  int ?_selectedCategory;
  List<Merchant> reviewableMerchants = [];
  List<Map<String, dynamic>> reviewableData = [];

  bool reviewMode = true;

  late String lastReviewableIndex;
  late String lastReviewableCount;

  _AddNewPlaceWidgetState(
      this.selectedType,
      this.accentColor,
      this.typeTitle,
      this.actionBarColor,
      this.pId,
      this.merchantBmapDataset,
      this.lastReviewableIndex,
      this.lastReviewableCount);

  @override
  void initState() {
    super.initState();
    int lastIndex = 0;
    int lastCount = 0;
    if (lastReviewableIndex.isNotEmpty) {
      lastIndex = int.parse(lastReviewableIndex!);
      lastCount = int.parse(lastReviewableCount);
    }

    _currentReviewableIndex =
        lastIndex != 0 && lastIndex + 1 < lastCount ? lastIndex + 1 : 0;
    _selectedBrand = (isSpecificPlace() ? null : 2); //GOCRYPTO
    reviewMode = isSpecificPlace() ? false : true;
    _selectedCoin[0] =
        isSpecificPlace() ? false : true; //PRESELECT GOCRYPTO DEFAULT
    _selectedCoin[2] = isSpecificPlace() ? false : true;
    _selectedCoin[4] = isSpecificPlace() ? false : true;

    //_initContinent();
    githubCoinector.init();

    initFocusNodes();
    initInputListener();

    if (isSpecificPlace())
      loadMerchantFromGoogleWithPlaceIdThenPrefillForm(pId);
    else
      drawFormStep(FormStep.IN_NAME);

    if (reviewMode) {
      // ImportData(githubCoinector).importDataSetGoCrypto();
      initReviewableDataSet();
      initScrapedDataSet();
    }
  }

  Future<List<Map<String, dynamic>>> _loadReviewablesByContinent(
      String continent) async {
    try {
      var response = await new Dio().get(
          'https://raw.githubusercontent.com/theRealBitcoinClub/bmap_webp/main/review/' +
              continent +
              '/review.csv');
      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter().convert(response.data);

      int index = 0;
      List<Map<String, dynamic>> allItems = [];
      // List<String> allSuggestions = [];
      rowsAsListOfValues[0].forEach((item) {
        if (isRealItem(item)) {
          if (index == 0) {
            final itemData = Map<String, dynamic>();
            itemData['value'] = 0;
            itemData['label'] = "Select Reviewable";
            allItems.add(itemData);
          }
          index++;

          final itemData = Map<String, dynamic>();
          itemData['value'] = index;
          String text = item.toString().split("\n")[0];
          itemData['label'] = index.toString() + " " + text;
          allItems.add(itemData);
          // allSuggestions.add(text.replaceFirst(",", " -"));
        }
      });
      // ImportData(githubCoinector).printSuggestions(allSuggestions, continent);
      return allItems;
    } catch (e) {
      debugPrint(e.toString());
    }
    return ReviewPlaces.searchCombosFake;
  }

  bool isRealItem(item) {
    return !item.toString().startsWith("Timestamp") &&
        !item.toString().startsWith("Name, Address");
  }

  List reviewableCombos = [ReviewPlaces.searchCombosFake];

  void initScrapedDataSet() async {
    showLoaderSafe();
    var america = await _loadReviewablesByContinent("am");
    var asia = await _loadReviewablesByContinent("as");
    var australia = await _loadReviewablesByContinent("au");
    var europe = await _loadReviewablesByContinent("e");
    setState(() {
      reviewableCombos.add(america);
      reviewableCombos.add(asia);
      reviewableCombos.add(australia);
      reviewableCombos.add(europe);
    });
    hideLoaderSafe();
  }

  void showLoaderSafe({String ?count}) {
    try {
      Loader.show(context,
          progressIndicator: count != null ? Text(count) : null);
    } catch (e) {
      print(e);
    }
  }

  void hideLoaderSafe() {
    try {
      Loader.hide();
    } catch (e) {
      print(e);
    }
  }

  void initReviewableDataSet() async {
    showLoaderSafe();
    var response = await new Dio().get(
        'https://raw.githubusercontent.com/theRealBitcoinClub/bmap_webp/main/review/json/reviewable.json');
    List<dynamic> reviewables = jsonDecode(response.data);
    int index = 0;
    List<Map<String, dynamic>> allItems = [];
    reviewables.forEach((item) {
      if (index == 0) {
        final itemData = Map<String, dynamic>();
        itemData['value'] = 0;
        itemData['label'] = "Select Reviewable";
        allItems.add(itemData);
      }
      index++;
      reviewableMerchants.add(Merchant.fromJson(item));

      final itemData = Map<String, dynamic>();
      itemData['value'] = index;
      itemData['label'] = index.toString() + " " + item["n"];
      allItems.add(itemData);
    });

    setState(() {
      reviewableData = allItems;
    });

    //_preselectNextReviewableOrResetBackToZero();

    hideLoaderSafe();
  }
/*
  void _preselectNextReviewableOrResetBackToZero() {
    AddNewPlaceWidget.getLastReviewableCountAndIndex()
        .then((String countAndIndex) {
      if (countAndIndex != null && countAndIndex.isNotEmpty) {
        int count = int.parse(countAndIndex.split(",")[0]);
        int index = int.parse(countAndIndex.split(",")[1]);
        bool hasNewReviewables = reviewableData.length != count;

        if (!hasNewReviewables) {
          setState(() {
            _selectReviewable((index + 1).toString());
          }); //hop to next reviewable, fallback to zero when out of bounds
        } else {
          AddNewPlaceWidget.setLastReviewableCountAndIndex(
              reviewableData.length.toString() + ",0");
        }
      }
    });
  }*/

  bool hasReviewable() {
    return reviewableData.length > 0;
  }

  void initInputListener() {
    /*controllerInputDASH = TextEditingController();
    controllerInputDASH.addListener(() {
      updateInputDASH(KEYWORD_CONTROLLER_ACTION);
    });
    controllerInputBCH = TextEditingController();
    controllerInputBCH.addListener(() {
      updateInputBCH(KEYWORD_CONTROLLER_ACTION);
    });*/
    controllerInputAdr = TextEditingController();
    controllerInputAdr.addListener(() {
      updateInputAdr(KEYWORD_CONTROLLER_ACTION);
    });
    controllerInputName = TextEditingController();
    controllerInputName.addListener(() {
      updateInputName(KEYWORD_CONTROLLER_ACTION);
    });
  }

  void initFocusNodes() {
    focusNodeInputDASH = FocusNode();
    focusNodeInputBCH = FocusNode();
    focusNodeInputAdr = FocusNode();
    focusNodeInputName = FocusNode();
  }

  //TODO let them remove each tag separately to add a replacement tag

  List multiplePlacesFoundSplit = [];
  int multiplePlacesCurrentIndex = 1;

  void onShowMultiplePlaceNextPlace() {
    if (multiplePlacesFoundSplit.length - 1 == multiplePlacesCurrentIndex)
      multiplePlacesCurrentIndex = 0;
    searchOnGoogleMapsPrefillFields("",
        placesId: multiplePlacesFoundSplit[++multiplePlacesCurrentIndex]);
  }

  void searchOnGoogleMapsPrefillFields(String ?input, {String? placesId}) async {
    if (placesId == null || placesId.isEmpty) {
      multiplePlacesFoundSplit = [];
      multiplePlacesCurrentIndex = 1;
      placeId = await findPlaceIdForSearchQuery(input);
    } else {
      placeId = placesId;
    }

    if (!kReleaseMode) print("placeid: " + placeId.toString());
    if (placeId == GoogleErrors.INTERNET_ERROR.toString())
      Toaster.showToastInternetError(context);
    else if (placeId == GoogleErrors.NOT_FOUND.toString()) {
      //TODO always use snackbar or toasts but dont mix them
      Toaster.showMerchantNotFoundOnGoogleMapsTryAgain(context);
      setState(() {
        prefillName(input!.split(",")[0]);
        prefillAddress(input.substring(input.indexOf(",") + 1).trim());
      });
      drawFormStep(FormStep.IN_NAME);
    } /*else if (placeId == GoogleErrors.NOT_FOUND.toString() && hasTriedSearch) {
      drawFormStep(FormStep.IN_NAME); IRRELEVANT AS WE DO NOT WANT THEM TO SIGN UP ON GOOGLE IN MANAGER MODE
    } */
    else {
      if (placeId.startsWith(GoogleErrors.MULTIPLE.toString().split(".")[1])) {
        chooseFirstCandidate();
        // Toaster.showMerchantSearchHasMultipleResults(context); moved inside findPlaceId
      }
      loadMerchantFromGoogleWithPlaceIdThenPrefillForm(placeId);
    }
  }

  Future<void> loadMerchantFromGoogleWithPlaceIdThenPrefillForm(
      String paramPlaceId) async {
    showLoaderSafe();
    placeId = paramPlaceId;
    _merchantGoogleData =
        await loadDetailsFromGoogleCreateMerchant(selectedType, paramPlaceId);
    //TODO HANDLE MORE TAGS LATER, LET ADMIN CHOOSE BEST TAGS OR SIMPLY LET CONTENT CONTAIN MORE TAGS
    prefillFormWithDataFromGoogleAndBmap(_merchantGoogleData);
    loadGooglePlacePhotos(_merchantGoogleData.placeDetailsData);
    drawFormStep(FormStep.SUBMIT);
    hideLoaderSafe();
  }

  void chooseFirstCandidate() {
    setState(() {
      multiplePlacesFoundSplit = placeId.split(";");
      placeId = multiplePlacesFoundSplit[1];
    });
  }

  Future<String> findPlaceIdForSearchQuery(String ?input) async {
    var search = inputName + " " + inputAdr;
    if (input != null && input.isNotEmpty) search = input;
    if (!kReleaseMode) print("inputs: " + search);

    Loader.show(context);
    String id = await GooglePlacesApiCoinector.findPlaceId(search, context);
    Loader.hide();
    return id;
  }

  void prefillFormWithDataFromGoogleAndBmap(Merchant merchantGoogleDataSet) {
    setState(() {
      prefillName(merchantGoogleDataSet.name);
      prefillAddress(merchantGoogleDataSet.location);
      if (merchantBmapDataset != null) {
        prefillCoins(merchantBmapDataset);
        prefillBrand(merchantBmapDataset);
        prefillCategory(merchantBmapDataset);
      }
      for (TagCoinector tag in merchantGoogleDataSet.tagsInput!) {
        allSelectedTags.add(tag);
        searchTagsDelegate.alreadySelectedTagIndexes.add(tag.id);
      }
      if (allSelectedTags.length >= MIN_INPUT_TAGS)
        drawFormStep(FormStep.SUBMIT);
      else
        drawFormStep(FormStep.SELECT_TAGS);
    });
  }

  Future<Merchant> loadDetailsFromGoogleCreateMerchant(
      int placeType, String placeId) async {
    printWrapped("\nLOADPLACE:\n" + placeId);
    var data = await GooglePlacesApiCoinector.findPlaceIdDetails(placeId);
    Merchant m = parseGmapsDataToMerchant(placeId, data, placeType);
    m.placeDetailsData = data;
    return m;
  }

  Merchant parseGmapsDataToMerchant(String placeId, data, int placeType) {
    Set<TagCoinector> resultTags =
        parseReviewsSearchForMatchingTags(data["name"], data["reviews"]);
    return Merchant.createMerchantFromGoogleMapsInputs(
        data, placeId, resultTags, placeType);
  }

  void prefillAddress(String location) {
    controllerInputAdr.clear();
    controllerInputAdr.text = location;
    updateInputAdr(location);
  }

  void prefillName(String name) {
    controllerInputName.clear();
    controllerInputName.text = name;
    updateInputName(name);
  }
/*
  String prefillTags(Set<TagCoinector> inputTags) {
    resetTags();

    //TODO order the proposed tags by number, smaller number is a more important tag, but have to write a complete converter for that to reparse all existing data or reparse all data once and dismiss old tags which havent been priority anyways

    String results = TagCoinector.parseTagsToDatabaseFormat(inputTags);

    if (inputTags.length < TagCoinector.MAX_INPUT_TAGS)
      results = TagCoinector.appendPlaceholderTags(results);

    if (!kReleaseMode) print("\nTAGS:\n" + results + "\n");
    return results;
  }*/

  Set<TagCoinector> parseReviewsSearchForMatchingTags(String name, reviews) {
    Set<TagCoinector> resultTags = {};
    if (reviews == null || reviews == "null") return resultTags;
    for (var r in reviews) {
      String review = r["text"].toString();
      if (!kReleaseMode) print("REVIEW:\n" + review + "\n");
      //TODO replace accented characters with normal ones to match more, use normalize method
      for (LangCode lang in LangCode.values) {
        matchTags(
            resultTags, review, TagFactory.getTags(context, lang: lang), true);
      }
    }
    for (LangCode lang in LangCode.values) {
      matchTags(
          resultTags, name, TagFactory.getTags(context, lang: lang), false);
    }
    return resultTags;
  }

  matchTags(Set<TagCoinector> allTags, String review, Set<TagCoinector> tags,
      bool deepMatch) {
    review = review.toLowerCase();
    if (!hasLessThanMaxTags(allTags)) return;
    for (TagCoinector t in tags) {
      String tagText = t.text.toLowerCase();
      //print(tagText);
      if (t.id != 104 && review.contains(tagText) && tagText.isNotEmpty) {
        bool hasThatId = false;
        allTags.forEach((TagCoinector tag) {
          if (tag.id == t.id) hasThatId = true;
        });
        if (!hasThatId && hasLessThanMaxTags(allTags)) {
          if (deepMatch) {
            List<String> words = review.split(" ");
            for (String word in words) {
              if (isShortTag(t) && word.toLowerCase() == tagText) {
                allTags.add(t);
              } else if (!isShortTag(t) &&
                  word.toLowerCase().contains(tagText)) {
                allTags.add(t);
              }
            }
          } else
            allTags.add(t);
        }
        // if (!kReleaseMode)
        // print("index:" + t.id.toString() + "\ntagText:" + tagText + "\n");
      }
    }
  }

  bool hasLessThanMaxTags(Set<TagCoinector> allTags) =>
      allTags.length < TagCoinector.MAX_INPUT_TAGS;

  bool isShortTag(TagCoinector t) => t.text.trim().length <= 4;

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    focusNodeInputDASH.dispose();
    focusNodeInputBCH.dispose();
    focusNodeInputAdr.dispose();
    focusNodeInputName.dispose();
    controllerInputDASH.dispose();
    controllerInputBCH.dispose();
    controllerInputAdr.dispose();
    controllerInputName.dispose();
    githubCoinector.dispose();
    Dialogs.dismissDialog();
    Loader.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: wrapBuildSubmitBtn(),
      appBar: AppBar(
        backgroundColor: actionBarColor,
        title: Text(i18n(context, "UPDATE") + " " + i18n(context, typeTitle)),
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
                      showIfPlaceIdNotProvided(
                          wrapBuildColumnPreFillReviewables(ctx)),
                      showIfPlaceIdNotProvided(buildSizedBoxSeparator()),
                      showIfPlaceIdNotProvided(buildSizedBoxSeparator()),
                      // showIfPlaceIdNotProvided(
                      //     wrapBuildColumnPreFillContinent(ctx)),
                      // showIfPlaceIdNotProvided(buildSizedBoxSeparator()),
                      // showIfPlaceIdNotProvided(
                      //     wrapBuildColumnPreFillPlace(ctx)),
                      // showIfPlaceIdNotProvided(
                      //     buildSizedBoxSeparator(multiplier: 3.0)),
                      wrapBuildColumnName(ctx),
                      wrapBuildColumnAdr(ctx),
                      wrapBuildGoogleButtons(ctx),
                      wrapBuildMultipleSwitchButton(ctx),
                      wrapBuildColumnCategory(ctx),
                      wrapBuildColumnTag(ctx),
                      buildSizedBoxSeparator(multiplier: 1.0),
                      wrapBuildSelectedTagsList(),
                      buildSizedBoxSeparator(multiplier: 2.0),
                      wrapBuildColumnImages(),
                      buildColumnCoins(ctx),
                      buildColumnBrands(ctx)
                      // wrapBuildColumnDASHyBCH(ctx),
                    ],
                  ),
                ),
              )),
    );
  }

  Widget showIfPlaceIdNotProvided(method) => pId != null ? SizedBox() : method;

  Widget wrapBuildColumnName(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: showInputAdr ? OPACITY_ITEM_VALIDATED : 1.0,
      child: buildColumnNameWithSearch(ctx));

  Widget wrapBuildColumnCategory(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: !showInputTags ? OPACITY_ITEM_DEACTIVATED : 1.0,
      child: buildColumnCategory(ctx));

  Widget wrapBuildColumnTag(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: !showInputTags
          ? OPACITY_ITEM_DEACTIVATED
          : hasInputAllTags()
              ? OPACITY_ITEM_VALIDATED
              : 1.0,
      child: buildColumnTag(ctx));

  Widget wrapBuildColumnAdr(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: !showInputAdr
          ? OPACITY_ITEM_DEACTIVATED
          : showInputTags
              ? OPACITY_ITEM_VALIDATED
              : 1.0,
      child: buildColumnAdr(ctx));

  bool hasInputAllTags() => allSelectedTags.length == MIN_INPUT_TAGS;

  /* Widget wrapBuildColumnDASHyBCH(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: !showInputDASHyBCH ? OPACITY_ITEM_DEACTIVATED : 1.0,
      child: buildColumnDASHyBCH(ctx));*/

  Widget wrapBuildSubmitBtn() => AnimatedOpacity(
        curve: DEFAULT_ANIMATION_CURVE,
        duration: DURATION_OPACITY_FADE_SUBMIT_BTN,
        opacity: showSubmitBtn
            ? allSelectedTags.length == MIN_INPUT_TAGS
                ? 1.0
                : 0.5
            : 0.0,
        child: buildSubmitBtn(context),
      );

  Padding buildEmptyPaddingAsPlaceholder() {
    return Padding(
      padding: EdgeInsets.all(0.0),
    );
  }

  Column buildColumnNameWithSearch(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          i18n(ctx, "add_place_name_title"),
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          i18n(ctx, "add_place_name_subtitle"),
          style: textStyleHint(),
        ),
        buildTextField(
            controllerInputName,
            false,
            ctx,
            focusNodeInputName,
            focusNodeInputAdr,
            0.1,
            Icons.title,
            MAX_INPUT_NAME,
            i18n(ctx, "name"),
            updateInputName)
      ],
    );
  }

  Column buildColumnPreFillReviewablesSelectBox(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SelectFormField(
            type: SelectFormFieldType.dropdown, // or can be dialog
            initialValue: _currentReviewableIndex.toString(),
            icon: Icon(Icons.search),
            labelText: 'Reviewables',
            items: reviewableData,
            onChanged: (val) => _selectReviewable(val))
      ],
    );
  }

  Column buildColumnPreFillContinentSelectBox(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SelectFormField(
            type: SelectFormFieldType.dropdown, // or can be dialog
            initialValue: "0",
            icon: Icon(Icons.airplanemode_active),
            labelText: 'Area',
            items: ReviewPlaces.continents,
            onChanged: (val) => _selectContinent(val))
      ],
    );
  }

  Column buildColumnPreFillPlaceSelectBox(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SelectFormField(
            type: SelectFormFieldType.dropdown, // or can be dialog
            initialValue: "0",
            icon: Icon(Icons.place_outlined),
            labelText: "Place",
            items: reviewableCombos[_currentContinent],
            onChanged: (val) => _selectPlace(val),
            onFieldSubmitted: (val) => _selectPlace(val))
      ],
    );
  }

  Column wrapBuildMultipleSwitchButton(ctx) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          hasMultipleResults()
              ? AnimatedOpacity(
                  curve: DEFAULT_ANIMATION_CURVE,
                  duration: DEFAULT_DURATION_OPACITY_FADE,
                  opacity: hasMultipleResults() ? 1.0 : 0.0,
                  child: ElevatedButton(
                    child: Text(
                      'SWITCH MULTIPLE RESULTS',
                      style: textStyleButtons,
                    ),
                    onPressed: () {
                      onShowMultiplePlaceNextPlace();
                    },
                  ))
              : SizedBox()
        ]);
  }

  bool hasMultipleResults() => multiplePlacesFoundSplit.length > 2;

  Column wrapBuildGoogleButtons(ctx) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          showSearchButton || showRegisterOnGMapsButton
              ? AnimatedOpacity(
                  curve: DEFAULT_ANIMATION_CURVE,
                  duration: DEFAULT_DURATION_OPACITY_FADE,
                  opacity: !showSearchButton && !showRegisterOnGMapsButton
                      ? 0.0
                      : 1.0,
                  child: !showRegisterOnGMapsButton
                      ? wrapBuildGoogleSearch(ctx)
                      : wrapBuildGoogleRegister(ctx))
              : SizedBox()
        ]);
  }

  ElevatedButton wrapBuildGoogleRegister(ctx) {
    return ElevatedButton(
      child: Text(
        Translator.translate(
            ctx, Translator.translate(ctx, "action_register_on_gmaps")),
        style: textStyleButtons,
      ),
      onPressed: () {
        UrlLauncher.launchRegisterOnGmaps();
      },
    );
  }

  ElevatedButton wrapBuildGoogleSearch(ctx) {
    return ElevatedButton(
      child: Text(
        Translator.translate(ctx, "action_search"),
        style: textStyleButtons,
      ),
      onPressed: () {
        _searchForPrefill(null);
      },
    );
  }

  void _searchForPrefill(String ?search, {String? placesId}) {
    hideSearchBtn();
    searchOnGoogleMapsPrefillFields(search, placesId: placesId);
  }

  List<RadioListTile> buildCategorySelector() {
    var tc = TabPages.pages.map((TabPageCategory e) {
      return RadioListTile(
        tileColor: _selectedCategory == null
            ? Colors.blueAccent.withAlpha(51)
            : Colors.greenAccent.withAlpha(51),
        title: Text(e.long),
        groupValue: _selectedCategory,
        value: e.typeIndex,
        onChanged: (int ?value) {
          setState(() {
            _selectedCategory = value;
          });
        },
      );
    }).toList();
    return tc;
  }

  Column buildColumnCategory(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildSizedBoxSeparator(multiplier: 1.0),
            Text(
              _merchantGoogleData != null
                  ? _merchantGoogleData.gmapsCategory
                  : "",
              style: textStyleHint(),
            ),
            buildSizedBoxSeparator(multiplier: 1.0),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: buildCategorySelector(),
        )
      ],
    );
  }

  Column buildColumnTag(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildSizedBoxSeparator(multiplier: 2.0),
        Text(
          i18n(ctx, "choose_four_tags"),
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          i18n(ctx, "hit_the_button_scroll"),
          style: textStyleHint(),
        ),
        buildSizedBoxSeparator(),
        buildSearchTagButton(ctx),
      ],
    );
  }

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
        child: GestureDetector(
          onDoubleTap: () {
            print("DOUBLE TAP TAG INDEX" + index.toString());
            setState(() {
              searchTagsDelegate.alreadySelectedTagIndexes.remove(
                  searchTagsDelegate.alreadySelectedTagIndexes
                      .elementAt(index));
              allSelectedTags.remove(allSelectedTags.elementAt(index));
            });
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              allSelectedTags.length <= index
                  ? ""
                  : TagFactory.getTags(context)
                          .elementAt(allSelectedTags.elementAt(index).id)
                          .text
                          .toUpperCase()
                          .toString() +
                      "  ",
              style: TextStyle(letterSpacing: 1.1, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  double hasTagWithThatIndexThenShowIt(index) =>
      allSelectedTags.length > index ? 1.0 : 0.0;

  List<Widget> buildTagsRow() {
    return allSelectedTags.map<Widget>((TagCoinector tag) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(tag.toUI() + "  "),
      );
    }).toList();
  }

  Widget buildSubmitBtn(ctx) {
    return FloatingActionButton.extended(
        onPressed: () async {
          if (!showSubmitBtn) return;

          if (inputName.length < MIN_INPUT_NAME) {
            Toaster.showAddName(ctx);
            return;
          }
          if (inputAdr.length < MIN_INPUT_ADR) {
            Toaster.showAddFullAdr(ctx);
            return;
          }
          if (_selectedCategory == null) {
            Toaster.showToastSelectCategory(ctx);
            //_selectedCategory
            return;
          }
          if (allSelectedTags.length < MIN_INPUT_TAGS) {
            Toaster.showAddMinimumTwoTags(ctx);
            return;
          }
          if (selectedImages.length < MIN_INPUT_SELECT_IMAGES &&
              images.length > selectedImages.length &&
              !hasSelectedImages) {
            Toaster.showAddMoreImages(ctx);
            return;
          }
          if (allSelectedTags.length < MAX_INPUT_TAGS &&
              (images.length > 0 || selectedImages.length > 0)) {
            Toaster.showAddExactlyFourTags(ctx);
            return;
          }

          submitData(ctx);
        },
        icon: Icon(Icons.send),
        label: Text(i18n(context, "send")));
  }

  void submitData(ctx) async {
    Loader.show(context, progressIndicator: LinearProgressIndicator());
    //TODO PARSE BRANDS AND COINS HERE TO ADD THEM TO MERCHANT AND REMOVE THE PRESELECT CONFIGS OR READ IN THE PRESELECTED STATE FROM LAST SUBMIT TO MAKE ADMIN INTERFACE EASIER FOR THESE WHO FOCUS ON THEIR BRAND ADDING MULTIPLE PLACES
    _merchantGoogleData = parseInputsToMerchant(_merchantGoogleData);
    await addPlaceToUploadStackAndUploadStack(
        ReviewPlaces.getContinentAsText(_currentContinent));
    /* Loader.show(context,
        isSafeAreaOverlay: false,
        isAppbarOverlay: true,
        isBottomBarOverlay: false,
        progressIndicator: CircularProgressIndicator(),
        themeData: Theme.of(context)
            .copyWith(accentColor: Colors.black38),
        overlayColor: Color(0x99E8EAF6));*/
    await githubCoinector.githubUploadPlaceImages(
        selectedImages, _merchantGoogleData);
    Loader.hide();
    //TODO SHOW PROGRESS BAR OF UPLOADS USING MULTIPLE FUTURE BLOCKS FOR EACH IMAGE
    Navigator.pop(context);

    //TODO OFFER PDF DOWNLOAD AND LET USER INPUT HIS EMAIL MAYBE TO RECEIVE IT VIA EMAIL TOO???
    //Dialogs.confirmSendEmail(context, () {
    //});
    /*Dialogs.confirmDownloadPdf(context, () {
      UrlLauncher.launchQrCodeGeneratorUrl(
          dash: hasMinInput(inputDASH) ? inputDASH : "",
          bch: hasMinInput(inputBCH) ? inputBCH : "");
    });*/
  }

  Merchant parseInputsToMerchant(Merchant m) {
    m = overwriteTagsIfSelectionChanged(m);
    m.brand = _selectedBrand != null ? _selectedBrand! : 0;
    m.type = _selectedCategory != null ? _selectedCategory! : 999;
    m = parseInputCoinsToMerchant(m);
    return m;
  }

  Merchant parseInputCoinsToMerchant(Merchant m) {
    StringBuffer acceptedCoins = StringBuffer();
    for (int x = 0; x < _selectedCoin.length; x++) {
      if (_selectedCoin[x]) {
        acceptedCoins.write(x);
        acceptedCoins.write(",");
      }
    }
    if (acceptedCoins.isNotEmpty) {
      var s = acceptedCoins.toString();
      m.acceptedCoins = s.substring(0, s.length - 1);
    }
    return m;
  }

  Column buildColumnAdr(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildSizedBoxSeparator(multiplier: 2.0),
        Text(
          i18n(ctx, "postal_adr"),
          style: textStyleLabel(),
        ),
        buildSizedBoxSeparator(),
        Text(
          i18n(ctx, "street_number"),
          style: textStyleHint(),
        ),
        buildTextField(
            controllerInputAdr,
            false,
            ctx,
            focusNodeInputAdr,
            null,
            SCROLL_POS_ADR,
            Icons.local_post_office,
            MAX_INPUT_ADR,
            i18n(ctx, "address"),
            updateInputAdr),
      ],
    );
  }

  //TODO you could integrate binance pay or elly pay or whatever here
  Column buildColumnBrands(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: buildTagBrandWidgets(),
    );
  }

  List<RadioListTile> buildTagBrandWidgets() {
    var tc = TagBrand.getBrands().map((TagBrand e) {
      return RadioListTile(
        title: Text(e.long),
        groupValue: _selectedBrand,
        value: e.index,
        onChanged: (int ?value) {
          setState(() {
            _selectedBrand = value;
          });
        },
      );
    }).toList();
    return tc;
  }

  Column buildColumnCoins(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: buildTagCoinWidgets(),
    );
  }

  //TODO for now we keep this simply here, but it could make sense to pull these out as statefulwidgets as soon as you enable entering specific addresses
  List<CheckboxListTile> buildTagCoinWidgets() {
    var tc = TagCoin.getTagCoins().map((TagCoin e) {
      return CheckboxListTile(
        title: Text(e.short + " - " + e.long),
        value: _selectedCoin[e.index],
        onChanged: (value) {
          setState(() {
            _selectedCoin[e.index] = value;
          });
        },
      );
    }).toList();
    return tc;
  }

  SizedBox buildSizedBoxSeparator({multiplier = 1.0}) =>
      SizedBox(height: 10.0 * multiplier);

  void handleAddTagButton(ctx) async {
    if (allSelectedTags.length >= MAX_INPUT_TAGS) {
      setState(() {
        resetTags();
      });
    }

    final String? selected = await showSearch<String>(
      context: ctx,
      delegate: searchTagsDelegate,
    );

    if (selected == null || selected.isEmpty) return;

    inputTag(TagCoinector.findTag(selected)!);
  }

  void inputTag(TagCoinector selected) {
    if (!kReleaseMode) print("\nSELECTED:" + selected.toString());
    addSelectedTag(selected);

    /*if (allSelectedTags.length == MIN_INPUT_TAGS) {
      drawFormStep(FormStep.SUBMIT);
    } else {
      drawFormStep(FormStep.SELECT_TAGS);
    }*/
  }

  Merchant overwriteTagsIfSelectionChanged(Merchant m) {
    if (m != null)
      m.tagsDatabaseFormat =
          TagCoinector.appendPlaceholderTags(parseTagsFromInputs());
    return m;
  }

  void resetTags() {
    // _uploadWithLessThanFourTags = false;
    allSelectedTags = Set.from([]);
    searchTagsDelegate.alreadySelectedTagIndexes = Set.from([]);
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (currentFocus != null) currentFocus.unfocus();
    if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
  }

  void scrollToWithAnimation(pos) {
    if (scrollController.hasClients) {
      scrollController.animateTo(pos,
          duration: DEFAULT_DURATION_SCROLL_ANIMATION,
          curve: DEFAULT_ANIMATION_CURVE);
    }
  }

  ElevatedButton buildSearchTagButton(ctx) {
    var iconSeparator = "   ";
    var tagCounter = allSelectedTags.length;
    return ElevatedButton(
      style: tagCounter == MAX_INPUT_TAGS
          ? ElevatedButton.styleFrom(backgroundColor: Colors.red[600])
          : (tagCounter >= MIN_INPUT_TAGS &&
                  images.isEmpty &&
                  selectedImages.isEmpty)
              ? ElevatedButton.styleFrom(backgroundColor: Colors.green[800])
              : null,
      onPressed: () {
        handleAddTagButton(ctx);
      },
      child: Padding(
        padding: buildEdgeInsetsTextField(),
        child: Row(
          children: <Widget>[
            tagCounter == MAX_INPUT_TAGS
                ? Icon(Icons.remove_circle)
                : Icon(Icons.search),
            tagCounter == 0
                ? Text(
                    iconSeparator + Translator.translate(ctx, "choose_tag_1"))
                : tagCounter == 1
                    ? Text(iconSeparator +
                        Translator.translate(ctx, "choose_tag_2"))
                    : tagCounter == 2
                        ? Text(iconSeparator +
                            Translator.translate(ctx, "choose_tag_3"))
                        : tagCounter == 3
                            ? Text(iconSeparator +
                                Translator.translate(ctx, "choose_tag_4"))
                            : Text(iconSeparator +
                                Translator.translate(ctx, "choose_tag_5"))
          ],
        ),
      ),
    );
  }

  TextField buildTextField(
      textEditingController,
      isDone,
      ctx,
      focusNode,
      nextFocusNode,
      onTapScrollToThisPosition,
      icon,
      maxLength,
      String label,
      updateInputCallback) {
    return TextField(
      enabled: isSpecificPlace() ? false : true,
      focusNode: focusNode,
      onTap: () {
        scrollToWithAnimation(onTapScrollToThisPosition);
      },
      decoration: InputDecoration(
          icon: Icon(icon),
          contentPadding: buildEdgeInsetsTextField(),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
          labelText:
              i18n(ctx, "insert_hint_1") + label + i18n(ctx, "insert_hint_2")),
      cursorColor: accentColor,
      textCapitalization: TextCapitalization.words,
      textInputAction: isDone ? TextInputAction.done : TextInputAction.next,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLength: maxLength,
      maxLines: 1,
      controller: textEditingController,
      onChanged: updateInputCallback,
      style: textStyleInput(),
    );
  }

  bool isSpecificPlace() => pId != null;

  String i18n(ctx, str) => Translator.translate(ctx, str);

  EdgeInsets buildEdgeInsetsTextField() => EdgeInsets.all(10.0);

  TextStyle textStyleInput() =>
      TextStyle(color: TEXT_COLOR, fontWeight: FontWeight.w400);

  TextStyle textStyleLabel() => TextStyle(
      color: TEXT_COLOR,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);
  TextStyle textStyleHint() => TextStyle(
      color: TEXT_COLOR.withAlpha(210),
      fontSize: 14.0,
      fontWeight: FontWeight.w300);

  void showInputAddress() {
    showInputAdr = true;
  }

  void showRegisterOnGmaps() {
    showRegisterOnGMapsButton = true;
  }

  void hideRegisterOnGmaps() {
    showRegisterOnGMapsButton = false;
  }

  void hideSearchBtn() {
    showSearchButton = false;
  }

  void showSearchBtn() {
    showSearchButton = true;
  }

  void showInputTag() {
    showInputTags = true;
  }

  void hideInputTag() {
    showInputTags = false;
  }

  void hideSubmit() {
    showSubmitBtn = false;
  }

  void showSubmit() {
    showSubmitBtn = true;
  }

  void updateInputAdr(String input) {
    if (hasMinInputsForNameAndAdr(input)) {
      drawFormStep(FormStep.HIT_SEARCH);
    }

    lastInputAdrWithCommand = input;
    if (input != KEYWORD_CONTROLLER_ACTION) {
      inputAdr = input;
    }
  }

  void updateInputName(String input) {
    if (hasMinInputsForNameAndAdr(input)) {
      drawFormStep(FormStep.HIT_SEARCH);
    } else if (hasMinInputsForName(input)) {
      drawFormStep(FormStep.IN_ADR);
    }

    lastInputNameWithCommand = input;
    if (input != KEYWORD_CONTROLLER_ACTION) {
      inputName = input;
    }
  }

  bool hasMinInputsForName(String input) {
    return input.length >= MIN_INPUT_NAME && input != KEYWORD_CONTROLLER_ACTION;
  }

  bool hasMinInputsForNameAndAdr(String input) {
    return inputAdr.length >= MIN_INPUT_ADR &&
        inputName.length >= MIN_INPUT_NAME &&
        input != KEYWORD_CONTROLLER_ACTION;
  }

  void addSelectedTag(TagCoinector selected) {
    setState(() {
      allSelectedTags.add(selected);
    });
    searchTagsDelegate.alreadySelectedTagIndexes.add(selected.id);
  }

  String parseTagsFromInputs() {
    StringBuffer b = StringBuffer();
    b.writeAll(searchTagsDelegate.alreadySelectedTagIndexes, ',');
    return b.toString();
  }

  Column wrapBuildColumnImages() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        height: images.length == 0 && selectedImages.length == 0
            ? 0
            : IMAGE_HEIGHT.toDouble(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hasSelectedImages ? selectedImages.length : images.length,
          itemBuilder: (context, index) {
            return Container(
                height: IMAGE_HEIGHT.toDouble() / 2,
                width: IMAGE_WIDTH.toDouble() / 2,
                child: GestureDetector(
                  onDoubleTap: () {
                    if (!hasSelectedImages) addImageToSelection(index);
                  },
                  child: Card(
                    color: hasSelectedImages
                        ? Colors.greenAccent.withAlpha(127)
                        : Colors.black12,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.memory(
                        hasSelectedImages
                            ? selectedImages[index]
                            : images[index],
                        fit: BoxFit.contain,
                        height: IMAGE_HEIGHT.toDouble(),
                        width: IMAGE_WIDTH.toDouble(),
                      ),
                    ),
                  ),
                ));
          },
        ),
      )
    ]);
  }

  void loadGooglePlacePhotos(var data) async {
    resetImages();
    const sleepDuration = const Duration(milliseconds: 100);
    var result = data;
    if (result != null) {
      if (result["photos"] != null) {
        int y = 0;
        // print("PHOTOCOUNT: " + result["photos"].length.toString());
        for (int x = 0; x < 10; x++)
          for (var photo in result["photos"]) {
            if (cancelAllImageLoads) return;
            if (!imagesSuccess.contains(photo["photo_reference"].toString())) {
              if (x == 0 && y < 5)
                showLoaderSafe(count: "Image: " + (++y).toString());

              if (!kReleaseMode)
                print("loadGooglePlacePhoto: " +
                    x.toString() +
                    " " +
                    photo["photo_reference"]);
              await loadGooglePlacePhoto(photo, x);
              await Future.delayed(sleepDuration);
              if (x == 0 && y < 6) hideLoaderSafe();
            }
          }
      }
    }
  }

  void resetImages() {
    images = [];
    selectedImages = [];
    imagesSuccess = Set<String>();
    hasSelectedImages = false;
    cancelAllImageLoads = false;
  }

  Future<void> loadGooglePlacePhoto(var photo, index) async {
    bool isVertical = photo["height"] > photo["width"];
    var ref = photo["photo_reference"];

    var divider = index + 1;
    bool flip = divider % 2 == 0;
    Uint8List result = await GooglePlacesApiCoinector.loadPhoto(ref,
        height: isVertical && flip ? IMAGE_WIDTH : null,
        width: isVertical && flip ? null : IMAGE_WIDTH) as Uint8List;

    print("loadGooglePlacePhoto RESULT: " +
        (result == null ? "NOP " : "JUP ") +
        index.toString() +
        " " +
        ref);

    await Future.delayed(const Duration(milliseconds: 100));
    if (result != null) {
      setState(() {
        if (cancelAllImageLoads) return;
        images.add(result);
        print("imagesSuccess: " + index.toString() + " " + ref);
        imagesSuccess.add(ref.toString());
      });
    }
  }

  void addImageToSelection(int index) {
    setState(() {
      selectedImages.add(images[index]);
      images.removeAt(index);
    });

    if (selectedImages.length >= MAX_IMAGES_UPLOAD ||
        (images.length == 0 && selectedImages.length != 0))
      lockSelectedImages();
  }

  void lockSelectedImages() {
    cancelAllImageLoads = true;
    hasSelectedImages = true;
    images.clear();
  }

  void drawFormStep(FormStep step) {
    setState(() {
      switch (step) {
        case FormStep.IN_NAME:
          drawStepInit();
          break;
        case FormStep.IN_ADR:
          drawStepInit();
          showInputAddress();
          break;
        case FormStep.HIT_SEARCH:
          showSearchBtn();
          drawStepSearch();
          break;
        case FormStep.HIT_GOOGLE:
          hideSearchBtn();
          showRegisterOnGmaps();
          resetTagsAndImages();
          break;
        case FormStep.SELECT_TAGS:
          hideSearchBtn();
          hideRegisterOnGmaps();
          showInputTag();
          focusAwayFromInputs();
          break;
        case FormStep.SUBMIT:
          hideSearchBtn();
          hideRegisterOnGmaps();
          showInputTag();
          showSubmit();
          break;
        default:
          throw Exception("invalid step");
      }
    });
  }

  void focusAwayFromInputs() {
    _fieldFocusChange(context, focusNodeInputAdr, FocusNode());
    _fieldFocusChange(context, focusNodeInputName, FocusNode());
  }

  void drawStepSearch() {
    hideRegisterOnGmaps();
    resetTagsAndImages();
  }

  void resetTagsAndImages() {
    hideInputTag();
    resetTags();
    resetImages();

    _selectedCategory = null;
    cancelAllImageLoads = false;
  }

  void drawStepInit() {
    hideSearchBtn();
    drawStepSearch();
  }

  Widget wrapBuildColumnPreFillReviewables(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: hasReviewable() ? 1.0 : 0.2,
      child: buildColumnPreFillReviewablesSelectBox(ctx));

  Widget wrapBuildColumnPreFillContinent(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: _contiVisibility,
      child: buildColumnPreFillContinentSelectBox(ctx));

  Widget wrapBuildColumnPreFillPlace(ctx) => AnimatedOpacity(
      curve: DEFAULT_ANIMATION_CURVE,
      duration: DEFAULT_DURATION_OPACITY_FADE,
      opacity: 1.0,
      child: buildColumnPreFillPlaceSelectBox(ctx));

  int _currentReviewableIndex = 0;

  _selectReviewable(String index) {
    setState(() {
      _currentReviewableIndex = int.parse(index);
    });
    if (_currentReviewableIndex == 0 ||
        _currentReviewableIndex > reviewableMerchants.length) {
      setState(() {
        _currentReviewableIndex = 0;
      });
      drawFormStep(FormStep.IN_NAME);
      return;
    }

    setState(() {
      _merchantGoogleData =
          reviewableMerchants.elementAt(_currentReviewableIndex - 1);
    });

    resetImages();
    _searchForPrefill(
        _merchantGoogleData.name + ", " + _merchantGoogleData.location);

    AddNewPlaceWidget.setLastReviewableCountAndIndex(
        reviewableData.length.toString() +
            "," +
            _currentReviewableIndex.toString());
  }

  _selectContinent(var index) {
    var contiIndex = int.parse(index);
    if (contiIndex == 0) {
      drawFormStep(FormStep.IN_NAME);
      return;
    }
    setState(() {
      _currentContinent = contiIndex;
    });
    _contiVisibility = 0.4;
  }

  _selectPlace(String place) {
    _currentPlace = int.parse(place);
    if (_currentPlace == 0) {
      drawFormStep(FormStep.HIT_SEARCH);
      return;
    }
    setState(() {
      var chosenItem = reviewableCombos[_currentContinent][_currentPlace];
      resetImages();
      _searchForPrefill(chosenItem["label"]);
    });
  }

  static Map<String, List<String>> uploadStack = Map();
  static Map<String, List<String>> allSuggestions = Map();
  static String chunkId = Random().nextInt(100000000).toString();

  addPlaceToUploadStackAndUploadStack(String continent) async {
    if (continent.isEmpty) {
      continent = "REVIEW";
      if (isSpecificPlace()) {
        continent = "UNIQUE";
      }
    }
    if (allSuggestions[continent] == null) allSuggestions[continent] = [];
    if (uploadStack[continent] == null) uploadStack[continent] = [];

    allSuggestions[continent]!
        .add(_merchantGoogleData.name + " - " + _merchantGoogleData.location);
    uploadStack[continent]!.add(_merchantGoogleData.getBmapDataJson());
    StringBuffer buff = StringBuffer();
    buff.writeln("[");
    uploadStack[continent]!.forEach((element) {
      buff.writeln(element + ",");
    });
    buff.writeln("]");

    await githubCoinector.githubUploadPlaceDetailStack(
        buff.toString(), continent, chunkId);

    allSuggestions.forEach((key, value) async {
      if (value != null && value.isNotEmpty) {
        await ImportData(githubCoinector)
            .printSuggestions(value, chunkId, key.toString());
      }
    });
    await githubCoinector.githubUploadPlaceDetails(_merchantGoogleData);
  }

  void prefillCategory(Merchant merchant) {
    _selectedCategory = merchant.type;
  }

  void prefillCoins(Merchant merchant) {
    if (merchant.acceptedCoins == null || merchant.acceptedCoins.isEmpty)
      return;
    merchant.acceptedCoins.split(",").forEach((String element) {
      _selectedCoin[int.parse(element)] = true;
    });
  }

  void prefillBrand(Merchant merchant) {
    if (merchant.brand == null || merchant.brand == -1) {
      return;
    }

    _selectedBrand = merchant.brand;
  }
}
