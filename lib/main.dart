import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'Pages/WelcomePage.dart';
import 'Pages/ProductList.dart';

//change
void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/homepage': (context) => HomePage(),
        '/productlist': (context) => ProductList(),
      },
    ),
  );
}
