import 'package:busymed/models/product.dart';
import 'package:busymed/widgets/favorite_products.dart';
import 'package:busymed/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FavoriteProducts extends StatelessWidget {
  static const routeName = '/favorite';
  List<Product> _productList;
  @override
  Widget build(BuildContext context) {
    _productList = Provider.of<Products>(context, listen: true).product_list;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text('${_productList.length} Favorite product(s)', style: TextStyle( fontFamily: 'Quicksand', color: Colors.white),),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _productList.isEmpty ? Center(child: Text("No favorite products saved.", style: TextStyle(fontSize: 14, fontFamily: 'Quicksand', fontWeight: FontWeight.bold, color: Colors.black))) :
      GridView.count(crossAxisCount: 2, children:  List.generate(_productList.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: FavoriteItem(_productList[index]),
          ),
        );
      })),
    );
  }
}

