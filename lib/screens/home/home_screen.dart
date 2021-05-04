import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/ventas-clothing-app.appspot.com/o/Logo%20VC%20original.png?alt=media&token=f984d718-fd48-4049-ae57-29784da55269',
                scale: 10.0,
              ),
              Text(
                'Ventas \n\n Clothing',
                style: TextStyle(fontSize: 20, height: 0.5),
                textAlign: TextAlign.center,
              ),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.search, color: Colors.black))
            ],
          ),
        ],
      ),
    );
  }
}
