import 'dart:convert';

import 'package:Coinector/GithubCoinector.dart';
// import 'package:country_codes/country_codes.dart';
import 'package:dio/dio.dart';

import 'Merchant.dart';

class ImportData {
  late GithubCoinector github;

  ImportData(GithubCoinector coinector) {
    github = coinector;
  }

  void importDataSetGoCrypto() async {
    int fileCount = 23;
    Map<String, List<Merchant>> reviewablesResultMap = new Map();
    for (int index = 0; index < fileCount; index++) {
      var response = await new Dio().get(
          'https://raw.githubusercontent.com/theRealBitcoinClub/flutter_coinector/master/inputData/2022_04_gocrypto_' +
              index.toString() +
              '.txt');
      var data = response.data;
      //var results = data['results'];
      var reviewables = jsonDecode(data);
      reviewables['results'].forEach((item) {
        String pId = getPlaceId(item);
        String countryCode = item['country'];
        String country = getCountryName(countryCode);
        Merchant m = createMerchantForReview(pId, item, country);

        addReviewableToResultsMap(reviewablesResultMap, countryCode, m);
      });
    }
    uploadResultsMapToGitHub(reviewablesResultMap);
  }

  void uploadResultsMapToGitHub(
      Map<String, List<Merchant>> reviewablesResultMap) async {
    reviewablesResultMap.forEach((key, List<Merchant> places) async {
      StringBuffer buff = printMerchantsResultList(places);
      await github.githubUploadReviewablesGoCrypto(key, buff.toString());
    });
  }

  StringBuffer printMerchantsResultList(List<Merchant> places) {
    StringBuffer buff = StringBuffer("[");
    places.forEach((Merchant item) {
      buff.writeln(item.getBmapDataJson() + ",");
    });
    buff.writeln("]");
    return buff;
  }

  void addReviewableToResultsMap(
      Map<String, List<Merchant>> reviewablesResultMap,
      String countryCode,
      Merchant m) {
    if (reviewablesResultMap[countryCode] == null)
      reviewablesResultMap[countryCode] = [];
    reviewablesResultMap[countryCode]!.add(m);
  }

  Merchant createMerchantForReview(String pId, item, String country) {
    String city = item["city"] != null && item['city'].toString().isNotEmpty
        ? item['city']
        : "";
    String location = city.isNotEmpty ? (city + ", " + country) : country;
    Merchant m = Merchant(pId, 0.0, 0.0, item['name'], 0, "0", "0.0", 0,
        "104,104,104,104", location, 0, "0");
    return m;
  }

  String getCountryName(String countryCode) {
    /*String country;
    CountryCodes.countryCodes().forEach((CountryDetails details) {
      if (details.alpha2Code == countryCode) {
        country = details.name;
      }
    });
    return country;*/
    return countryCode;
  }

  String getPlaceId(item) {
    String pId = item['place_id'];
    if (pId == null || pId.isEmpty || !pId.startsWith("ChI")) {
      pId = "";
    }
    return pId;
  }

  Future<bool> printSuggestions(
      List<String> allSuggestions, String continent, String chunckId) async {
    var continentUpperCase = continent.toUpperCase();
    StringBuffer buff = StringBuffer("class AutoSuggestions" +
        continentUpperCase +
        " { static final reviewedTitles" +
        continentUpperCase +
        " = const {");
    allSuggestions.forEach((element) {
      buff.writeln('"' + element + '",');
    });
    buff.writeln("};");
    buff.writeln("}");
    github.githubUploadSuggestions(continent, chunckId, buff.toString());
    return true;
  }
}
