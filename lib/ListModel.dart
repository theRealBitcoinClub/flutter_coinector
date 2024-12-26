import 'package:flutter/material.dart';

/// Keeps a Dart List in sync with an AnimatedList.
///
/// The [insert] and [removeAt] methods apply to both the internal list and the
/// animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that mutate the
/// list must make the same changes to the animated list in terms of
/// [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    required this.tabIndex,
    required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E>? initialItems,
  })  : assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  List<E> _items;
  final int tabIndex;

  AnimatedListState? get _animatedList => listKey.currentState;

  ListModel<E> sublist(int start, int end) {
    if (end >= _items.length) end = _items.length - 1;

    _items = _items.sublist(start, end);

    return this;
  }

  void insert(int index, E item) {
    _items.insert(index, item);
    if (_animatedList != null) _animatedList!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null && _animatedList != null) {
      _animatedList!.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
