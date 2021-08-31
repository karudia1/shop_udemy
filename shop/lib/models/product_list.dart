// ignore_for_file: prefer_final_fields, prefer_const_declarations, unused_import, avoid_print, unused_local_variable, non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constants.dart';
import '../models/product.dart';

class ProductList with ChangeNotifier {
  
  List<Product> _items = []; //dummyProducts.cast<Product>();

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json'),
    );

    // ignore: unnecessary_null_comparison
    if (response.body == 'null') {
      return;
    }

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  // await vai esperar a resposta tem que ser async
  Future<void> addProduct(Product product) async {
    //salva os dados no firebase
    final response = await http.post(
      //para o firebase tem quer tem o final com .json, se não não vai funcionar
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    //pegar o id retornada
    final id = jsonDecode(response.body)['name'];

    //Depois da resposta do firebase
    //Salva os dados em memória
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        //para o firebase tem quer tem o final com .json, se não não vai funcionar
        //passagem do id para fazer update
        Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      //obtenho o produto
      final product = _items[index];

      // exclui do local
      _items.remove(product);
      notifyListeners();

      //manda a requisição para o servidor
      final response = await http.delete(
        //para o firebase tem quer tem o final com .json, se não não vai funcionar
        //passagem do id para remover o produto
        Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json'),
      );

      //Se tiver algum erro retorna o produto para a lista
      //Erro 400 é do lado do cliente e o 500 é do lado do servidor
      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
