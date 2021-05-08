import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        margin: EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25, bottom: 25),
              height: 80.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Category(
                    imageLocation: 'assets/icons/camiseta.png',
                    imageCaption: 'T-shirt',
                  ),
                  Category(
                    imageLocation: 'assets/icons/chaqueta-con-bolsillos.png',
                    imageCaption: 'Sweatshirt',
                  ),
                  Category(
                    imageLocation: 'assets/icons/pantalon.png',
                    imageCaption: 'Troussers',
                  ),
                  Category(
                    imageLocation: 'assets/icons/pantalones-cortos.png',
                    imageCaption: 'Shorts',
                  ),
                  Category(
                    imageLocation: 'assets/icons/sueter-con-cremallera.png',
                    imageCaption: 'Jacket',
                  ),
                  Category(
                    imageLocation: 'assets/icons/gorra.png',
                    imageCaption: 'Accesories',
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("camisetas")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                print(documents);
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        documents[index].data as Map<String, dynamic>;
                    return Container(
                      child: Text(
                        data['Image'],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    ]);
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  Category({required this.imageLocation, required this.imageCaption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              imageLocation,
              width: 100.0,
              height: 60.0,
              color: Colors.blue.withOpacity(1.0),
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                imageCaption,
                style: TextStyle(
                  color: mainColor,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
