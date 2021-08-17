// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../utils/app_routes.dart'; 

class ProductItem extends StatelessWidget {
  

  ProductItem();

  @override
  Widget build(BuildContext context) {
    var product;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_DETAIL, 
                arguments: null,
              );
              /*  Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ProductDetailScreen(product),
                ),
              ); */
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
            icon: Icon(Icons.favorite),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
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
