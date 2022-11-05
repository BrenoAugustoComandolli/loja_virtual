import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser!.uid;
      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("orders")
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs
                  .map((doc) => OrderTile(orderId: doc.id))
                  .toList()
                  .reversed
                  .toList(),
            );
          }
        },
      );
    }
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.view_list,
            size: 80.0,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            "Faça o login para acompanhar!",
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
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
  }
}
