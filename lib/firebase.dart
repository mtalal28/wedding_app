import 'dart:async';


import 'package:firebase_database/firebase_database.dart';


import 'model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseService {
  late DatabaseReference databaseReference;

  FirebaseService() {
    // Initialize database reference
    databaseReference = FirebaseDatabase.instance.reference();
  }

  final DatabaseReference _cartReference =

  FirebaseDatabase.instance.reference().child('carts');
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<List<Map<String, dynamic>>> getBasicPackages() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('model').get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> addToCart(List<CartItem> items, String userId) async {
    try {
      // Convert CartItem objects to a map
      Map<String, dynamic> itemsMap = {};
      items.forEach((item) {
        itemsMap[item.id] = {
          'category': item.category,
          'name': item.name,
          'price': item.price,
        };
      });

      // Add items to the user's cart in the database
      await _cartReference.child(userId).set(itemsMap);
    } catch (error) {
      print('Error in addToCart: $error');
      // Handle error as needed
    }
  }

}