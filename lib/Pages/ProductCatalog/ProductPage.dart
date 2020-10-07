import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:negoc8r_customer/CustomWidgets/SetLocation.dart';
//import 'package:negoc8r_customer/Objects/LocationClasses.dart';
import 'package:negoc8r_customer/Pages/Bargain/BargainOrderPage.dart';
import 'package:negoc8r_customer/Pages/BuyProduct/BuyProduct.dart';

class ProductPage extends StatefulWidget {
  final DocumentSnapshot product;
  // List<String> _imgList;
  // String _productName;
  ProductPage({Key key, @required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //String _currentLocation;
  //Location _currentLocation(city: 'Mumbai', area: 'Ghatkopar', subArea: 'Pantnagar');
  //static Location _currentLocation;
  //String _currentLocationTxt;

  @override
  void initState() {
    super.initState();
    // _currentLocation = new Location(
    //   city: 'Mumbai',
    //   area: 'Ghatkopar',
    //   subArea: 'Pantnagar',
    // );
    //_currentLocationTxt = _currentLocation.getLocationText();
  }

  @override
  Widget build(BuildContext context) {
    //StorageReference imgReference = FirebaseStorage.instance.ref().child("Products");

    List _imgList = List.of(widget.product.data()['images']);
    //_currentLocation = _getLocation();
    // _currentLocation.setData(
    //   'Mumbai',
    //   'Ghatkopar',
    //   'Pantnagar',
    // );
    //print(document.data()['images[0]']);
    //print('SAM: ' + List.of(document.data()['images']).first);

    //List _imgList = List.of(widget.document.data()['images']);
    String _productName = widget.product.data()['productName'];
    String _productId = widget.product.id;
    String _shortDesc = widget.product.data()['shortDescription'];
    String _longDesc = widget.product.data()['longDescription'];
    String _mrp = widget.product.data()['MRP'].toString();
    String _bbp = widget.product.data()['BBP'].toString();
    //_currentLocationTxt = _currentLocation.getLocationText();
    User _user = FirebaseAuth.instance.currentUser;
    //String _selectedShopId;
    //bool _shopSelected = false;

    try {
      print('# $_productId  $_productName');
      return Scaffold(
        appBar: AppBar(
          title: Text('$_productName'),
        ),
        body: new SingleChildScrollView(
          //controller: controller,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //product title
            children: <Widget>[
              // Container(
              //   alignment: Alignment.bottomLeft,
              //   child: Text(
              //     '$_productName',
              //     textAlign: TextAlign.left,
              //   ),
              //   padding: EdgeInsets.all(5.0),
              // ),
              new CarouselSlider(
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
                  autoPlayInterval: Duration(seconds: 5),
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
              // SizedBox(
              //   height: 10.0,
              // ),

              //location of the customer
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    // Text(
                    //   'Current Location:\n' + '$_currentLocationTxt',
                    //   textAlign: TextAlign.center,
                    // ),

                    //Location
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('customer')
                          .doc(_user.uid)
                          .collection('myLocation')
                          .doc('currentLocation')
                          .get(),
                      initialData: Text('Location not set'),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                          case ConnectionState.active:
                            return Text('Waiting');
                            break;
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              DocumentSnapshot location = snapshot.data;
                              if (location.data() != null) {
                                String city = location.data()['city'];
                                String area = location.data()['area'];
                                String subArea = location.data()['subArea'];
                                if (city != null &&
                                    area != null &&
                                    subArea != null) {
                                  return Text(
                                      'Location: $city > $area > $subArea');
                                }
                              } else {
                                return Text(
                                  'Please set the location.',
                                  style: TextStyle(color: Colors.red),
                                );
                              }
                            }
                            break;
                          default:
                            return Text(
                              'Please set the location.',
                              style: TextStyle(color: Colors.red),
                            );
                        }
                      },
                    ),
                    IconButton(
                      tooltip: 'Change Location',
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        //print(_currentLocation.getLocationText());
                        //_changeLocation(_currentLocation);
                        Navigator.pushNamed(context, '/setlocation');

                        // setState(
                        //   () {
                        //     _currentLocationTxt =
                        //         _currentLocation.getLocationText();
                        //   },
                        // );
                        //print(_currentLocation.getLocationText());
                        // setState((value) {
                        //   _currentLocation = value;
                        // });
                      },
                    ),
                  ],
                ),
              ),

              Text(
                'Top offers by Vendors in this area',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),

              // FutureBuilder(
              //   future: FirebaseFirestore.instance
              //       .collection('VendorOffer')
              //       //.doc()
              //       .snapshots()
              //       .where('productId', isEqualTo: _productId)
              //       .orderBy('offerPrice')
              //       .limit(5),
              //   initialData: Text('Location not set'),
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     DocumentSnapshot location = snapshot.data;
              //     String city = location.data()['city'];
              //     String area = location.data()['area'];
              //     String subArea = location.data()['subArea'];
              //     return Text('Location: $city > $area > $subArea');
              //   },
              // ),
              //Offer prices by vendors
              // StreamBuilder<Object>(
              //   stream: FirebaseFirestore.instance
              //       .collection('VendorOffer')
              //       .where('city', isEqualTo: _currentLocation.city)
              //       .where('area', isEqualTo: _currentLocation.area)
              //       .where('subarea', isEqualTo: _currentLocation.subArea)
              //       .where('productId', isEqualTo: _productId)
              //       //.orderBy('offerPrice', descending: true)
              //       .limit(3)
              //       .snapshots(),
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     switch (snapshot.connectionState) {
              //       case (ConnectionState.waiting):
              //         {
              //           return Text('Loading');
              //         }
              //         break;
              //       default:
              //         if (snapshot.hasError) {
              //           return Text('Error');
              //         } else {
              //           // return Table(
              //           //   //snapshot.data.
              //           //   //Text('Data Loaded' + snapshot.data.toString());

              //           //   columnWidths: {
              //           //     0: FractionColumnWidth(0.2),
              //           //     1: FractionColumnWidth(0.4),
              //           //     2: FractionColumnWidth(0.2),
              //           //     3: FractionColumnWidth(0.2),
              //           //   },
              //           //   border: TableBorder.all(),
              //           //   children: [
              //           //     TableRow(
              //           //       children: [
              //           //         // Radio(
              //           //         //   value: false,
              //           //         //   onChanged: null,
              //           //         //   groupValue: 'Seller prices',
              //           //         //   toggleable: true,
              //           //         // ),
              //           //         Text(''),
              //           //         Text('Shop Name'),
              //           //         Text('Offer Price'),
              //           //         Text('Discount')
              //           //       ],
              //           //     ),
              //           //   ],
              //           // );

              //           return Container(
              //             child: new ListView(
              //               scrollDirection: Axis.vertical,
              //               shrinkWrap: true,
              //               children: snapshot.data.docs.map<Widget>(
              //                 (DocumentSnapshot vendorOffer) {
              //                   return ListTile(
              //                     leading: Radio(
              //                       toggleable: true,
              //                       value: _shopSelected,
              //                       onChanged: (value) {
              //                         _shopSelected = value;
              //                         _selectedShopId =
              //                             vendorOffer.data()['vendorId'];
              //                       },
              //                       groupValue: _selectedShopId,
              //                     ),
              //                     title: Text('jhjhj'),
              //                     //vendorOffer.data()['vendorName']),
              //                     trailing: Text('195'),
              //                     //Text('25%'),
              //                   );
              //                 },
              //               ).toList(),
              //             ),
              //             //height: MediaQuery.of(context).size.height * .40,
              //             color: Colors.blue[100],
              //           );
              //         }
              //     }
              //   },
              // ),

              // Table(
              //   columnWidths: {
              //     0: FractionColumnWidth(0.2),
              //     1: FractionColumnWidth(0.4),
              //     2: FractionColumnWidth(0.2),
              //     3: FractionColumnWidth(0.2),
              //   },
              //   border: TableBorder.all(),
              //   children: [
              //     TableRow(
              //       children: [
              //         // Radio(
              //         //   value: false,
              //         //   onChanged: null,
              //         //   groupValue: 'Seller prices',
              //         //   toggleable: true,
              //         // ),
              //         Text(''),
              //         Text('Shop Name'),
              //         Text('Offer Price'),
              //         Text('Discount')
              //       ],
              //     ),
              //     TableRow(
              //       children: [
              //         Radio(
              //           toggleable: true,
              //           value: _shopSelected,
              //           onChanged: (value) {
              //             _shopSelected = value;
              //           },
              //           groupValue: _selectedShopId,
              //         ),
              //         Text('Smith appliances'),
              //         Text('195'),
              //         Text('25%'),
              //       ],
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Buy Now'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BuyProduct(product: widget.product),
                        ),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('Negotiate'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BargainOrderPage(product: widget.product),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
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
    } catch (e) {
      return Text('Something went wrong');
      //report error
    }
  }

  // Location _getLocation() {
  //   return Location(
  //     city: 'Mumbai',
  //     area: 'Ghatkopar',
  //     subArea: 'Pantnagar',
  //   );
  // }

  // _changeLocation(Location currentLocation) async {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext bc) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * .80,
  //         child: Column(
  //           children: <Widget>[
  //             Text(
  //               'Change Location: ',
  //               style: TextStyle(fontSize: 16.0),
  //             ),
  //             // new MyLocation(
  //             //   currentLocation: _currentLocation,
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //   // _currentLocation = 'Mumbai > Ghatkopar > Bhatwadi';
  // }
}
