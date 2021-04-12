import 'package:busymed/models/product.dart';
import 'package:busymed/views/detailed_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  ProductCard(this.product);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<Product> _productList;
  var _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    _productList = Provider.of<Products>(context, listen: true).product_list;
    _isFavorite = _productList.where((element) => element.id == widget.product.id).toList().length > 0 ? true : false;
    return GestureDetector(
      onTap: () {
        Navigator.push( context, MaterialPageRoute( builder: (context) => DetailedProduct(product: widget.product)));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 2,
              child: Container(
                height: 100,
                width: deviceSize.width,
                child: productDetails(deviceSize, context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row productDetails(Size deviceSize, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120.0),
                child: CachedNetworkImage(
                  imageUrl: '${widget.product.image}',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: deviceSize.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        '${widget.product.name}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Quicksand'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Product type : ${widget.product.product_type}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 11,
                          fontFamily: 'Quicksand'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      '${widget.product.brand.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 11,
                          fontFamily: 'Quicksand'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false).favoriteProduct(widget.product);
              },
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: Theme.of(context).primaryColor,
                size: 25,
              )),
        )
      ],
    );
  }
}
