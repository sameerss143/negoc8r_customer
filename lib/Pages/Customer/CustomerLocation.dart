import 'package:flutter/material.dart';

class CustomerLocation extends StatefulWidget {
  final String _locationFileURL =
      'https://firebasestorage.googleapis.com/v0/b/negoc8r-dev.appspot.com/o/Reference%2FLocations%2Flocations.json?alt=media&token=137b5af3-4322-4a03-bc44-f79f0d521e65';
  CustomerLocation({Key key}) : super(key: key) {
    _readLocationJson();
  }

  @override
  _CustomerLocationState createState() => _CustomerLocationState();

  _readLocationJson() async {
    //String jsonFile =
  }
}

class _CustomerLocationState extends State<CustomerLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Set Location'),
      ),
      body: Form(
        child: Column(
          children: [
            DropdownButton(items: null, onChanged: null),
            DropdownButton(items: null, onChanged: null),
            DropdownButton(items: null, onChanged: null),
            RaisedButton(
              child: Text(
                'Update Location',
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
