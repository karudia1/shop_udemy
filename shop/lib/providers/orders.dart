// ignore_for_file: prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';

import './cart.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    required this.id,
    this.total = 0,
    required this.products,
    required this.date,
  });
}

//Controla todos os pedidos
class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items]; //operador sprade que clona a lista
  }

  int get itemsCount {
    return _items.length;
  }

  //Método passando parâmetro por parâmetro
  void addOrder(List<CartItem> products, double total) {
    // Outra forma de pegar o total sem ser por passagem de parametro
    //double totalProduto = products.fold(0.0, (t, i) => t + (i.price * i.quantity));

    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        products: products,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void addOrderCart(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}
