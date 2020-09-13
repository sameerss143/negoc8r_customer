import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:negoc8r_customer/Pages/Bargain/BargainOrderPage.dart';

class ProductPage extends StatelessWidget {
  final DocumentSnapshot document;
  const ProductPage({Key key, @required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //StorageReference imgReference = FirebaseStorage.instance.ref().child("Products");

    List imgList = List.of(document.data()['images']);
    //print(document.data()['images[0]']);
    //print('SAM: ' + List.of(document.data()['images']).first);

    return Scaffold(
      appBar: AppBar(
        title: Text(document.data()['name']),
      ),
      body: SingleChildScrollView(
        //controller: controller,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //product title
          children: <Widget>[
            // Text(
            //   document.data()['name'],
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            /*Icon(
            Icons.ac_unit,
            size: 150.0,
            color: Colors.blue[100],
          ),*/
/*
Container(
            child: CarouselSlider(items: imgList.map((i) {
              return Builder(builder: (BuildContext context){
return Container(
  child: Image.network(i),

              },)
            ),),),
                
                Image.network(i,
                height: 200.0,
                width: 200.0,
              ),
              },
              ),

            ],),
*/
            CarouselSlider(
              items: imgList.map(
                (imgLink) {
                  return Container(
                    child: Image.network(imgLink),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
            ),

            // ImageSlider(
            //     showTabIndicator: true,
            //     children: imgList.map(
            //       (String link) {
            //         return new ClipRRect(
            //           borderRadius: BorderRadius.circular(5.0),
            //           child: Image.network(
            //             link,
            //           ),
            //         );
            //       },
            //     ).toList(),
            //     width: 200,
            //     height: 200,
            //     tabController: null),

            // Image.network(
            //   List.of(document.data()['images']).first,
            //   height: 200.0,
            //   width: 200.0,
            // ),
            //),
            Container(
              child: Text(
                document.data()['shortDescription'],
                textAlign: TextAlign.justify,
              ),
              padding: EdgeInsets.all(10.0),
            ),

            //MRP And Best Buy prices
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'MRP: ' + document.data()['MRP'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Best Buy: ' + document.data()['BBP'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),

            //location of the customer

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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BargainOrderPage(product: document),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
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
