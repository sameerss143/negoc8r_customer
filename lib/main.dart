import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/ProductCatalog/ProductPage.dart';
import 'Pages/Customer/AccountHome.dart';
import 'Pages/Order/OrderPage.dart';
import 'Pages/ProductCatalog/ProductCatalog.dart';
import 'Pages/HomePage.dart';
import 'Pages/WelcomePage.dart';
import 'Pages/ProductCatalog/ProductList.dart';

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
        '/productpage': (context) => ProductPage(),
        '/orderpage': (context) => OrderPage(),
        '/customeraccount': (context) => CustomerAccountHome(),
      },
    ),
  );
}
