import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:negoc8r_customer/Pages/Bargain/BargainOrderPage.dart';

class ProductPage extends StatefulWidget {
  DocumentSnapshot document;
  // List<String> _imgList;
  // String _productName;
  ProductPage({Key key, @required this.document}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  build(BuildContext context) {
    //StorageReference imgReference = FirebaseStorage.instance.ref().child("Products");

    List _imgList = List.of(widget.document.data()['images']);
    //print(document.data()['images[0]']);
    //print('SAM: ' + List.of(document.data()['images']).first);

    //List _imgList = List.of(widget.document.data()['images']);
    String _productName = widget.document.data()['productName'];
    String _shortDesc = widget.document.data()['shortDescription'];
    String _longDesc = widget.document.data()['longDescription'];
    String _mrp = widget.document.data()['MRP'].toString();
    String _bbp = widget.document.data()['BBP'].toString();
    String _selectedShopId;
    bool _shopSelected = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('$_productName'),
      ),
      body: SingleChildScrollView(
        //controller: controller,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //product title
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                '$_productName',
                textAlign: TextAlign.left,
              ),
              padding: EdgeInsets.all(10.0),
            ),

            CarouselSlider(
              items: _imgList.map(
                (imgLink) {
                  if (imgLink != null) {
                    return Container(
                      child: Image.network(imgLink),
                    );
                  }
                },
              ).toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
            ),
            Container(
              child: Text(
                '$_shortDesc',
                textAlign: TextAlign.left,
              ),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(10.0),
            ),

            //MRP And Best Buy prices
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'MRP: $_mrp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Best Buy: $_bbp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),

            //location of the customer
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Location: ' + _getLocation(),
                  ),
                  IconButton(
                    tooltip: 'Change Location',
                    icon: Icon(Icons.location_on),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            //Offer prices by vendors
            Text(
              'In shops nearby:',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),

            Table(
              columnWidths: {
                0: FractionColumnWidth(0.2),
                1: FractionColumnWidth(0.4),
                2: FractionColumnWidth(0.2),
                3: FractionColumnWidth(0.2),
              },
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    // Radio(
                    //   value: false,
                    //   onChanged: null,
                    //   groupValue: 'Seller prices',
                    //   toggleable: true,
                    // ),
                    Text(''),
                    Text('Shop Name'),
                    Text('Offer Price'),
                    Text('Discount')
                  ],
                ),
                TableRow(
                  children: [
                    Radio(
                      toggleable: true,
                      value: _shopSelected,
                      onChanged: (value) {
                        _shopSelected = value;
                      },
                      groupValue: _selectedShopId,
                    ),
                    Text('Smith appliances'),
                    Text('195'),
                    Text('25%'),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('Buy Now'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('Negotiate'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BargainOrderPage(product: widget.document),
                      ),
                    );
                  },
                ),
              ],
            ),
            Text('$_longDesc'),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //     ),
      //   ],
      // ),
    );
  }

  String _getLocation() {
    return 'Mumbai > Ghatkopar > Pantnagar';
  }

  String _updateLocation() {
    return 'Mumbai > Ghatkopar > Bhatwadi';
  }
}
