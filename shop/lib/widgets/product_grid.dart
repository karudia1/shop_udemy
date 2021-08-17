// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';  
import 'package:provider/provider.dart'; 
import '../widgets/product_item.dart';
import '../providers/products_provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;

    return GridView.builder(
      itemCount: products.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx, i) => ProductItem(products[i]),
      //quantidade fixa de elementos na linha
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisExtent: 120,
      ),
    );
  }
}
