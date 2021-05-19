import 'package:cloud_firestore/cloud_firestore.dart';

class TshirtService {
  List _productList = [];
  CollectionReference tshirts =
      FirebaseFirestore.instance.collection('camisetas');

  Future<dynamic> getTshirts() async {
    await tshirts.get().then(
          (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach(
            (doc) {
              _productList.add(doc.data());
            },
          ),
        );
  }
}
