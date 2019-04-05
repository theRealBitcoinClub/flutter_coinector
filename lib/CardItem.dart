import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Merchant.dart';
import 'package:transparent_image/transparent_image.dart';

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

  final tagText = const {'Bitcoin','Events','Trading','Organic','Vegetarian','Vegan','Healthy','Burger','Sandwich','Muffin','Brownie','Cake','Cookie','Tiramisu','Pizza','Salad','Smoothie','Fruit','IceCream','Raw','Handbag','Cosmetic','Tattoo','Piercing','Souvenir','Hatha','Vinyasa','Massage','Upcycled','Coffee','NoGluten','Cocktails','Beer','Music','Projects','Electro','Rock','LiveDJ','Terrace','Seeds','Grinder','Papers','Advice','Calzone','Suppli','MakeUp','Gifts','Tapas','Copas','Piadina','Herbs','Grains','Fashion','Fair','Women','Drinks','TV','Retro','Color','BW','BTC','BCH','Online','Booking','HotDog','Fast','Kosher','Sushi','Moto','Coche','Tablet','Chicken','Rabbit','Potatoe','DASH','ETH','ATM','Disco','Dance','TakeAway','Meditation','Wine','Champagne','Alcohol','Booze','Hookers','Girls','Gay','Party','English','BnB','Haircut','Nails','Beauty','Miso','Teriyaki','Rice','Seafood','Hostel','Fries','Fish','Chips','Italian','Karaoke',' x x x ','Battery','Wheels','Men','Pasta','Dessert','Starter','BBQ','Noodle','Korean','Market','Bread','Bakery','Cafe','Games','Snacks','Elegant','Piano','Brunch','Nachos','Lunch','Breakfast','HappyHour','LateNight','Mexican','Burrito','Tortilla','Indonesian','Sports','Pastry','Bistro','Soup','Tea','Onion','Steak','Shakes','Empanadas','Dinner','Sweet','Fried','Omelette','Gin','Donut','Delivery','Cups','Filter','Juice','Vietnamese','Pie','Unagi','Greek','Japanese','Tacos','Kombucha','Indian','Nan','Club','Liquor','Pool','Hotel','Pork','Ribs','Kava','Chai','Izzy','Matcha','CBD','Latte'};

  final Animation<double> animation;
  final VoidCallback onTap;
  final Merchant item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    //Merchant m2 = Merchant.fromJson(jsonDecode(item.toString()));
    TextStyle textStyle = Theme.of(context).textTheme.body1;
    TextStyle textStyle2 = Theme.of(context).textTheme.body2;
    //if (selected)
    //textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
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
                  color: Colors.primaries[item.type % 17],
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image:
                                "https://realbitcoinclub.firebaseapp.com/img/app/" +
                                    item.id +
                                    ".gif",
                            height: 320,
                            alignment: Alignment.bottomCenter,
                          ),
                          Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.primaries[item.type % 17],
                              //gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black, Colors.white]),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ListView(
                                children: <Widget>[
                                  Text(item.name, style: textStyle),
                                  Text(item.location, style: textStyle2),
                                  Text("Distance: 0,1km, Reviews: " +
                                      item.reviewStars +
                                      " (" +
                                      item.reviewCount +
                                      ")", style: textStyle2),
                                  Text(parseElementAt(0) + ", " + parseElementAt(1) + ", " + parseElementAt(2) + ", " + parseElementAt(3), style: textStyle2)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ButtonTheme.bar(
                        // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('REVIEW'),
                              onPressed: () {/* ... */},
                            ),
                            FlatButton(
                              child: const Text('PAY'),
                              onPressed: () {/* ... */},
                            ),
                            FlatButton(
                              child: const Text('VISIT'),
                              onPressed: () {/* ... */},
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

  String parseElementAt(int pos) => tagText.elementAt(int.parse(item.tags.split(",").elementAt(pos)));
}


