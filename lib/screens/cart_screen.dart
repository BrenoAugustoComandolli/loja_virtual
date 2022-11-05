import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/screens/order_screen.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
import 'package:loja_virtual/widgets/cart_price.dart';
import 'package:loja_virtual/widgets/discount_card.dart';
import 'package:loja_virtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme
        .of(context)
        .primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Meu carrinho"),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  "$p ${p == 1 ? "ITEM" : "ITENS"}",
                  style: const TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    "Faça o login para adicionar produtos!",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primary,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            );
          } else if (model.products.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum produto no carrinho",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: [
                Column(
                  children: model.products.map((product) {
                    return CartTile(cartProduct: product);
                  }).toList(),
                ),
                const DiscountCard(),
                const ShipCard(),
                CartPrice(buy: () async {
                  String? orderId = await model.finishOrder();
                  if (orderId != null) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => OrderScreen(orderId: orderId))
                    );
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
