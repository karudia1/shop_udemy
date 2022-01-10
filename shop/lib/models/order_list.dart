// ignore_for_file: prefer_final_fields, unused_local_variable

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart_item.dart';
import 'package:shop/utils/constants.dart';

import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
    );

    // ignore: unnecessary_null_comparison
    if (response.body == 'null') {
      return;
    }

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach(
      (orderId, orderData) {
        _items.add(
          Order(
            id: orderId,
            total: double.parse(orderData['total']),
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                id: item['id'],
                productId: item['productId'],
                name: item['name'],
                quantity: item['quantity'],
                price: item['price'],
              );
            }).toList(),
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    //salva os dados no firebase
    final response = await http.post(
      //para o firebase tem quer tem o final com .json, se não não vai funcionar
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
      body: jsonEncode(
        {
          "total": cart.totalAmount.toString(),
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'name': cartItem.name,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  })
              .toList(),
        },
      ),
    );

    //pegar o id retornada
    //final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}
