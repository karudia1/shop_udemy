// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:shop/providers/counter_provider.dart'; 

class ProductDetailScreen extends StatefulWidget {
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: <Widget>[
          Text(CounterProvider.of(context)!.state.value.toString()),
          ElevatedButton(
            child: const Text('+'),
            onPressed: () {
              setState(() {
                CounterProvider.of(context)!.state.inc();
              });

              print(CounterProvider.of(context)!.state.value);
            },
          )
        ],
      ),
    );
  }
}
