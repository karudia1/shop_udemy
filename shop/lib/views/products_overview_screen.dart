// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';


class ProductOverviewScreen extends StatelessWidget {
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
        body: ProductGrid());
  }
}
