// ignore_for_file: prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'product_model.dart';
import '../data/dummy_data.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS.cast<Product>();

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  //estratégia 1
  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'].toString(),
      description: data['description'].toString(),
      price: double.parse(data['price'].toString()),
      imageUrl: data['imageUrl'].toString(),
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);

    //exite o produto na lista
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);

    //exite o produto na lista
    if (index >= 0) {
      _items.removeWhere((element) => element.id == product.id);
      notifyListeners();
    }
  }

  int get itemsCount {
    return _items.length;
  }
}

  /* 
  //Atributo privado
  bool _showFavoriteOnly = false;
  
  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  } */