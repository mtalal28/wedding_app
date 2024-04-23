import 'package:flutter/material.dart';

class Venue extends StatefulWidget {
  const Venue({Key? key}) : super(key: key);

  @override
  State<Venue> createState() => _VenueState();
}

class _VenueState extends State<Venue> {

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
                          Navigator.popAndPushNamed(context, '/venue');
                        },
                        isOnVenuePage: true,
                      ),
                      SmallBox(
                        image: 'assets/food.png',
                        onPressed: () {
                          Navigator.pushNamed(context, 'food');
                        },
                        isOnVenuePage: false,
                      ),
                      SmallBox(
                        image: 'assets/model.png',
                        onPressed: () {
                          Navigator.pushNamed(context, 'model');
                        },
                        isOnVenuePage: false,
                      ),
                      SmallBox(
                        image: 'assets/gallery.png',
                        onPressed: () {
                          Navigator.pushNamed(context, '/gallery');
                        },
                        isOnVenuePage: false,
                      ),
                      SmallBox(
                        image: 'assets/bill.png',
                        onPressed: () {
                          Navigator.pushNamed(context, '/bill');
                        },
                        isOnVenuePage: false,
                      ),
                    ],
                  ),
                  const BigBox(),
                  AdditionalBox(),
                  SwipeSection(),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(bottom: 2),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        // Handle the Add to Cart button press
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
  const SmallBox({Key? key, required this.image, required this.onPressed, required this.isOnVenuePage})
      : super(key: key);

  final String image;
  final VoidCallback onPressed;
  final bool isOnVenuePage; // Add a variable to track whether the user is on the Model page

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
          color: widget.isOnVenuePage
              ? const Color(0xFF8D5765).withOpacity(isClicked ? 0.8 : 1.0) // Change the background color when on Model page
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
            color: widget.isOnVenuePage ? const Color(0xFFF9F0F0) : null,
          ),
        ),
      ),
    );
  }
}

class BigBox extends StatelessWidget {
  const BigBox();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            height: 247,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F0F0),
              borderRadius: BorderRadius.circular(15),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/c1.png',
                        width: 370,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // const SizedBox(height: 20), // Space between the new box and the additional box


        ],
      ),
    );
  }
}


class AdditionalBox extends StatelessWidget {
  const AdditionalBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F0F0),
          borderRadius: BorderRadius.circular(15),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image 1
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/outdoor.png',
                      height: 120, // Increase the height
                      width: 70,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add space between image and text
                const Text(
                  'Outdoor',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/Indoor.png',
                      height: 120, // Increase the height
                      width: 70,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add space between image and text
                const Text(
                  'Indoor',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/arcg.png',
                      height: 120, // Increase the height
                      width: 70,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add space between image and text
                const Text(
                  'Arch',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/safari.png',
                      height: 120, // Increase the height
                      width: 70,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add space between image and text
                const Text(
                  'Safari',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class SwipeSection extends StatelessWidget {
  const SwipeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Set the desired height
      child: PageView(
        controller: PageController(),
        children: const [
          SwipeItem(imagePath: 'assets/c1.png'),
          SwipeItem(imagePath: 'assets/c2.png'),
          SwipeItem(imagePath: 'assets/c3.png'),
          // Add more SwipeItem widgets as needed
        ],
      ),
    );
  }
}

class SwipeItem extends StatelessWidget {
  final String imagePath;

  const SwipeItem({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          width: 300,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}