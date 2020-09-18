import 'package:flutter/material.dart';

class LocationListItems extends StatelessWidget {
  const LocationListItems({Key key}) : super(key: key);
  // final String _city;
  // final String _area;
  // final String _subArea;

  final String listId = "City";

  @override
  Widget build(BuildContext context) {
    return new DropdownButtonFormField(
      items: getCities(),
      onChanged: null,
    );
  }

  //get list of cities
  List<DropdownMenuItem> getCities() {
    return ['Mumbai', 'Pune', 'Thane', 'Navi Mumbai']
        .map(
          (e) => DropdownMenuItem(
            child: Text(
              e.toString(),
            ),
            value: e,
          ),
        )
        .toList();
  }

  List<DropdownMenuItem> getAreasInCity(String selectedCity) {
    if (selectedCity == 'Mumbai') {
      return ['Ghatkopar', 'Mulund', 'Dadar', 'CST', 'Borivli']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (selectedCity == 'Navi Mumbai') {
      return ['Airoli', 'Vashi', 'Panvel']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (selectedCity == 'Thane') {
      return ['Thane', 'Dombivli', 'Kalyan', 'Diva']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (selectedCity == 'Pune') {
      return ['Shivaji Nagar', 'Katraj', 'Sangamwadi', 'Koregaon', 'Bibwewadi']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }

    //if no city selected
    return null;
  }

  //get Sub-area
  List<DropdownMenuItem> getSubAreas(String selectedArea) {
    if (selectedArea == 'Ghatkopar') {
      return ['Pantnagar', 'Garudia', 'Samta nagar', 'Bhatwadi']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (selectedArea == 'Airoli') {
      return ['Sector 5', 'Sector 20', 'Sector 10']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (selectedArea == 'Dombivli') {
      return ['Kopar', 'Nandivli', 'Ramnagar', 'Desale pada', 'Palava']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    if (selectedArea == 'Shivaji Nagar') {
      return ['Model Colony', 'Fergusson', 'Sakhar Sankul', 'Station']
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
              //key: Text(e.toString()
            ),
          )
          .toList();
    }
    return null;
  }
}
