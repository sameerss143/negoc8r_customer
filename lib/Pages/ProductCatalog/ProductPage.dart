import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  //const ProductPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NegoC8r Product Page'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //product title
        children: <Widget>[
          Text(
            'Product title',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.ac_unit,
            size: 150.0,
            color: Colors.blue[100],
          ),

          Container(
            child: Text(
              'Product short description: Lorem ipsum dolor sit amet, Nunc vehicula porttitor vehicula. Maecenas sed neque turpis. Nullam tincidunt turpis sit amet ligula lobortis venenatis quis ac elit. Sed dignissim ligula nec augue ullamcorper egestas. Proin tincidunt ornare volutpat. In semper ligula ullamcorper ipsum dictum efficitur non a nunc.',
              textAlign: TextAlign.justify,
            ),
            padding: EdgeInsets.all(10.0),
          ),

          //MRP And Best Buy prices
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'MRP: XXX.XX',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Best Buy: XXX.XX',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          //Offer prices by vendors
          Text(
            'Available Prices',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),

          Table(
            children: [
              TableRow(
                children: [
                  Radio(
                    value: false,
                    onChanged: null, //() {},
                    groupValue: 'Seller prices',
                    toggleable: true,
                  ),
                  Text('Seller'),
                  Text('Offer Price'),
                  Text('Discount')
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
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      /* bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
        ],
      ), */
    );
  }
}
