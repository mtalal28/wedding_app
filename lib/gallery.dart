import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
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
                        isOnGalleryPage: false,
                      ),


                      SmallBox(
                        image: 'assets/food.png',
                        onPressed: () {
                          Navigator.pushNamed(context, 'food');
                        },
                        isOnGalleryPage: false,
                      ),
                      SmallBox(
                        image: 'assets/model.png',
                        onPressed: () {
                          Navigator.pushNamed(context, 'model');
                        },
                        isOnGalleryPage: false,
                      ),
                      SmallBox(
                        image: 'assets/gallery.png',
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/gallery');
                        },
                        isOnGalleryPage: true,
                      ),
                      SmallBox(
                        image: 'assets/bill.png',
                        onPressed: () {
                          Navigator.pushNamed(context, '/bill');
                        },
                        isOnGalleryPage: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const BigBox(),
                  const AdditionalBox(),


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
  const SmallBox({Key? key, required this.image, required this.onPressed, required this.isOnGalleryPage})
      : super(key: key);

  final String image;
  final VoidCallback onPressed;
  final bool isOnGalleryPage; // Add a variable to track whether the user is on the Model page

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
          color: widget.isOnGalleryPage
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
            color: widget.isOnGalleryPage ? const Color(0xFFF9F0F0) : null,
          ),
        ),
      ),
    );
  }
}


class BigBox extends StatefulWidget {
  const BigBox({Key? key}) : super(key: key);

  @override
  _BigBoxState createState() => _BigBoxState();
}

class _BigBoxState extends State<BigBox> {
  int selectedPackageIndex = -1; // Initialize with -1 to represent no selection

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 340,  // Increased height to provide space at the bottom
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
            // Left side - 3 images in a column
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 19),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/c1.png',
                      height: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/c2.png',
                      height: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/c3.png',
                      height: 80,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            // Right side - Package no and text about photography
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPackageIndex = 1; // Update with the actual package index
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedPackageIndex == 1
                            ? Colors.grey.withOpacity(0.5) // Light grey when selected
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Package No: 1',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8D5765),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Six-hour session, 350 albums credits 5x7 print, Online Gallery, Pro Photo Editing, Online Proofing Extra Discs & Images',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPackageIndex = 2; // Update with the actual package index
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedPackageIndex == 2
                            ? Colors.grey.withOpacity(0.5) // Light grey when selected
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Package No: 2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8D5765),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Six-hour session, 350 albums credits 5x7 print, Online Gallery, Pro Photo Editing, Online Proofing Extra Discs & Images',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPackageIndex = 3; // Update with the actual package index
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedPackageIndex == 3
                            ? Colors.grey.withOpacity(0.5) // Light grey when selected
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Package No: 3',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8D5765),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Six-hour session, 350 albums credits 5x7 print, Online Gallery, Pro Photo Editing, Online Proofing Extra Discs & Images',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            // Left side - 3 images in a column
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/c1.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),


              ],
            ),
            const SizedBox(width: 20),
            // Right side - Text and Read More button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Our Teams',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8D5765),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem ipsum dolor sit amet, consecrate disciplining elite. Sed do usermod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Read More button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF8D5765),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Read More'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


