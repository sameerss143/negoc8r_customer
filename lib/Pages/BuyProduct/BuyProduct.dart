import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negoc8r_customer/Pages/Order/OrderConfirmation.dart';

class BuyProduct extends StatefulWidget {
  final DocumentSnapshot product;
  BuyProduct({Key key, @required this.product}) : super(key: key);

  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  String _selectedVendor;
  User _currentUser;

  @override
  void initState() {
    setState(() {
      _selectedVendor = null;
    });
    super.initState();
    this._currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    String _productId = widget.product.id;
    String _productName = widget.product.data()['productName'];
    String _thumbnail = widget.product.data()['thumbnail'];
    bool _isThumbnailLoaded = _thumbnail?.isNotEmpty ?? false;

    String _mrp = widget.product.data()['MRP'].toString();
    String _vendorId;
    String _vendorName;
    String _offerPrice;
    //print('#Product Id: $_productId and $_selectedProductId');
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text('Select Vendor'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: _isThumbnailLoaded
                  ? Image.network(_thumbnail)
                  : Icon(Icons.network_locked),
              //Image.network(_thumbnail),
              title: Text(
                '$_productName \nQty: 1',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                'MRP:\n$_mrp',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.70,
            //color: Colors.blue[100],
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('VendorOffer')
                  //.where('city',)
                  .where(
                    'productId',
                    isEqualTo: _productId,
                  ) //add location filters
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
                      (DocumentSnapshot vendorOffer) {
                        //_thumbnail = widget.product.data()['thumbnail'];
                        //_productId = vendorOffer.data()['productId'];
                        _vendorName = vendorOffer.data()['vendorName'];
                        _vendorId = vendorOffer.data()['vendorId'];
                        _offerPrice =
                            vendorOffer.data()['offerPrice'].toString();
                        bool _isSelected;

                        //String _bbp = vendorOffer.data()['BBP'].toString();
                        return
                            //Center(child: Text("Product Name :" + document.data()['name']),
                            ListTile(
                          dense: false,
                          leading: Radio(
                            value: vendorOffer.id,
                            groupValue: _selectedVendor,
                            toggleable: true,
                            onChanged: (value) {
                              // if (value) {
                              //   _selectedVendor = _vendorId;
                              // } else {
                              //   _selectedVendor = null;
                              // }
                              setState(
                                () {
                                  _selectedVendor = value;
                                },
                              );
                              print('$value $_isSelected $_selectedVendor');
                            },
                          ),
                          //  _isThumbnailLoaded
                          //     ? Image.network(_thumbnail)
                          //     : Icon(Icons.network_locked),

                          //Icon(Icons.phone_android),
                          trailing: Container(
                            //color: Colors.green[200],
                            child: Text("Offer Price: $_offerPrice"
                                // 'MRP: ' +
                                //     product.data()['MRP'].toString() +
                                //     '\nBBP: ' +
                                //     product.data()['BBP'].toString(),
                                ),
                          ),

                          title: Text("$_vendorName"),
                          // subtitle: Text("$_brand"),
                          // isThreeLine: true,

                          //Text(document.data()['BBP']),
                          // onTap: () {
                          //   // Navigator.push(
                          //   //   context,
                          //   //   MaterialPageRoute(
                          //   //     builder: (context) => ProductPage(document: product),
                          //   //   ),
                          //   // );
                          // },
                        );
                      },
                    ).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: RaisedButton(
        onPressed: () {
          //nvigate to next page
          if (_selectedVendor != null) {
            //navigate to order confirmation page
            print("Order confirmed");
            //add to my orders collection
            FirebaseFirestore.instance
                .collection('customer')
                .doc(_currentUser.uid)
                .collection('myOrder')
                .add({
              'productId': _productId,
              'productName': _productName,
              'thumbnail': _thumbnail,
              'vendorId': _vendorId,
              'vendorName': _vendorName,
              'MRP': _mrp,
              'orderPrice': double.parse(_offerPrice),
              'quantity': 1,
              'status': 'Confirmed',
              'isActive': true,
              'orderDate': Timestamp.now(),
            });
            FirebaseFirestore.instance
                .collection('vendor')
                .doc(_vendorId)
                .collection('myOrder')
                .add({
              'productId': _productId,
              'productName': _productName,
              'thumbnail': _thumbnail,
              'vendorId': _vendorId,
              'vendorName': _vendorName,
              'MRP': _mrp,
              'orderPrice': _offerPrice,
              'quantity': 1,
              'status': 'Confirmed',
              'isActive': true,
              'orderDate': Timestamp.now(),
            });

            Navigator.popUntil(context, (route) => false);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderConfimationPage()));
          } else {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: new Text('Please select any of the vendor offer.'),
                duration: new Duration(seconds: 10),
              ),
            );
          }
        },
        child: Text('Confirm Order'),
      ),
    );
  }

  _fetchVendorOffers(String productId) {
    return FirebaseFirestore.instance
        .collection('VendorOffer')
        .where('productId', isEqualTo: widget.product.data()[productId])
        .limit(5)
        .snapshots();
  }
}
