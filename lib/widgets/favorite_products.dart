import 'package:busymed/models/product.dart';
import 'package:busymed/views/detailed_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FavoriteItem extends StatefulWidget {

  final Product product;
  FavoriteItem(this.product);

  @override
  _FavoriteItemState createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 200,
        child: InkWell(
          splashColor: Colors.deepPurple,
          child: GridTile(
            child: GestureDetector(
              onTap: () async {
                Navigator.push( context, MaterialPageRoute( builder: (context) => DetailedProduct(product: widget.product)));
              },
              child: Hero(
                tag: widget.product.id,
                child: CachedNetworkImage(
                  imageUrl: widget.product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black26,
              title: Center(
                  child: Text(
                    widget.product.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Anton',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.9),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
