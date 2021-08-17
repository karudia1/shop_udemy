// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_routes.dart';
import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Propósito do listen é continuar "ouvindo as mudanças".
    //Ele deve ficar false quando você não quer "ficar" sabendo das mudanças feitas
    //Ex. Quando usa atributos finais
    final Product product = Provider.of<Product>(context, listen: true);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_DETAIL,
                arguments: product,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              product.toggleFavorite();
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
