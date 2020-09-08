import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/ProductCatalog/ProductPage.dart';

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
      appBar: AppBar(
        title: Text('Product List'),
      ),
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
                (DocumentSnapshot product) {
                  return
                      //Center(child: Text("Product Name :" + document.data()['name']),
                      ListTile(
                    dense: false,
                    leading: Icon(Icons.phone_android),
                    trailing: Container(
                      //color: Colors.green[200],
                      child: Text('MRP: ' +
                          product.data()['MRP'].toString() +
                          '\nBBP: ' +
                          product.data()['BBP'].toString()),
                    ),

                    title: Text(product.data()['name']),
                    subtitle: Text(product.data()['Brand']),
                    isThreeLine: true,

                    //Text(document.data()['BBP']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(document: product),
                        ),
                      );
                    },
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
