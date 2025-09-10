import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  double get subtotal =>
      _items.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

  void addItem(Map<String, dynamic> product) {
    final index = _items.indexWhere((item) => item['id'] == product['id']);
    if (index >= 0) {
      _items[index]['quantity'] += 1;
    } else {
      _items.add({...product, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeItem(Map<String, dynamic> product) {
    _items.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }

  void incrementQuantity(Map<String, dynamic> product) {
    final index = _items.indexWhere((item) => item['id'] == product['id']);
    if (index >= 0) {
      _items[index]['quantity'] += 1;
      notifyListeners();
    }
  }

  void decrementQuantity(Map<String, dynamic> product) {
    final index = _items.indexWhere((item) => item['id'] == product['id']);
    if (index >= 0 && _items[index]['quantity'] > 1) {
      _items[index]['quantity'] -= 1;
      notifyListeners();
    } else {
      removeItem(product);
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
