import 'product.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final Map<Product, int> _cartItems = {};
  Map<Product, int> get items => _cartItems;

  void add(Product item) {
    if (_cartItems.containsKey(item)) {
      _cartItems[item] = _cartItems[item]! + 1;
    } else {
      _cartItems[item] = 1;
    }
    notifyListeners();
  }

  void remove(Product item) {
    if (_cartItems.containsKey(item)) {
      if (_cartItems[item]! > 1) {
        _cartItems[item] = _cartItems[item]! - 1;
      } else {
        _cartItems.remove(item);
      }
      notifyListeners();
    }
  }

  double get total =>
      _cartItems.entries.fold(
          0.0, (sum, entry) => sum + entry.key.price * entry.value);
}