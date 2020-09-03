import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  //const ProductList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negotiator Product List'),
      ),
      body: Row(
        children: <Widget>[
          Container(
            color: Colors.green[200],
          ),
        ],
      ),
    );
  }
}
