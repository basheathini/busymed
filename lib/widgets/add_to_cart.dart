import 'package:flutter/material.dart';
class AddToCart extends StatefulWidget {
  final String description;
  final Function function;
  final bool isActive;

  AddToCart({
    this.description, this.function, this.isActive
  });

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
        width: deviceSize.width,
        height: 55,
        child: ElevatedButton.icon(
            icon: Icon(Icons.shopping_cart_outlined, color: !widget.isActive ? Colors.black12 : Colors.white,),
            label: Text(
              widget.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'Quicksand', fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.bold, color: widget.isActive ? Colors.white : Colors.black26),
            ),
            onPressed: widget.isActive ? widget.function : () {}
        )
    );
  }
}

