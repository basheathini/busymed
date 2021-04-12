import 'package:busymed/constants/api.dart';
import 'package:flutter/material.dart';
import 'brand.dart';

class Product {
  int id;
  DateTime created_at;
  DateTime updated_at;
  DateTime deleted_at;
  String name;
  String description;
  String product_type;
  String dosage;
  String quantity;
  String gender;
  String image;
  String schedule_req; //data type to be confirmed
  String active; //data type to be confirmed
  String category_id;
  String subcategory_id;
  String subsubcategory_id;
  String oldid;
  String brand_id;
  String unit_id;
  Brand brand;


  Product ({ @required this.id, @required this.name, @required this.image,  @required this.brand, @required this.product_type, @required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        id: json['id'],
        brand: Brand.fromJson(json['brand']),
        image: json['image_url'],
        name: json['name'],
        product_type: json['product_type'],
        description: json['description']
    );
  }

  toJson() {
    return {
      "id": id,
      "brand": brand,
      "image_url": image,
      "name": name,
      "product_type": product_type,
      "description": description
    };
  }
}

class Products with ChangeNotifier {
  List<Product> product_list;
  List<Product> cart;

  Products(this.product_list, this.cart);

  List<Product> get products {
    return product_list;
  }

  List<Product> get cartProducts {
    return cart;
  }

  Future<void> cartProduct(Product product) async {
    cart.contains(product) ? cart.removeWhere((element) => element.id == product.id) : cart.add(product);
    notifyListeners();
  }

  Future<void> favoriteProduct(Product product) async {
    product_list.contains(product) ? product_list.removeWhere((element) => element.id == product.id) : product_list.add(product);
    notifyListeners();
  }
}