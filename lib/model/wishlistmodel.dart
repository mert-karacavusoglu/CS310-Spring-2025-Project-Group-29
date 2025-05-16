import 'product.dart';
import 'package:flutter/material.dart';

class WishlistModel extends ChangeNotifier {
  final List<Product> _wishlistItems = [];
  List<Product> get items => _wishlistItems;

  void add(Product item) {
    if (!_wishlistItems.contains(item)) {
      _wishlistItems.add(item);
      notifyListeners();
    }
  }

  void remove(Product item) {
    _wishlistItems.remove(item);
    notifyListeners();
  }
}