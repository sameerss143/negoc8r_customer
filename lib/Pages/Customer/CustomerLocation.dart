import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerLocation extends StatefulWidget {
  final String _locationFileURL =
      'https://firebasestorage.googleapis.com/v0/b/negoc8r-dev.appspot.com/o/Reference%2FLocations%2Flocations.json?alt=media&token=137b5af3-4322-4a03-bc44-f79f0d521e65';

  CustomerLocation({Key key}) : super(key: key) {
    _readLocationJson();
  }

  @override
  _CustomerLocationState createState() => _CustomerLocationState();

  _readLocationJson() async {
    //var response = await http.get(_locationFileURL);
    // //print(response.toString());
    //var _jsonFile = json.decode(response.body);
    //print(jsonFile.toString());
    // for (var city in _jsonFile) {
    //   //var area = city['area'];
    //   print(
    //     '#' + city['id'].toString() + city['city'],
    //   );
    //   for (var area in city['area']) {
    //     print('## ' + area['name']);
    //     for (var subArea in area['subArea']) {
    //       print('### ' + subArea['name']);
    //     }
    //   }

    //print('#' + city.toString());

    //for (city['area'] in city) {
    //print('#' + area['id'].toString() + area['name']);
    //}
    //}
  }
}

class Area {
  int id;
  String name;
}

class City {
  int id;
  String name;
  City({
    this.id,
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return new City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class _CustomerLocationState extends State<CustomerLocation> {
  List<City> _city = [];
  String _selectedCity;
  String _locationFileURL =
      'https://firebasestorage.googleapis.com/v0/b/negoc8r-dev.appspot.com/o/Reference%2FLocations%2Flocations.json?alt=media&token=137b5af3-4322-4a03-bc44-f79f0d521e65';

  _readJsonFile() async {
    var response = await http.get(_locationFileURL);
    // //print(response.toString());
    return JsonDecoder().convert(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    //final json = JsonDecoder().convert(data);

    var jsonObj = _readJsonFile();

    _city = (jsonObj).map<City>((item) => City.fromJson(item)).toList();
    _selectedCity = _city[0].name;

    return Scaffold(
      appBar: new AppBar(
        title: Text('Set Location'),
      ),
      body: Form(
        child: Column(
          children: [
            //get city list
            DropdownButton(
                items: _city.map(
                  (City map) {
                    return new DropdownMenuItem<String>(
                      value: map.name,
                      child: new Text(map.name,
                          style: new TextStyle(color: Colors.black)),
                    );
                  },
                ).toList(),
                onChanged: null),
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

  Future<DropdownMenuItem<dynamic>> _getCityList() async {
    var response = await http.get(widget._locationFileURL);
    //print(response.toString());
    var _jsonFile = json.decode(response.body);
    var _jsonObj = JsonDecoder().convert(_jsonFile);

    //print(_jsonFile['city'].toString());
    //return widget._jsonFile['city'];
    //_city = (_jsonFile).map<var>((item) => Region.fromJson(item)).toList();

    //for (var city in _jsonFile['city']) {}
    return _jsonFile['city']
        .map(
          (e) => DropdownMenuItem(
            child: Text(
              e['city'].toString(),
            ),
            value: e,
          ),
        )
        .toList();
  }
}
