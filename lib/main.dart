import 'package:busymed/constants/api.dart';
import 'package:busymed/models/product.dart';
import 'package:busymed/views/cart.dart';
import 'package:busymed/views/detailed_product.dart';
import 'package:busymed/views/favorite_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/product_card.dart';

void main() {
  runApp(Busymed());
}

class Busymed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products([], [])),
        ChangeNotifierProxyProvider<Products, Products>(
          update: (ctx, auth, products) => Products([], []),
        ),
      ],

      child: Consumer<Products>(
        builder: (context, products, _) => MaterialApp(
          title: 'Busymed',
          theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.white,
            fontFamily: 'OpenSans',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(title: 'Products'),
          routes: {
            Cart.routeName: (context) => Cart(),
            DetailedProduct.routeName: (context) => DetailedProduct(),
            FavoriteProducts.routeName: (context) => FavoriteProducts()
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Product>> products;
  Api _api = new Api();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = _api.fetchTop20Products();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Column(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push( context, MaterialPageRoute( builder: (context) => FavoriteProducts()));
                },
                icon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).accentColor,
                  size: 25,
                )),
          ],
        ),

        actions: [
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push( context, MaterialPageRoute( builder: (context) => Cart()));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).accentColor,
                    size: 25,
                  )),
            ],
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Product product = snapshot.data[index];
                    return ProductCard(product);
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator(
                backgroundColor: Colors.deepPurple, strokeWidth: 3.5);
          },
        ),
      ),
    );
  }
}
