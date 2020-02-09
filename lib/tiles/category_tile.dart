import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/screen/products_screen.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),),
      title: Text(snapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>ProductsScreen(snapshot))
        );
      },
    );
  }
}
