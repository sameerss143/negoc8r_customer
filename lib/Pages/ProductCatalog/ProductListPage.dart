import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({Key key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('product').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text('data not fetched yet'),
              //child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map(
                (DocumentSnapshot document) {
                  return
                      //Center(child: Text("Product Name :" + document.data()['name']),
                      Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.ac_unit,
                            size: 50.0,
                            color: Colors.blue[200],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/productpage');
                          },
                        ),
                        Text("Product Name :" +
                            document.data()['name'] +
                            "\nCategory :" +
                            document.data()['Brand']),
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }
}

// class ProductList extends StatelessWidget {
//   //const ProductList({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Negotiator Product List'),
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Container(
//             child: IconButton(
//               icon: Icon(
//                 Icons.ac_unit,
//                 size: 50.0,
//                 color: Colors.blue[200],
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/productpage');
//               },
//             ),
//           ),
//           // Table(
//           //   border: TableBorder.all(),
//           //   children: [
//           //     TableRow(
//           //       children: [
//           //         Text('data')
//           //         //   Text('Product Name'),
//           //         //   Text('Product Name'),
//           //       ],
//           //     ),
//           //     // TableRow(
//           //     //   children: [
//           //     //     Text('XXX.XX'),
//           //     //     // Text('Rating: X.X/5'),
//           //     //   ],
//           //     // ),
//           //   ],
//           //),
//           Text(
//             'Product Name\nPrice: XXX.XX\nProdcut Ratings: 4.5/5',
//             textAlign: TextAlign.left,
//           ),
//         ],
//       ),
//     );
//   }
// }
