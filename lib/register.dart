import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final bool _isPasswordVisible = false;


  bool isEmailValid(String email) {
    String email = _emailTextController.text.toString().trim();
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  void _registerUser() {
    String emailBeforeTrimming = _emailTextController.text.toString();
    String email = emailBeforeTrimming.trim(); // Trim the email address

    print('Email before trimming: $emailBeforeTrimming');
    print('Email after trimming: $email');

    if (isEmailValid(email)) {
      _auth
          .createUserWithEmailAndPassword(email: email, password: _passwordTextController.text.toString())
          .then((value) {
        Navigator.pushNamed(context, 'login');
        print('User registered successfully');
      }).catchError((error) {
        // Print the error details for debugging purposes
        print('Error during registration: $error');

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Registration Failed'),
              content: const Text('An error occurred while registering. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    primary: const Color(0xFF8D5765), // Color of the button's text
                  ),
                  child: const Text('OK'),
                ),

              ],
            );
          },
        );
      });
    }  else {
      // Show a user-friendly message about the invalid email format
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Email Format'),
            content: const Text('Please enter a valid email address.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: const Color(0xFF8D5765), // Color of the button's text
                ),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F0F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // You can change this to the back icon you want
            color: Colors.black, // Change the color to black
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
        ),
      ),
      // backgroundColor: Colors.transparent,
      body: SingleChildScrollView( // Use a single SingleChildScrollView for the entire content
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0.5, top: 80),
              child: const Text(
                'Create Account',
                style: TextStyle(color: Colors.black, fontSize: 33,
                fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 90,
                right: 35,
                left: 35,
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF8D5765), // Color when focused
                        ),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    cursorColor: const Color(0xFF8D5765),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF8D5765), // Color when focused
                        ),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    cursorColor: const Color(0xFF8D5765),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _passwordTextController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF8D5765), // Color when focused
                        ),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    cursorColor: const Color(0xFF8D5765),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: const Color(0xFF8D5765),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: _registerUser, // Call the function to register the user
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'If you have an Account ',
                        style: TextStyle(
                          fontSize: 17,
                          height: 3,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 17,
                            height: 3,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF8D5765),
                          ),
                        ),
                      ),
                    ],
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
