import 'package:Coinector/ItemInfoStackLayer.dart';
import 'package:flutter/material.dart';

import 'CardItem.dart';
import 'ListModel.dart';
import 'Merchant.dart';

class CardItemBuilder {
  final List<ListModel<Merchant>> _lists;
  final TagFilterCallback _tagFilterCallback;
  final BuildContext _ctx;
  //final bool _isDataSaverOfflineMode;

  CardItemBuilder(this._ctx, this._lists,
      this._tagFilterCallback /*, this._isDataSaverOfflineMode*/);

  CardItem? _buildItem(
      int index, Animation<double> animation, ListModel<Merchant> listModel) {
    try {
      var currentListModel = listModel[index];
      if (listModel.length > 0) {
        return CardItem(
            index: index,
            animation: animation,
            merchant: currentListModel,
            tagFilterCallback: _tagFilterCallback,
            //TODO fix this isWebMobile as it seems to be ignored still
            isWebMobile:
                true /*kIsWeb &&
                (Theme.of(_ctx).platform == TargetPlatform.iOS ||
                    Theme.of(_ctx).platform == TargetPlatform.android)*/

            //isDataSaveOfflineMode: _isDataSaverOfflineMode,
            );
      }
    } catch (e) {
      //not catching RangeErrors caused issues with filterbar
      return null;
    }

    return null;
  }

  // Used to build list items that haven't been removed.
  Widget buildItemRestaurant(
      BuildContext context, int index, Animation<double> animation) {
    var item = _buildItem(index, animation, _lists[0]);
    return item==null?new Text("end"):item;
  }

  // Used to build list items that haven't been removed.
  Widget buildItemTogo(
      BuildContext context, int index, Animation<double> animation) {
    var item = _buildItem(index, animation, _lists[1]);
    return item==null?new Text("end"):item;
  }

  Widget buildItemBar(
      BuildContext context, int index, Animation<double> animation) {
    var item = _buildItem(index, animation, _lists[2]);
    return item==null?new Text("end"):item;
  }

  Widget buildItemMarket(
      BuildContext context, int index, Animation<double> animation) {
    var item = _buildItem(index, animation, _lists[3]);
    return item==null?new Text("end"):item;
  }

  Widget buildItemShop(
      BuildContext context, int index, Animation<double> animation) {
    var item = _buildItem(index, animation, _lists[4]);
    return item==null?new Text("end"):item;
  }

  Widget buildItemHotel(
      BuildContext context, int index, Animation<double> animation) {
    var item = _buildItem(index, animation, _lists[5]);
    return item==null?new Text("end"):item;
  }

  Widget buildItemWellness(
      BuildContext context, int index, Animation<double> animation) {
    var item = _buildItem(index, animation, _lists[6]);
    return item==null?new Text("end"):item;
  }

  // Used to build an item after it has been removed from the list. This method is
  // needed because a removed item remains  visible until its animation has
  // completed (even though it's gone as far this ListModel is concerned).
  // The widget will be used by the [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  static Widget buildRemovedItem(
      Merchant item, BuildContext context, Animation<double> animation) {
    return CardItem(
        index: 0,
        animation: animation,
        merchant: item,
        selected: false,
        tagFilterCallback: new TagFilterCallback(),
        isWebMobile: true

        // No gesture detector here: we don't want removed items to be interactive.
        );
  }
}
