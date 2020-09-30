///List of active orders

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //User user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      // body: ListView(
      //   children: <Widget>[
      //     ListTile(
      //       leading: Icon(Icons.access_alarm),
      //     )
      //   ],
      // ),
      body: //Text('List of my orders'),
          // ******************streambuilder query is failing. resolve this on priority*************
          StreamBuilder(
        stream: _fetchOrderList(),
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
                (DocumentSnapshot order) {
                  String _thumbnail = order.data()['thumbnail'];
                  bool _isThumbnailLoaded = _thumbnail.isNotEmpty;
                  return ListTile(
                    dense: true,
                    leading: _isThumbnailLoaded
                        ? Image.network(_thumbnail)
                        : Icon(Icons.network_locked),
                    //Icon(Icons.phone_android),
                    trailing: Container(
                      //color: Colors.green[200],
                      child: Text('Price: ' +
                              order.data()['orderPrice'].toString() +
                              '\nStatus: ' +
                              order.data()['status']

                          //DateTime.parse(
                          //  order.data()['orderDate'].toDate().toString(),
                          //).toString(),
                          // + '\nValid Till: ' +
                          // new DateTime().millisecondsSinceEpoch(
                          //     order.data()['validTill'])),
                          ),
                    ),
                    title: Text(
                      'Product: ' + order.data()['productName'],
                    ),
                    subtitle: Text(
                      'Order Id: ' +
                          order.id.toString() +
                          '\nOrder Date: ' +
                          order
                              .data()['orderDate']
                              .toDate()
                              .toString()
                              .substring(0, 10),
                    ),

                    isThreeLine: true,

                    //onTap: () {},
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProductPage(document: product),
                    //   ),
                    // );
                  );
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot> _fetchOrderList() {
    try {
      // print(
      //   'inside order fetch. uid: ' + _user.uid.toString(),
      // );
      return FirebaseFirestore.instance
          .collection('customer')
          .doc(_user.uid)
          .collection('myOrder')
          .where(
            'isActive',
            isEqualTo: true,
          )
          // .orderBy(
          //   'orderDate',
          //   descending: true,
          // )
          .limit(10)
          .snapshots();
    } on Exception catch (e) {
      // handle excp
      print(e.toString());
      print('### Order Query Failed.\n' + e.toString());
      return null;
    }
  }
}
