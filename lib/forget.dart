import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyForget extends StatefulWidget {
  const MyForget({Key? key}) : super(key: key);

  @override
  State<MyForget> createState() => _MyForgetState();
}

class _MyForgetState extends State<MyForget> {
  TextEditingController forgotPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F0F0),
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: const Color(0xFF8D5765), // Change app bar color here
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/plan.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your email to reset password',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: forgotPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF8D5765), // Border color when focused
                          ),
                        ),
                      ),
                      cursorColor: const Color(0xFF8D5765), // Text cursor color
                    ),

                    const SizedBox(height: 20),
                    if (isLoading)
                      const CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        var forgotEmail = forgotPasswordController.text.trim();

                        try {
                          setState(() {
                            isLoading = true;
                          });

                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: forgotEmail,
                          );

                          print('Email sent!');
                          Navigator.pushNamed(context, 'login');
                        } on FirebaseAuthException catch (e) {
                          print('Error $e');
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF8D5765),
                      ),
                      child: const Text('Reset Password'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
