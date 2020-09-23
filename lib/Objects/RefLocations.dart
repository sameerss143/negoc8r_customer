class City {
  String id;
  String name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      name: json["city"],
    );
  }
}

class Area {
  String id;
  String name;

  Area({this.id, this.name});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json["id"],
      name: json["name"],
    );
  }
}

class SubArea {
  String id;
  String name;

  SubArea({this.id, this.name});

  factory SubArea.fromJson(Map<String, dynamic> json) {
    return SubArea(
      id: json["id"],
      name: json["name"],
    );
  }
}
