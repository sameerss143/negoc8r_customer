import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/ProductCatalog/ProductPage.dart';

class ProductListPage extends StatefulWidget {
  final String productCategory;

  const ProductListPage({
    Key key,
    this.productCategory,
  }) : super(key: key);

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
        stream: FirebaseFirestore.instance
            .collection('product')
            .where('category', isEqualTo: widget.productCategory)
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
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
            //print('#snapshot has data');
            return ListView(
              children: snapshot.data.docs.map(
                (DocumentSnapshot product) {
                  String _thumbnail = product.data()['thumbnail'];
                  bool _isThumbnailLoaded = _thumbnail?.isNotEmpty ?? false;
                  String _productName = product.data()['productName'];
                  String _brand = product.data()['brand'];
                  String _mrp = product.data()['MRP'].toString();
                  String _bbp = product.data()['BBP'].toString();
                  return
                      //Center(child: Text("Product Name :" + document.data()['name']),
                      ListTile(
                    dense: false,
                    leading: _isThumbnailLoaded
                        ? Image.network(_thumbnail)
                        : Icon(Icons.network_locked),

                    //Icon(Icons.phone_android),
                    trailing: Container(
                      //color: Colors.green[200],
                      child: Text("MRP: $_mrp \nBBP: $_bbp"
                          // 'MRP: ' +
                          //     product.data()['MRP'].toString() +
                          //     '\nBBP: ' +
                          //     product.data()['BBP'].toString(),
                          ),
                    ),

                    title: Text("$_productName"),
                    subtitle: Text("$_brand"),
                    isThreeLine: true,

                    //Text(document.data()['BBP']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(product: product),
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
