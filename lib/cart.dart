import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CartScreen({Key? key, required this.selectedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF8D5765),
       ),
      body: ListView.builder(
        itemCount: selectedItems.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> selectedItem = selectedItems[index];
          return ListTile(
            title: Text(selectedItem['name'] as String),
            subtitle: Text('\$${selectedItem['price']}'),
          );
        },
      ),
    );
  }
}




// import 'package:flutter/material.dart';
//
// class CartScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> selectedItems;
//
//   const CartScreen({Key? key, this.selectedItems = const []}) : super(key: key);
//
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   List<Map<String, dynamic>> cartItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadCartData();
//   }
//
//   Future<void> loadCartData() async {
//     // Use widget.selectedItems instead of loading from the JSON file
//     setState(() {
//       cartItems = widget.selectedItems;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//         backgroundColor: const Color(0xFF8D5765),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(cartItems[index]['name']),
//             subtitle: Text('\$${cartItems[index]['price']}'),
//           );
//         },
//       ),
//     );
//   }
// }
