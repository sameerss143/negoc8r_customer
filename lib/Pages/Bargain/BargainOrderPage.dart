// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class BargainOrderPage extends StatelessWidget {
//   final DocumentSnapshot product;
//   //final TextEditingController _myController = TextEditingController();

//   const BargainOrderPage({Key key, @required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _myController = new TextEditingController();
//     return Scaffold(
//       appBar: new AppBar(
//         title: Text('My Bargain'),
//       ),
//       body: Form(
//         child: Column(
//           children: [
//             //Center(child: Text("Product Name :" + document.data()['name']),
//             ListTile(
//               dense: true,
//               leading: Icon(Icons.phone_android),
//               title: Text(product.data()['name']),
//               subtitle: Text('By ' + product.data()['Brand']),
//               trailing: Container(
//                 //color: Colors.green[200],
//                 child: Text('MRP: ' +
//                     product.data()['MRP'].toString() +
//                     '\nBBP: ' +
//                     product.data()['BBP'].toString()),
//               ),
//             ),
//             TextFormField(
//               initialValue: '0.00',
//               keyboardType: TextInputType.number,
//               controller: _myController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter Offer Price',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BargainOrderPage extends StatefulWidget {
  final DocumentSnapshot product;
  const BargainOrderPage({Key key, @required this.product}) : super(key: key);

  @override
  _BargainOrderPageState createState() => _BargainOrderPageState();
}

class _BargainOrderPageState extends State<BargainOrderPage> {
  int _dropdownValue = 1;
  TextEditingController _myController = TextEditingController();
  //DocumentSnapshot product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negotiate Price'),
      ),
      body: Form(
        child: Column(
          children: [
            //Center(child: Text("Product Name :" + document.data()['name']),
            ListTile(
              dense: false,
              leading: Icon(Icons.phone_android),
              trailing: Container(
                //color: Colors.green[200],
                child: Text('MRP: ' +
                    widget.product.data()['MRP'].toString() +
                    '\nBBP: ' +
                    widget.product.data()['BBP'].toString()),
              ),
              title: Text(widget.product.data()['name']),
              subtitle: Text(widget.product.data()['Brand']),
              isThreeLine: true,
            ),
            //Customer price
            TextFormField(
              validator: (String value) {
                if (widget.product.data()['BBP'] >= value) {
                  return 'Bargain value cant be less than offer value';
                } else {
                  return null;
                }
              }, //initialValue: Text('0.00').toString(),
              keyboardType: TextInputType.number,
              controller: _myController,
              decoration: const InputDecoration(
                labelText: 'Bargain Price',
                labelStyle: TextStyle(
                  fontSize: 20.0,
                ),
                hintText: 'Enter Bargain Price',
              ),
            ),
            //number of days
            DropdownButtonFormField(
              hint: Text('Valid for days'),
              items: [1, 2, 3]
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(
                        e.toString(),
                      ),
                      value: e,
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                setState(
                  () {
                    _dropdownValue = newValue;
                  },
                );
              },
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: () => _submitBargainOrder(),
            ),
          ],
        ),
      ),
    );
  }

  // bool _submitBargainOrder() {
  //   return true;
  // }

  void _submitBargainOrder() async {
    try {
      await FirebaseFirestore.instance.collection('BargainOrder').add(
        {
          'productId': '/product/wyrBLHYu6uhsvBKSrSra',
          'userId': '/customer/yxNVdYqQJsFpI3GlG5MF',
          'city': 'Mumbai',
          'area': 'Ghatkopar',
          'subArea': 'Pantnagar',
          'bargainPrice': double.parse(_myController.text.toString()),
          'dateInserted': Timestamp.now(),
          'isActive': true,
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
