// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'models/cart.dart';
import 'models/order_list.dart';
import 'models/product_list.dart';
import 'pages/products_overview_page.dart'; 
import './utils/app_routes.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //lista de Provider
   // final ThemeData theme = ThemeData(fontFamily: 'Lato');

    return MultiProvider(
      providers: [
        //Products() cria um ChangeNotifierProvider
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        //Cart() cria um ChangeNotifierProvider
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
       /*  theme: theme.copyWith(
          primaryColor: Colors.purple,
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.deepOrange),
        ), */

          theme: ThemeData(
          primarySwatch: Colors.purple,          
          colorScheme:ThemeData().colorScheme.copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),

        // home: ProductOverviewScreen(),
        routes: {
          AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
