import 'dart:convert';
import 'dart:typed_data';

import 'package:Coinector/AddNewPlaceWidget.dart';
import 'package:Coinector/Merchant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:github/github.dart';

import 'ConfigReader.dart';
import 'TagBrands.dart';

class GithubCoinector {
  late String _lastMerchantUploadId;

  late GitHub _github;

  late CommitUser commitUser;

  GithubCoinector();

  dispose() {
    _github.dispose();
  }

  init() {
    if (_github != null && commitUser != null) return;

    _github =
        GitHub(auth: Authentication.withToken(ConfigReader.getGithubKey()));
    commitUser = CommitUser("therealbitcoinclub", "trbc@bitcoinmap.cash");
    print("GITHUB" + _github.toString());
  }

  Future<bool> githubUploadPlaceDetailStack(
      String stack, String continent, String chunkId) async {
    CreateFile createFile = _githubCreateFileMerchantDetailStack(
        commitUser, stack, continent, chunkId);
    //TODO REMOVE ALL SPECIAL ACCENTED CHARACTERS FROM THE APP AS IT MAKES THINGS TOO COMPLICATED, ON THE INTERNET WE DO NOT HAVE ACCENTS, OBEY!!! USE THE NORMALIZE METHOD THEN REPLACE / and + with -_ again
    return await _uploadDataSafe(createFile);
  }

  Future<String> githubUploadPlaceDetails(Merchant merchant) async {
    if (_lastMerchantUploadId != null && _lastMerchantUploadId == merchant.id) {
      print("That place has already been uploaded");
      return merchant.id;
    }
    CreateFile createFile =
        _githubCreateFileMerchantDetails(commitUser, merchant);
    //TODO REMOVE ALL SPECIAL ACCENTED CHARACTERS FROM THE APP AS IT MAKES THINGS TOO COMPLICATED, ON THE INTERNET WE DO NOT HAVE ACCENTS, OBEY!!! USE THE NORMALIZE METHOD THEN REPLACE / and + with -_ again
    await _uploadDataSafe(createFile);
    _lastMerchantUploadId = merchant.id;
    Clipboard.setData(ClipboardData(text: merchant.getBmapDataJson()));
    return merchant.id;
  }

  CreateFile _githubCreateFileMerchantDetailStack(
      CommitUser commitUser, String stack, String continent, String chunkId) {
    var t = DateTime.now();
    CreateFile createFile = CreateFile(
        branch: "master",
        committer: commitUser,
        content: base64.encode(utf8.encode(stack)),
        path: "uploaded/chunks/" +
            "addplace_" +
            continent.toUpperCase() +
            "_" +
            t.year.toString() +
            t.month.toString() +
            t.day.toString() +
            "_" +
            chunkId +
            "_" +
            t.millisecondsSinceEpoch.toString() +
            ".json",
        message: "Add Place " + continent);
    if (!kReleaseMode) print("\nPATH:\n" + createFile.path.toString());
    return createFile;
  }

  CreateFile _githubCreateFileMerchantDetails(
      CommitUser commitUser, Merchant merchant) {
    var t = DateTime.now();
    CreateFile createFile = CreateFile(
        branch: "master",
        committer: commitUser,
        content: base64.encode(utf8.encode(merchant.getBmapDataJson())),
        path: "uploaded/" +
            t.year.toString() +
            "/" +
            t.month.toString() +
            "/" +
            t.day.toString() +
            "/" +
            merchant.id +
            "/" +
            "addplace_" +
            t.year.toString() +
            t.month.toString() +
            t.day.toString() +
            "_" +
            merchant.name.replaceAll(RegExp('[^A-Za-z0-9]'), '-') +
            "_" +
            TagBrand.getBrands().elementAt(merchant.brand!).short +
            "_" +
            t.millisecondsSinceEpoch.toString() +
            ".json",
        message: "Add Place " + merchant.name);
    if (!kReleaseMode) print("\nPATH:\n" + createFile.path.toString());
    return createFile;
  }

  Future<bool> githubUploadReviewablesGoCrypto(
      String continent, String fileContent) async {
    CreateFile createFile = _githubCreateFileReviewablesGoCrypto(
        commitUser, continent, fileContent);
    await _uploadDataSafe(createFile);
    return true;
  }

  Future<void> githubUploadSuggestions(
      String continent, String chunckId, String fileContent) async {
    CreateFile createFile = _githubCreateFileSuggestions(
        commitUser, continent, chunckId, fileContent);
    await _uploadDataSafe(createFile);
  }

  Future<bool> _uploadDataSafe(CreateFile createFile) async {
    bool hasSent = false;
    while (!hasSent) {
      hasSent =
          await _githubSendDataToRepository("flutter_coinector", createFile);
    }
    return true;
  }

  CreateFile _githubCreateFileReviewablesGoCrypto(
      CommitUser commitUser, String continent, String fileContent) {
    var t = DateTime.now();
    CreateFile createFile = CreateFile(
        branch: "master",
        committer: commitUser,
        content: base64.encode(utf8.encode(fileContent)),
        path: "uploaded/reviewables/gocrypto/" +
            t.year.toString() +
            "_" +
            t.month.toString() +
            "_" +
            t.day.toString() +
            "_" +
            continent.toUpperCase() +
            "_" +
            t.millisecondsSinceEpoch.toString() +
            ".json",
        message: "Add Reviewables GoCrypto");
    if (!kReleaseMode) print("\nPATH:\n" + createFile.path.toString());
    return createFile;
  }

  CreateFile _githubCreateFileSuggestions(CommitUser commitUser,
      String continent, String chunckId, String fileContent) {
    var t = DateTime.now();
    CreateFile createFile = CreateFile(
        branch: "master",
        committer: commitUser,
        content: base64.encode(utf8.encode(fileContent)),
        path: "uploaded/suggestions/" +
            t.year.toString() +
            "_" +
            t.month.toString() +
            "_" +
            t.day.toString() +
            "_" +
            continent.toUpperCase() +
            "_" +
            chunckId +
            "_" +
            t.millisecondsSinceEpoch.toString() +
            ".dart",
        message: "Add Suggestions");
    if (!kReleaseMode) print("\nPATH:\n" + createFile.path.toString());
    return createFile;
  }

  Future<void> githubUploadPlaceImages(
      List<Uint8List> selectedImages, Merchant merchant) async {
    for (Uint8List img in selectedImages) {
      await _uploadDataSafe(_githubCreateFileMerchantImage(img, merchant));
    }
  }

  Future<bool> _githubSendDataToRepository(
      String repository, CreateFile createFile) async {
    ContentCreation response = await _github.repositories.createFile(
        RepositorySlug("theRealBitcoinClub", repository), createFile);
    if (response == null || response.content == null) {
      print("\nRESPONSE NULL repo: " + repository);
      return false;
    } else {
      var url = response.content!.downloadUrl;
      print(repository +
          "\nresponse github downloadUrl:" +
          url.toString() +
          "\n" +
          "https://ezgif.com/crop?url=" +
          url.toString() +
          "\nhttps://ezgif.com/resize?url=" +
          url.toString());
    }
    return true;
  }

  CreateFile _githubCreateFileMerchantImage(Uint8List img, Merchant merchant) {
    var t = DateTime.now();
    var createFile = CreateFile(
        branch: "master",
        committer: commitUser,
        content: base64.encode(img),
        path: "uploaded/" +
            t.year.toString() +
            "/" +
            t.month.toString() +
            "/" +
            t.day.toString() +
            "/" +
            merchant.id +
            "/" +
            IMAGE_WIDTH.toString() +
            "x" +
            IMAGE_HEIGHT.toString() +
            "/" +
            merchant.id +
            "_" +
            DateTime.now().millisecondsSinceEpoch.toString() +
            ".jpg",
        message: "Add Image " + merchant.name + "_" + merchant.id);
    return createFile;
  }

/*
  Future<void> createNewFileOnGitHub() async {
    var repositorySlug =
        RepositorySlug("theRealBitcoinClub", "flutter_coinector");
    var commitUser = CommitUser("therealbitcoinclub", "trbc@bitcoinmap.cash");
    var createFile = CreateFile(
        branch: "master",
        committer: commitUser,
        content: "bXkgbmV3IGZpbGUgY29udGVudHM=",
        // content: merchant.getBmapDataJson(),
        path: "test.json",
        message: "testing api");

    Repository repository =
        await github.repositories.getRepository(repositorySlug);
    print("response github:" + repository.cloneUrl);

    ContentCreation response =
        await github.repositories.createFile(repositorySlug, createFile);
    print("response github:" + response.content.downloadUrl);
  }
*/

}
