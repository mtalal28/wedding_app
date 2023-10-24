import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart' show rootBundle;

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<List<Map<String, dynamic>>> fetchPackagesFromJson() async {
    try {
      String jsonString = await rootBundle.loadString('assets/app.json');
      List<Map<String, dynamic>> packages = [];

      final dynamic jsonData = json.decode(jsonString);
      if (jsonData != null && jsonData is List) {
        for (final item in jsonData) {
          if (item is Map<String, dynamic>) {
            packages.add(item);
          }
        }
      }

      return packages;
    } catch (error) {
      print('Error loading JSON: $error');
      return [];
    }
  }

  Future<Map<String, dynamic>?> fetchCartFromFirebase(String userId) async {
    try {
      DataSnapshot dataSnapshot = (await _database.child('users/$userId/cart').once()) as DataSnapshot;

      // Check if dataSnapshot.value is not null and is of type Map
      if (dataSnapshot.value != null && dataSnapshot.value is Map) {
        Map<String, dynamic> cartData = Map<String, dynamic>.from(dataSnapshot.value as Map);
        return cartData;
      }

      return null;
    } catch (error) {
      print('Error in fetchCartFromFirebase: $error');
      return null;
    }
  }



  Future<void> updateCartData(String userId, List<Map<String, dynamic>> updatedItems) async {
    try {
      await _database.child('users/$userId/cart').update({
        'items': updatedItems,
      });
    } catch (error) {
      print('Error in updateCartData: $error');
      // Handle error as needed
    }
  }

  Future<void> createCart(String userId, List<Map<String, dynamic>> cartItems) async {
    try {
      await _database.child('users/$userId/cart').set({
        'items': cartItems,
      });
    } catch (error) {
      print('Error in createCart: $error');
      // Handle error as needed
    }
  }

}
