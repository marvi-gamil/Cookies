import 'package:flutter/material.dart';

class Cart {
  Cart._privateConstructor();
  static final Cart instance = Cart._privateConstructor();

  final ValueNotifier<int> notifier = ValueNotifier(0);
  final List<Map<String, dynamic>> items = [];

  double getSubtotal() {
    double total = 0;
    for (var item in items) {
      final price = (item['price'] ?? 0).toDouble();
      final quantity = (item['quantity'] ?? 0).toInt();
      total += price * quantity;
    }
    return total;
  }

  void addItem(Map<String, dynamic> product) {
    int index = items.indexWhere((e) => e['name'] == product['name']);
    if (index != -1) {
      items[index]['quantity'] = (items[index]['quantity'] ?? 0) + 1;
    } else {
      items.add({...product, 'quantity': 1});
    }
    notifier.value++;
  }

  void incrementQuantity(Map<String, dynamic> product) {
    int index = items.indexWhere((e) => e['name'] == product['name']);
    if (index != -1) {
      items[index]['quantity'] = (items[index]['quantity'] ?? 0) + 1;
      notifier.value++;
    }
  }

  void decrementQuantity(Map<String, dynamic> product) {
    int index = items.indexWhere((e) => e['name'] == product['name']);
    if (index != -1) {
      if ((items[index]['quantity'] ?? 0) > 1) {
        items[index]['quantity'] -= 1;
      } else {
        items.removeAt(index);
      }
      notifier.value++;
    }
  }

  void removeItem(Map<String, dynamic> product) {
    items.removeWhere((e) => e['name'] == product['name']);
    notifier.value++;
  }

  void clear() {
    items.clear();
    notifier.value++;
  }
}
