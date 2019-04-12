import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Merchant.dart';
import 'package:transparent_image/transparent_image.dart';
import 'ItemInfoStackLayer.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final Merchant item;
  final bool selected;
  final double itemHeight = 100;

  @override
  Widget build(BuildContext context) {
    //Merchant m2 = Merchant.fromJson(jsonDecode(item.toString()));
    TextStyle textStyle = Theme.of(context).textTheme.body1;
    TextStyle textStyle2 = Theme.of(context).textTheme.body2;
    //if (selected)
    //textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    final generatedColor = Colors.primaries[item.type % 17];
    var image;
    try {
      image = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: "https://realbitcoinclub.firebaseapp.com/img/app/" +
            item.id +
            ".gif",
        height: 320,
        alignment: Alignment.bottomCenter,
      );
    } catch (e) {
      image = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: "https://realbitcoinclub.firebaseapp.com/img/app/trbc.gif",
        height: 320,
        alignment: Alignment.bottomCenter,
      );
      //CATCH ALL 404 because of missing images
    }
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 402,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: generatedColor,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          image,
                          Stack(
                            children: <Widget>[
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  //color: Colors.primaries[item.type % 17].withOpacity(0.7),

                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        generatedColor,
                                        generatedColor,
                                        generatedColor.withOpacity(0.9),
                                        generatedColor.withOpacity(0.75),
                                        generatedColor.withOpacity(0.6)
                                      ]),
                                ),
                              ),
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2)),
                              ),
                              new ItemInfoStackLayer(
                                  item: item,
                                  textStyle: textStyle,
                                  textStyleSmall: textStyle2,
                                  height: itemHeight)
                            ],
                          ),
                        ],
                      ),
                      ButtonTheme.bar(
                        // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('REVIEW'),
                              onPressed: () {
                                /* ... */
                              },
                            ),
                            /* FlatButton(
                              child: const Text('PAY'),
                              onPressed: () {
                                showAlertDialog(context);
                              },
                            ),*/
                            FlatButton(
                              child: const Text('VISIT'),
                              onPressed: () {
                                _launchURL();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url =
      'https://search.google.com/local/writereview?placeid=ChIJ89o4J5aipBIRfDm0sBYWJZQ';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget remindButton = FlatButton(
    child: Text("DASH"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget cancelButton = FlatButton(
    child: Text("BCH"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget launchButton = FlatButton(
    child: Text("BTC"),
    onPressed: null,
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Choose Coin"),
    content: Text("Which coin do you want to use?"),
    actions: [
      remindButton,
      cancelButton,
      launchButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
