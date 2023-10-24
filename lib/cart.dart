import 'package:flutter/material.dart';
import 'dart:convert';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CartScreen({Key? key, this.selectedItems = const []}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}



class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartData();
  }

  Future<void> loadCartData() async {
    // Load JSON data from the asset
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString('assets/app.json');

    // Parse the JSON data
    List<Map<String, dynamic>> jsonDataList =
    List<Map<String, dynamic>>.from(jsonDecode(jsonData));

    setState(() {
      cartItems = jsonDataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF8D5765),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index]['name']),
            subtitle: Text('\$${cartItems[index]['price']}'),
          );
        },
      ),
    );
  }
}
