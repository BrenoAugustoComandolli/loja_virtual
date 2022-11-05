import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("home").orderBy("pos").get(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  );
                }else{
                  return SliverToBoxAdapter(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      children: snapshot.data?.docs.map(
                         (doc) {
                           return StaggeredGridTile.count(
                             mainAxisCellCount: doc.get("x"),
                             crossAxisCellCount: doc.get("y"),
                             child: FadeInImage.memoryNetwork(
                               placeholder: kTransparentImage,
                               image: doc.get("image"),
                               fit: BoxFit.cover,
                             ),
                           );
                         }
                      ).toList() ?? [],
                    ),
                  );
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
