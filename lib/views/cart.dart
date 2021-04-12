import 'package:busymed/models/product.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Product> _cartList;
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    _cartList = Provider.of<Products>(context, listen: true).cart;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Cart',
            style: TextStyle(fontFamily: 'Quicksand', color: Colors.white),
          ),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
        itemBuilder: (context, index) {
          Product product = _cartList[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 65,
              width: deviceSize.width,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(product.name),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                        onPressed: () {
                          Provider.of<Products>(context, listen: false).cartProduct(product).then((value) => {
                            Flushbar(
                              backgroundGradient: LinearGradient(colors: [Colors.green, Colors.green]),
                              backgroundColor: Colors.green,
                              messageText: Text(
                                'Product successfully removed from cart.',
                                style: TextStyle(fontFamily: 'Quicksand', color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 5),
                              flushbarStyle: FlushbarStyle.FLOATING,
                              borderRadius: 5,
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(15),
                              flushbarPosition: FlushbarPosition.BOTTOM,
                            ).show(context)
                          });
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                          size: 25,
                        )),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _cartList.length,));
  }
}
