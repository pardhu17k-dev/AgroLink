import 'package:flutter/material.dart';
import '../models/food_item.dart';

class CartItemModel {
  final FoodItem item;
  int selectedQuantity;

  CartItemModel({required this.item, this.selectedQuantity = 1});
}

class FoodProvider with ChangeNotifier {
  // 1. STATE MANAGEMENT
  final List<FoodItem> _items = List.from(mockFoodItems);
  final List<CartItemModel> _cart = [];
  final List<Map<String, dynamic>> _orders = [];

  List<FoodItem> get items => _items;
  List<FoodItem> get donations => _items.where((i) => i.isDonation).toList();
  List<FoodItem> get freshProduce => _items.where((i) => !i.isDonation).toList();
  List<CartItemModel> get cart => _cart;
  List<Map<String, dynamic>> get orders => _orders;

  void addToCart(FoodItem item, {int quantity = 1}) {
    var index = _cart.indexWhere((c) => c.item.id == item.id);
    if (index >= 0) {
      _cart[index].selectedQuantity += quantity;
    } else {
      _cart.add(CartItemModel(item: item, selectedQuantity: quantity));
    }
    notifyListeners();
  }

  void placeOrder() {
    if (_cart.isEmpty) return;
    
    // 6. ORDER TRACKING: Create a new order
    _orders.add({
      'id': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      'items': _cart.map((c) => {
        'title': c.item.title,
        'quantity': c.selectedQuantity,
        'price': c.item.price
      }).toList(),
      'status': 'Requested', // Requested -> Approved -> Ready -> Completed
      'date': DateTime.now(),
      'total': _cart.fold(0.0, (sum, cartItem) => sum + (cartItem.item.price * cartItem.selectedQuantity)),
    });
    
    _cart.clear();
    notifyListeners();
  }
}
