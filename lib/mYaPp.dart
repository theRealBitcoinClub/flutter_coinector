/*import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final picker = ImagePicker();
  Image _img;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        if (kIsWeb) {
          _img = Image.network(pickedFile.path);
        } else {
          _img = Image.file(File(pickedFile.path));
        } //image = Image.memory(await pickedFile.readAsBytes())
        uploadToGithub(pickedFile);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _img == null ? Text('No image selected.') : _img,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  void uploadToGithub(PickedFile pickedFile) async {
    /*var github = GitHub(
        auth: Authentication.withToken(
            ''));
    String content = await pickedFile.readAsBytes().toString();
    debugPrint("start gh");
    GitBlob blob = await github.git.createBlob(
        RepositorySlug("theRealBitcoinClub", "flutter_coinector"),
        CreateGitBlob(content, "utf-8"));
    github.github.client.debugPrint("end gh");
    */
    //github.git.createBlob(
    //  RepositorySlug("theRealBitcoinClub", "flutter_coinector"),
    //CreateGitBlob(content, "utf-8"));
  }
}
*/
