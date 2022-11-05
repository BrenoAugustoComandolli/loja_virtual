import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({required this.snapshot, Key? key}) : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(
              snapshot.get("image"),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.get("title"),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                Text(
                  snapshot.get("address"),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  launchUrl(
                   Uri(
                     scheme: 'https',
                     host: 'www.google.com',
                     path:"/maps/search/?api=1&query=${snapshot.get("lat")},${snapshot.get("long")}"
                   ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  "Mapa",
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              ElevatedButton(
                onPressed: () {
                  launchUrl(
                    Uri(
                      scheme: 'tel',
                      path: snapshot.get("phone"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  "Ligar",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
