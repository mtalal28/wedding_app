import 'package:flutter/material.dart';


class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food
> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> selectedItems = [];


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
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F0F0),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: AdvancedSearchBar(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        isOnFoodPage: false,
                      ),


                      SmallBox(
                        image: 'assets/food.png',
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'food');
                        },
                        isOnFoodPage: true,
                      ),
                      SmallBox(
                        image: 'assets/model.png',
                        onPressed: () {
                          Navigator.pushNamed(context, 'model');
                        },
                        isOnFoodPage: false,
                      ),
                      SmallBox(
                        image: 'assets/gallery.png',
                        onPressed: () {
                          Navigator.pushNamed(context, '/gallery');
                        },
                        isOnFoodPage: false,
                      ),
                      SmallBox(
                        image: 'assets/bill.png',
                        onPressed: () {
                          Navigator.pushNamed(context, '/bill');
                        },
                        isOnFoodPage: false,
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
                          'Menu Categories',
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
                      FoodBox(
                        image: 'assets/app.png',
                      ),

                      FoodBox(
                        image: 'assets/ss.png',
                      ),

                      FoodBox(
                        image: 'assets/briyani.png',
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
                          'Popular Items',
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
                  // Add your popular items here
                ],
              ),
            ),
          ),

// Add your popular items here
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PopularItemBox(
                  image: 'assets/app.png',
                  name: 'appetizer',
                  rating: 4.5,
                ),
                PopularItemBox(
                  image: 'assets/briyani.png',
                  name: 'biryani',
                  rating: 5.0,
                ),
              ],
            ),
          ),

              const Padding(
                padding: EdgeInsets.only(right: 200, bottom: 20),
                child: Text(
                  'Order Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                ),
              ),
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodPayment(name: 'Biryani', price: '\$20'),
                FoodPayment(name: 'Soup & Salad', price: '\$25'),
                FoodPayment(name: 'Appetizers', price: '\$25'),
                FoodPayment(name: 'Cake', price: '\$25'),
                // Add more FoodPayment widgets as needed
              ],
            ),
          ),



          const SizedBox(height: 10),
          Container(
            width: 300,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: 2),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {
                // Create a map representing the selected food item
                Map<String, dynamic> selectedItem = {
                  'name': 'Biryani', // Replace with the actual name of the item
                  'price': '\$20',   // Replace with the actual price of the item
                  // Add more details as needed
                };

                // Add the selected item to the list
                setState(() {
                  selectedItems.add(selectedItem);
                });
              },

              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color(0xFF8D5765),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xFF8D5765),
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
    );
  }
}
    class AdvancedSearchBar extends StatelessWidget {
  const AdvancedSearchBar({Key? key}) : super(key: key);

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
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF8D5765)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.mic_sharp, color: Color(0xFF8D5765)),
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
                  icon: const Icon(Icons.shopping_cart, color: Color(0xFF8D5765)),
                  onPressed: () {
                    // Handle cart button press
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
  const SmallBox({Key? key, required this.image, required this.onPressed, required this.isOnFoodPage})
      : super(key: key);

  final String image;
  final VoidCallback onPressed;
  final bool isOnFoodPage; // Add a variable to track whether the user is on the Model page

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
          color: widget.isOnFoodPage
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
            color: widget.isOnFoodPage ? const Color(0xFFF9F0F0) : null,
          ),
        ),
      ),
    );
  }
}

class FoodBox extends StatelessWidget {
  final String image;

  const FoodBox({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 100, // Adjust the height as needed
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class PopularItemBox extends StatelessWidget {
  final String image;
  final String name;
  final double rating;

  const PopularItemBox({
    Key? key,
    required this.image,
    required this.name,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 140,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left side - Image
          Container(
            width: 95,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Right side - Text, Line, Rating, and Price
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.black, // Add your desired line color
                      margin: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    Row(
                      children: [
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
                    const SizedBox(height: 5), // Add spacing between Rating and Price
                    const Text(
                      '\$12.99', // Replace with your actual price
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class FoodPayment extends StatelessWidget {
  final String name;
  final String price;

  const FoodPayment({
    Key? key,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
              name,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              price,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
  }
}









