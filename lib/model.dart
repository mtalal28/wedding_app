
import 'package:flutter/material.dart';
import 'cart.dart';
import 'firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Model extends StatefulWidget {
  const Model({Key? key}) : super(key: key);
  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  final FirebaseService _firebaseService = FirebaseService();
  List<Map<String, dynamic>> basicPackages = [];
  Map<String, dynamic>? selectedItem;
  // List<Map<String, dynamic>> basicPackages = [];


  @override
  void initState() {
    super.initState();
    loadBasicPackages();
  }

  Future<void> loadBasicPackages() async {
    Set<String> packageSet = (await _firebaseService.getBasicPackages()).cast<String>().toSet();


    // Convert the set to a list of maps (adjust this conversion based on your actual data structure)
    List<Map<String, dynamic>> packages = packageSet.map((item) => {'id': item, 'name': 'SomeName', 'price': 0.0}).toList();

    setState(() {
      basicPackages = packages;
    });
  }



  List<Map<String, dynamic>> selectedBasicPackages = [];

  // Function to add item to the selected items list
  void addToSelectedItems(String name, double price) {
    setState(() {
      selectedBasicPackages.add({
        'name': name,
        'price': price,
      });
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                const Color(0xFF8D5765), // Change this to your desired color
            hintColor: const Color(0xFF8D5765),
            colorScheme: const ColorScheme.light(primary: Color(0xFF8D5765)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                const Color(0xFF8D5765), // Change this to your desired color
            hintColor: const Color(0xFF8D5765),
            colorScheme: const ColorScheme.light(primary: Color(0xFF8D5765)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void handlePackageSelection(String id, bool selected) {
    setState(() {
      if (selected) {
        // Add the selected package to the list
        var selectedPackage = basicPackages.firstWhere(
              (package) => package['id'] == id,
          orElse: () => <String, dynamic>{}, // Return an empty map if not found
        );
        if (selectedPackage is Map<String, dynamic>) {
          selectedBasicPackages.add(selectedPackage);
        }
      } else {
        // Remove the selected package from the list
        selectedBasicPackages.removeWhere((package) => package['id'] == id);
      }
    });
  }




  // Function to add selected basic packages to the cart

  Future<void> _addToCart({Map<String, dynamic>? selectedItem}) async {
    try {
      if (selectedItem == null || selectedItem.isEmpty) {
        print('Error in _addToCart: selectedItem is null or empty.');
        return;
      }

      String? category = selectedItem['category'] as String?;
      String? id = selectedItem['id'] as String?;
      String? name = selectedItem['name'] as String?;
      double? price = (selectedItem['price'] as num?)?.toDouble();

      if (category == null || id == null || name == null || price == null) {
        print('Error in _addToCart: Invalid or missing fields in selectedItem.');
        return;
      }

      // CartItem newItem = CartItem(
      //   id: id,
      //   category: category,
      //   name: name,
      //   price: price,
      // );

      setState(() {
        this.selectedItem = selectedItem;
      });

      // Add selected item to the cart
      await FirebaseFirestore.instance
          .collection('user_carts')
          .doc('user_id') // Replace 'user_id' with the actual user ID
          .collection('cart_items')
          .add({
        'category': 'some_category',
        'id': selectedItem, // Use the selected item ID here
        'name': 'some_name',
        'price': 0.0,
      });

      print('Added to cart successfully: $selectedItem');
    } catch (error) {
      print('Error in _addToCart: $error');
      // Handle error as needed
    }
  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F0F0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child:
                AdvancedSearchBar(selectedBasicPackages: selectedBasicPackages),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content vertically
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SmallBox(
                        image: 'assets/venue.png',
                        onPressed: () {
                          Navigator.pushNamed(context, '/venue');
                        },
                        isOnModelPage: false,
                      ),


                      SmallBox(
                        image: 'assets/food.png',
                        onPressed: () {
                          Navigator.pushNamed(context, 'food');
                        },
                        isOnModelPage: false,
                      ),
                      SmallBox(
                        image: 'assets/model.png',
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'model');
                        },
                        isOnModelPage: true,
                      ),
                      SmallBox(
                        image: 'assets/gallery.png',
                        onPressed: () {
                          Navigator.pushNamed(context, '/gallery');
                        },
                        isOnModelPage: false,
                      ),
                      SmallBox(
                        image: 'assets/bill.png',
                        onPressed: () {
                          Navigator.pushNamed(context, '/bill');
                        },
                        isOnModelPage: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 100),
                        child: Text(
                          'Beauty Specialist',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileBox(
                        image: 'assets/1.png',
                        name: 'John Doe',
                        specialty: 'Makeup Artist',
                        rating: 4.5,
                      ),
                      ProfileBox(
                        image: 'assets/2.png',
                        name: 'Jane Smith',
                        specialty: 'Hairstylist',
                        rating: 5.0,
                      ),
                      ProfileBox(
                        image: 'assets/3.png',
                        name: 'Alice Johnson',
                        specialty: 'Nail Technician',
                        rating: 4.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 130),
                        child: Text(
                          'Basic Package',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              PackageColumn(
                                id: 'nails',
                                image: 'assets/nails.png',
                                basicPackages: basicPackages, // Pass the basicPackages list
                                onSelected: handlePackageSelection,
                                callAddToCart: _addToCart,
                              ),
                              SizedBox(height: 15),
                              PackageColumn(
                                id: 'hair',
                                image: 'assets/hair.png',
                                basicPackages: basicPackages, // Pass the basicPackages list
                                onSelected: handlePackageSelection,
                                callAddToCart: _addToCart,
                              ),
                              SizedBox(height: 15),
                              PackageColumn(
                                id: 'eyes',
                                image: 'assets/eye.png',
                                basicPackages: basicPackages, // Pass the basicPackages list
                                onSelected: handlePackageSelection,
                                callAddToCart: _addToCart,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height:
                                30), // Move it here or wrap it with another widget
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 260),
                              child: Text(
                                'Date & Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      readOnly: true,
                                      onTap: () => _selectDate(context),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF8D5765),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Select Date',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFF8D5765)),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors
                                                  .black), // Default border color
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(
                                                  0xFF8D5765)), // Focused border color
                                        ),
                                        // prefixIcon: const SizedBox(width: 1),
                                        // suffixIcon: const SizedBox(width: 1),
                                      ),
                                      controller: TextEditingController(
                                        text: '${selectedDate.toLocal()}'
                                            .split(' ')[0],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: TextFormField(
                                      readOnly: true,
                                      onTap: () => _selectTime(context),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF8D5765),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Select Time',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFF8D5765)),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors
                                                  .black), // Default border color
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(
                                                  0xFF8D5765)), // Focused border color
                                        ),
                                        prefixIcon: const SizedBox(width: 15),
                                        suffixIcon: const SizedBox(width: 15),
                                      ),
                                      controller: TextEditingController(
                                        text:
                                            '${selectedDate.toLocal().hour}:${selectedDate.toLocal().minute}',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                            height:
                                10), // Add some space between Date & Time input and Add to Cart button
                        Container(
                          width: 300,
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.only(bottom: 2),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              _addToCart(selectedItem: selectedItem);
                            },
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(

                                color: Color(0xFF8D5765),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Color(0xFF8D5765),
                            textColor: Colors.white,
                            child: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class LocalJsonService {
//   Future<Map<String, dynamic>?> fetchCartFromLocalJson(String userId) async {
//     try {
//       String jsonString = await rootBundle.loadString('assets/app.json');
//       Map<String, dynamic> userData = jsonDecode(jsonString)['users'][userId];
//       Map<String, dynamic>? cartData = userData?['cart'];
//
//       return cartData;
//     } catch (error) {
//       print('Error fetching data from local JSON: $error');
//       return null;
//     }
//   }
// }


class CartItem {
  final String id; // Add this line
  final String category;
  final String name;
  final double price;

  CartItem({
    required this.id, // Add this line
    required this.category,
    required this.name,
    required this.price,
  });


}


class AdvancedSearchBar extends StatelessWidget {
  final List<Map<String, dynamic>> selectedBasicPackages;

  AdvancedSearchBar({Key? key, required this.selectedBasicPackages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF8D5765)),
                    suffixIcon: IconButton(
                      icon:
                          const Icon(Icons.mic_sharp, color: Color(0xFF8D5765)),
                      onPressed: () {
                        // Handle search button press
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  cursorColor: const Color(0xFF8D5765),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(
                  icon:
                      const Icon(Icons.shopping_cart, color: Color(0xFF8D5765)),
                  onPressed: () {
                    // Navigate to the cart screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CartScreen(selectedItems: selectedBasicPackages),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SmallBox extends StatefulWidget {
  const SmallBox({Key? key, required this.image, required this.onPressed, required this.isOnModelPage})
      : super(key: key);

  final String image;
  final VoidCallback onPressed;
  final bool isOnModelPage; // Add a variable to track whether the user is on the Model page

  @override
  _SmallBoxState createState() => _SmallBoxState();
}

class _SmallBoxState extends State<SmallBox> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
        widget.onPressed(); // Call the onPressed callback when the box is clicked
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: widget.isOnModelPage
              ? Color(0xFF8D5765).withOpacity(isClicked ? 0.8 : 1.0) // Change the background color when on Model page
              : const Color(0xFFF9F0F0).withOpacity(isClicked ? 0.8 : 1.0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.transparent,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            widget.image,
            width: 25, // Set the width of the image
            height: 25, // Set the height of the image
            color: widget.isOnModelPage ? const Color(0xFFF9F0F0) : null,
          ),
        ),
      ),
    );
  }
}




class ProfileBox extends StatelessWidget {
  final String image;
  final String name;
  final String specialty;
  final double rating;

  const ProfileBox({
    Key? key,
    required this.image,
    required this.name,
    required this.specialty,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F0F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.transparent,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 80,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            specialty,
            style: const TextStyle(fontSize: 10, color: Color(0xFF8D5765)),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ),
              Text(
                rating.toString(),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PackageColumn extends StatefulWidget {
  final String id;
  final String image;
  final bool selected;
  final Function(String, bool) onSelected;
  final VoidCallback callAddToCart;
  final List<Map<String, dynamic>> basicPackages; // Remove the duplicated declaration

  const PackageColumn({
    Key? key,
    required this.id,
    required this.image,
    this.selected = false,
    required this.onSelected,
    required this.callAddToCart,
    required this.basicPackages, // Keep only one declaration
  }) : super(key: key);

  @override
  _PackageColumnState createState() => _PackageColumnState(basicPackages: basicPackages);
}

class _PackageColumnState extends State<PackageColumn> {
  final List<Map<String, dynamic>> basicPackages;

  _PackageColumnState({required this.basicPackages});

  bool selected = false;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  // void _callAddToCart() {
  //   if (selected) {
  //     _ModelState modelState = context.findAncestorStateOfType<_ModelState>()!;
  //     var selectedPackage = basicPackages.firstWhere(
  //           (package) => package['id'] == widget.id,
  //         //if<String, addtoselectedpackage >
  //       orElse: () => <String, Object>{},// Return an empty map if not found
  //     );
  //
  //     if (selectedPackage.isNotEmpty) {
  //       modelState.selectedBasicPackages.add(selectedPackage);
  //     }
  //   }
  // }


  // void _callAddToCart() {
  //   if (selected) {
  //     _ModelState modelState = context.findAncestorStateOfType<_ModelState>()!;
  //     var selectedPackage = basicPackages.firstWhere(
  //           (package) => package['id'] == widget.id,
  //       orElse: () => <String, Object>{}, // Return an empty map if not found
  //     );
  //
  //     if (selectedPackage.isNotEmpty) {
  //       modelState.selectedBasicPackages.add(selectedPackage);
  //       modelState.addToSelectedItems(
  //         selectedPackage['name'] as String,
  //         (selectedPackage['price'] as num).toDouble(),
  //       );
  //     }
  //   }
  // }

  void _callAddToCart() {
    if (selected) {
      _ModelState modelState = context.findAncestorStateOfType<_ModelState>()!;
      var selectedPackage = basicPackages.firstWhere(
            (package) => package['id'] == widget.id,
        orElse: () => <String, Object>{}, // Return an empty map if not found

      );

      if (selectedPackage.isNotEmpty) {
        modelState.selectedBasicPackages.add(selectedPackage);
        modelState.addToSelectedItems(
          selectedPackage['name'] as String,
          (selectedPackage['price'] as num).toDouble(),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
        widget.onSelected(widget.id, selected);
        _callAddToCart();
      },
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Colors.grey[300] : Colors.transparent,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Image
            SizedBox(
              width: 45,
              height: 45,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF8D5765),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    widget
                        .image, // Correctly access the image from the widget's properties
                    height: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            // Checkmark Icon (added)
            Visibility(
              visible: selected,
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 15),
            // Dotted Line
            Padding(
              padding: const EdgeInsets.only(right: 120),
              child: SizedBox(
                width: 1,
                height: 15,
                child:
                    CustomPaint(painter: DottedLinePainter(numberOfDots: 20)),
              ),
            ),
            const SizedBox(width: 15),
            // Price
            const Text(
              '\$50', // Replace with your actual price
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8D5765),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class DottedLinePainter extends CustomPainter {
  final int numberOfDots;

  DottedLinePainter({required this.numberOfDots});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    const double dotRadius = 1.5;
    const double gap = 4.0;

    for (int i = 0; i < numberOfDots; i++) {
      double x = i * (dotRadius * 2 + gap);
      canvas.drawCircle(
          Offset(x + dotRadius, size.height / 2), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Allow repainting
  }
}
