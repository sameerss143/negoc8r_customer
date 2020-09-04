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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.ac_unit,
                size: 50.0,
                color: Colors.blue[200],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/productpage');
              },
            ),
          ),
          // Table(
          //   border: TableBorder.all(),
          //   children: [
          //     TableRow(
          //       children: [
          //         Text('data')
          //         //   Text('Product Name'),
          //         //   Text('Product Name'),
          //       ],
          //     ),
          //     // TableRow(
          //     //   children: [
          //     //     Text('XXX.XX'),
          //     //     // Text('Rating: X.X/5'),
          //     //   ],
          //     // ),
          //   ],
          //),
          Text(
            'Product Name\nPrice: XXX.XX\nProdcut Ratings: 4.5/5',
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
