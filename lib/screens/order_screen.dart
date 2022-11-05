import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({required this.orderId, Key? key}) : super(key: key);

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pedido Realizado",
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),
            const Center(
              child: Text(
                "Pedido realizado com sucesso!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Center(
              child: Text(
                "Código do pedido: $orderId",
                style: const TextStyle(
                  fontSize: 16.0,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
