import 'package:busymed/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../widgets/add_to_cart.dart';
import 'package:provider/provider.dart';


class DetailedProduct extends StatefulWidget {
  static const routeName = '/detailed';
  final Product product;
  DetailedProduct({this.product});

  @override
  _DetailedProductState createState() => _DetailedProductState();
}

class _DetailedProductState extends State<DetailedProduct> {
  List<Product> _productList, _cartProducts;
  var _isFavorite = false, cartAdded = false;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    _productList = Provider.of<Products>(context, listen: true).product_list;
    _cartProducts = Provider.of<Products>(context, listen: true).cart;
    _isFavorite = _productList.where((element) => element.id == widget.product.id).toList().length > 0 ? true : false;
    cartAdded = _cartProducts.where((element) => element.id == widget.product.id).toList().length > 0 ? true : false;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text('Product', style: TextStyle( fontFamily: 'Quicksand', color: Colors.white),),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false).favoriteProduct(widget.product);
              },
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: Colors.white,
                size: 25,
              )),
        ],
      ),
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Padding(
              padding: const EdgeInsets.only(top : 20.0),
              child: Container(
                height: deviceSize.height * 0.35,
                color: Colors.white,
                width: deviceSize.width,
                child: Hero(
                  tag: widget.product.id,
                  child: CachedNetworkImage(
                    imageUrl: '${widget.product.image}',
                    height: deviceSize.height * 0.35,
                    width: deviceSize.width,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text((widget.product.name), style: TextStyle(fontFamily: 'Anton', fontSize: 22),),
                  Text('by ${widget.product.brand.name}', style: TextStyle(fontFamily: 'Quicksand', fontSize: 14),),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(widget.product.description, style: TextStyle(fontFamily: 'Quicksand', fontSize: 14 ),
                  )

                  )],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddToCart(function: ( ) {
                    Provider.of<Products>(context, listen: false).cartProduct(widget.product);
                  }, isActive: !cartAdded, description: 'Add To Cart',),
                ],
              ),
            )
          ],
        ),

      ),
    ));
  }
}
