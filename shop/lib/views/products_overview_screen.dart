// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/providers/product.dart';
import '../widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> leadedProducts = DUMMY_PRODUCTS;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Minha loja', 
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: GridView.builder(
          itemCount: leadedProducts.length,
          padding: EdgeInsets.all(10),
          itemBuilder: (ctx, i) => ProductItem(leadedProducts[i]),
          //quantidade fixa de elementos na linha
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 120,
          ),
        ));
  }
}
