import 'package:flutter/cupertino.dart';

class Brand {
  int id;
  String name;
  String image;

  Brand ({ @required this.id, @required this.name, @required this.image});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return new Brand(
        id: json['id'],
        image: json['image'],
        name: json['name']
    );
  }
}