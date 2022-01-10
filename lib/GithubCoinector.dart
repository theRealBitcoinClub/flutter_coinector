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
  String _lastMerchantUploadId;

  GitHub _github;

  CommitUser commitUser;

  GithubCoinector();

  dispose() {
    _github.dispose();
  }

  init() {
    _github =
        GitHub(auth: Authentication.withToken(ConfigReader.getGithubKey()));
    commitUser = CommitUser("therealbitcoinclub", "trbc@bitcoinmap.cash");
    print("GITHUB" + _github.toString());
  }

  Future<String> githubUploadPlaceDetails(Merchant merchant) async {
    if (merchant == null) return null;
    // Dialogs.confirmUploadPlace(context, () {

    if (_lastMerchantUploadId != null && _lastMerchantUploadId == merchant.id) {
      print("That place has already been uploaded");
      return null;
    }
    CreateFile createFile =
        githubCreateFileMerchantDetails(commitUser, merchant);
    //TODO REMOVE ALL SPECIAL ACCENTED CHARACTERS FROM THE APP AS IT MAKES THINGS TOO COMPLICATED, ON THE INTERNET WE DO NOT HAVE ACCENTS, OBEY!!! USE THE NORMALIZE METHOD THEN REPLACE / and + with -_ again
    githubSendDataToRepository("flutter_coinector", createFile);
    _lastMerchantUploadId = merchant.id;
    Clipboard.setData(ClipboardData(text: merchant.getBmapDataJson()));
    return merchant.id;
    //  });
    return null;
  }

  CreateFile githubCreateFileMerchantDetails(
      CommitUser commitUser, Merchant merchant) {
    var t = DateTime.now();
    CreateFile createFile = CreateFile(
        branch: "master",
        committer: commitUser,
        content: base64.encode(utf8.encode(merchant.getBmapDataJson())),
        path: "uploaded/" +
            merchant.id +
            "/" +
            "addplace_" +
            t.year.toString() +
            t.month.toString() +
            t.day.toString() +
            "_" +
            merchant.name.replaceAll(RegExp('[^A-Za-z0-9]'), 'x') +
            "_" +
            TagBrands.tagBrands.elementAt(merchant.brand) +
            "_" +
            t.millisecondsSinceEpoch.toString() +
            ".json",
        message: "Add Place " + merchant.name);
    if (!kReleaseMode) print("\nPATH:\n" + createFile.path);
    return createFile;
  }

  Future<void> githubUploadPlaceImages(
      List<Uint8List> selectedImages, Merchant merchant) async {
    for (Uint8List img in selectedImages) {
      await githubSendDataToRepository(
          "flutter_coinector", githubCreateFileMerchantImage(img, merchant));
    }
  }

  Future<void> githubSendDataToRepository(
      String repository, CreateFile createFile) async {
    ContentCreation response = await _github.repositories.createFile(
        RepositorySlug("theRealBitcoinClub", repository), createFile);
    var url = response.content.downloadUrl;
    print(repository +
        "\nresponse github downloadUrl:" +
        url +
        "\n" +
        "https://ezgif.com/crop?url=" +
        url +
        "\nhttps://ezgif.com/resize?url=" +
        url);
  }

  CreateFile githubCreateFileMerchantImage(Uint8List img, Merchant merchant) {
    var createFile = CreateFile(
        branch: "master",
        committer: commitUser,
        content: base64.encode(img),
        path: "uploaded/" +
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
