// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_grid_item.dart';
import '../providers/products_provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    final products = showFavoriteOnly
        ? productProvider.favoriteItems
        : productProvider.items;

    return GridView.builder(
      itemCount: products.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //No ChangeNotifierProvider que já foi criado usar value e não create
        value: products[i],
        child: ProductGridItem(),
      ),
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
