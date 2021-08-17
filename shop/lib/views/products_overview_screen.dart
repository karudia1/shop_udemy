// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //controla o filtro na app inteira
    final Products products = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Minha loja'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                if (selectedValue == FilterOptions.Favorite) {
                  products.showFavoriteOnly();
                } else {
                  products.showAll();
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Somente favoritos'),
                  value: FilterOptions.Favorite,
                ),
                PopupMenuItem(
                  child: Text('Todos'),
                  value: FilterOptions.All,
                )
              ],
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ProductGrid());
  }
}
