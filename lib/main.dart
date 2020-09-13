import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/Customer/AccountHome.dart';
import 'Pages/Order/OrderPage.dart';
import 'Pages/ProductCatalog/ProductCatalog.dart';
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/ProductCatalog/ProductListPage.dart';
import 'services/GoogleAuthenticationHandler.dart';

//main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      //home: WelcomePage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginPage(),
        '/homepage': (context) => HomePage(),
        '/productlist': (context) => ProductListPage(),
        '/productcatalog': (context) => ProductCatalog(),
        //'/productpage': (context) => ProductPage(DocumentSnapshot),
        '/orderpage': (context) => OrderPage(),
        '/customeraccount': (context) => CustomerAccountHome(),
        '/signindemo': (context) => SignInDemo(),
      },
    ),
  );
}
