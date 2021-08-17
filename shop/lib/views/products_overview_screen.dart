// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, constant_identifier_names, unused_field

import 'package:flutter/material.dart'; 
import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  //Atributo privado
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Minha loja'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorite) {
                    _showFavoriteOnly = true;
                  } else {
                    _showFavoriteOnly = false;
                  }
                });
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
        body: ProductGrid(_showFavoriteOnly));
  }
}
 /*  //controla o filtro na app inteira
     final Products products = Provider.of(context);
    onSelected: (FilterOptions selectedValue) {
                if (selectedValue == FilterOptions.Favorite) {
                  products.showFavoriteOnly();
                } else {
                  products.showAll();
                }
              }, */