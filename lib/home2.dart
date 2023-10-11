import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  Future<void> logout() async {
    final GoogleSignIn googleSign = GoogleSignIn();
    await googleSign.signOut();
  }



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image1; // First image variable
  File? _image2; // Second image variable
  Future<void> _getImage(int imageNumber) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // Use imageNumber to determine which image variable to update
        if (imageNumber == 1) {
          _image1 = File(pickedFile.path);
        } else {
          _image2 = File(pickedFile.path);
        }
      });
    }
  }


  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8D5765),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 40.0, // Adjusted to move icons up
              left: 10.0,
              right: 10.0,
              bottom: 50.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white, // Set the icon color to white
                    size: 30.0, // Increased icon size
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/home2');
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          height: 120,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF9F0F0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Container(

                                  decoration: const BoxDecoration(
                                  // Background color for the text

                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 150,
                                    ),
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                        color: Color(0xFF8D5765),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Implement logout logic here
                                  // For example, clear user session and navigate to login
                                  Navigator.pushReplacementNamed(context, 'login');
                                },
                              ),

                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Color(0xFFF9F0F0),

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20), // Add space from the top edge

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // First picture selection (circular)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 17, right: 6),
                            child: GestureDetector(
                              onTap: () => _getImage(1), // Call _getImage with imageNumber 1
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: _image1 != null
                                    ? ClipOval(
                                  child: Image.file(
                                    _image1!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : const Center(
                                  child: Icon(
                                    Icons.add_photo_alternate,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Second picture selection (circular)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12, left: 2),
                            child: GestureDetector(
                              onTap: () => _getImage(2), // Call _getImage with imageNumber 2
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: _image2 != null
                                    ? ClipOval(
                                       child: Image.file(
                                    _image2!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : const Center(
                                      child: Icon(
                                    Icons.add_photo_alternate,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    // Input boxes
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Wedding Theme',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              fillColor: const Color(0xFFCFD8DC),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Adjust padding as needed
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            cursorColor: const Color(0xFF8D5765),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Wedding Location',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              fillColor: const Color(0xFFCFD8DC),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Adjust padding as needed
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            cursorColor: const Color(0xFF8D5765),//0xff764056
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Wedding Date',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              fillColor: const Color(0xFFCFD8DC),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Adjust padding as needed
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            cursorColor: const Color(0xFF8D5765),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    // Range Slider
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          // Handle range slider selection here
                        },
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              // Align to the left
                              child: const Text(
                                'Set Wedding Budgets',
                                style: TextStyle(
                                  fontSize: 18,
                                  // Change text color
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFCFD8DC),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Adjust padding as needed
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              cursorColor: const Color(0xFF8D5765),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 300,
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.only(bottom: 2),
                              // Move the "Sign In" button down
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: () {
                                  Navigator.pushNamed(context, 'model');
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
                                  "Next",
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}




























// return Scaffold(
//   backgroundColor: const Color(0xFFF9F0F0),
//   appBar: AppBar(
//     automaticallyImplyLeading: false,
//     backgroundColor: const Color(0xFF764056),
//     flexibleSpace: ClipRRect(
//       borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(30),
//         bottomRight: Radius.circular(30),
//       ),
//       child: Container(
//         // Add any additional styling if needed
//       ),
//     ),
//     title: Row(
//       children: [
//         IconButton(
//           icon: const Icon(Icons.home),
//           onPressed: () {
//             Navigator.popAndPushNamed(context, '/home2');
//           },
//         ),
//       ],
//     ),
//     actions: [
//       IconButton(
//         icon: const Icon(Icons.menu),
//         onPressed: () {
//           _showBottomSheet(context);
//         },
//       ),
//     ],
//   ),
//
//
//
// body: const SingleChildScrollView(
//     child: Stack(
//       children: [
//
//         Center(
//           child: Text('Welcome to Wedding App!'),
//         ),
//       ],
//     ),
//   ),
// );
