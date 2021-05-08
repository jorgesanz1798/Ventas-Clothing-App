import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tshirt extends StatelessWidget {
  /*final String id, image, title, description;
  int size;
  int price, stock;
  final Color color;
  bool favourite;

  //Constructor
  Tshirt.items(this.image, this.title, this.description, this.price, this.size,
      this.id, this.color, this.stock, this.favourite);
  */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("camisetas").snapshots(),
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
                    child: Image(
                      image: data['Image'],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
