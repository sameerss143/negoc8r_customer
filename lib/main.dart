import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/ProductCatalog/ProductCatalog.dart';
import 'Pages/HomePage.dart';
import 'Pages/WelcomePage.dart';
import 'Pages/ProductList.dart';

//change
void main() {
  runApp(
    MaterialApp(
      //home: WelcomePage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => WelcomePage(),
        '/homepage': (context) => HomePage(),
        '/productlist': (context) => ProductList(),
        '/productcatalog': (context) => ProductCatalog(),
      },
    ),
  );
}
