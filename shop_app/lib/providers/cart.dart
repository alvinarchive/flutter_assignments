import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.productId,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0;

    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
          productId,
          (item) => new CartItem(
                id: item.id,
                productId: productId,
                title: item.title,
                price: item.price,
                quantity: item.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => new CartItem(
              id: DateTime.now().toString(),
              productId: productId,
              title: title,
              quantity: 1,
              price: price));
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (cartItem) => CartItem(
              id: cartItem.id,
              productId: cartItem.productId,
              title: cartItem.title,
              quantity: cartItem.quantity - 1,
              price: cartItem.price));
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
