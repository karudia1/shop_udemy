// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../models/product_model.dart'; 
import '../data/dummy_data.dart';

class Products with ChangeNotifier {

  List<Product> _items = DUMMY_PRODUCTS.cast<Product>();

  List<Product> get items  => [ ..._items ];

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
