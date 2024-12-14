import 'package:flutter/material.dart';
import 'CartModel.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartModel cartModel = CartModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
      ),
      body: cartModel.cartItems.isEmpty
          ? Center(child: Text('Keranjang kosong'))
          : ListView.builder(
              itemCount: cartModel.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartModel.cartItems[index];
                return ListTile(
                  leading: Image.asset(product.image),
                  title: Text(product.name),
                  subtitle: Text(
                    product.price.toStringAsFixed(2),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        cartModel.removeFromCart(product);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
