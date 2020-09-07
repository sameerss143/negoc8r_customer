import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  final String _name = '';

  const ProductListTile({Key key}) : super(key: key);

//const ProductListTile(String name, String description, String mrp) {}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[Icon(Icons.ac_unit), Text(_name)],
      ),
    );
  }
}
