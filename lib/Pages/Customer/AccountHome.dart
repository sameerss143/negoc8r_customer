import 'package:flutter/material.dart';
import 'package:negoc8r_customer/CustomWidgets/AppDrawer.dart';

class CustomerAccountHome extends StatelessWidget {
  const CustomerAccountHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      drawer: AppDrawer(),
    );
  }
}
