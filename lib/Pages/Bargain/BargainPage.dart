import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BargainPage extends StatefulWidget {
  final DocumentSnapshot document;
  const BargainPage({Key key, @required this.document}) : super(key: key);

  @override
  _BargainPageState createState() => _BargainPageState();
}

class _BargainPageState extends State<BargainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negotiate Price'),
      ),
      body: Form(
        child: Column(
          children: [
            //Customer price
            TextFormField(
              initialValue: '0.00',
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Offer Price',
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
              onChanged: null,
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
