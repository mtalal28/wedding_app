import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'home2.dart';h
import 'path_to_auth_service/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';



class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final AuthService _authService = AuthService();
  final bool _isGoogleSignInPopupOpen = false;
  bool _rememberMe = false;





  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Use Navigator to push the next page only if sign-in is successful
        await _authService.signInWithCredential(credential);
      } else {
        print("Google Sign-In Cancelled");
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }





  Future<UserCredential?> signInWithFacebook() async {
    try {

      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken.token);


        print('Access Token: ${accessToken.token}');


        await FacebookAuth.instance.logOut();

        return await FirebaseAuth.instance.signInWithCredential(
          facebookAuthCredential,
        );
      } else {
        print("Facebook Sign-In Cancelled");
        return null; // Return null in case of cancellation
      }
    } catch (error) {
      print("Facebook Sign-In Error: $error");
      return null; // Return null in case of an error
    }
  }




  String _email = '';
  String _password = '';

  // Function to handle the login button press
  void _login() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      try {
        // Use _authService to handle login logic
        UserCredential? userCredential = await _authService.signInWithEmailAndPassword(_email, _password);

        if (userCredential != null && userCredential.user != null) {
          if (_rememberMe) {
            // Save credentials if "Remember Me" is selected
            _authService.storeCredentials(_email, _password);
          }
          Navigator.pushNamed(context, '/home2');
        } else {
          // Authentication failed, show an error message.
          if (kDebugMode) {
            print('Authentication failed');
          }
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content: const Text('Invalid email or password. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        // Handle other errors, e.g., network issues.
        print('Error during login: $error');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('An error occurred during login. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      if (kDebugMode) {
        print('Please enter valid email and password');
      }
    }
  }

  bool _exitDialogShown = false; // Add this flag at the beginning of your _MyLoginState class.

  Future<bool> _onWillPop() async {
    // Check if the Google sign-in popup is open
    bool isGoogleSignInInProgress = false;

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? account = await googleSignIn.signInSilently();
      isGoogleSignInInProgress = account != null;
    } catch (error) {
      if (kDebugMode) {
        print("Error checking Google sign-in status: $error");
      }
    }

    if (isGoogleSignInInProgress) {
      // Dismiss the Google sign-in popup
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      return false; // Prevent app from exiting
    }

    if (_exitDialogShown) {
      // If the exit confirmation dialog was already shown, allow navigation to happen.
      return true;
    }

    // Show exit confirmation modal
    bool? shouldPop = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevent tapping outside to dismiss
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            // Handle back button press inside the dialog
            Navigator.of(context).pop(false); // Close the dialog
            return false; // Prevent further navigation
          },
          child: AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit?'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF8D5765),  // Color of the button's text
                ),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Close the dialog with "Yes"
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF8D5765), // Color of the button's text
                ),
                child: const Text('yes'),
              ),
            ],
          ),
        );
      },
    );

    // Check the value of shouldPop to decide whether to exit
    if (shouldPop == true) {
      // Set the flag to true to allow navigation
      _exitDialogShown = true;
      Navigator.of(context).pop(true); // This will exit the app
    }

    // Return true to prevent further navigation when the dialog is dismissed.
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Intercept back button press
      child: GestureDetector(
        onTap: () {
          // Handle taps outside the popup here, if needed
          if (_isGoogleSignInPopupOpen) {
            // Do something to close the popup or provide feedback to the user
          }
        },
        // child: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/plan.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Scaffold(
            backgroundColor: const Color(0xFFF9F0F0),

            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 35, top: 150),
                    // Move "Sign in to continue" to the left
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Sign in to continue',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 33,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 60,
                      // Add spacing between "Sign in to continue" and the input fields
                      right: 35,
                      left: 35,
                    ),
                    child: Column(
                      children: [
                        // Move the "Email Address" label to the left
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Email Address',
                            // Add the text "Email Address" above the input box
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height:
                              10, // Add spacing between the text and the input box
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: 'Enter Email Address',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black, // Color when not focused
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF8D5765), // Color when focused
                              ),
                            ),
                          ),
                          cursorColor: const Color(0xFF8D5765),
                        ),


                        const SizedBox(
                          height:
                              50, // Add spacing between "Email Address" and "Password"
                        ),
                        // Move the "Password" label to the left
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Password',
                            // Add the text "Password" above the input box
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height:
                              10, // Add spacing between the text and the input box
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: 'Enter Password',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black, // Color when not focused
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF8D5765), // Color when focused
                              ),
                            ),
                          ),
                          cursorColor: const Color(0xFF8D5765),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 0,
                                top:
                                    0, // Move the checkbox and associated text up
                              ),
                              child: CustomCheckbox(
                                value: _rememberMe,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    _rememberMe = newValue;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 0),
                            // Add some spacing between the checkbox and "Remember Me"
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 12,
                                top: 02, // Move "Remember Me" up
                              ),
                              child: Text(
                                'Remember Me',
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            // Add a spacer to push the "Forget Password?" text to the right
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'forget');
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "If you don't have an Account ",
                              style: TextStyle(
                                fontSize: 17,
                                height: 0,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 17,
                                  height: 0,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF8D5765),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Add some spacing between the "Remember Me" row and the "Sign In" button
                        const SizedBox(height: 5),

                        Container(
                          width: 300,
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.only(bottom: 5),
                          // Move the "Sign In" button down
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                            _login();
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
                              "Sign In",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Center the "or" text horizontally
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                // Set the line color
                                thickness: 2.0,
                                // Set the line thickness
                                indent: 10.0,
                                // Set the line indent (space on the left)
                                endIndent:
                                    20.0, // Set the line end indent (space on the right)
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              // Adjust horizontal spacing
                              child: Text(
                                "or",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                // Set the line color
                                thickness: 2.0,
                                // Set the line thickness
                                indent: 10.0,
                                // Set the line indent (space on the left)
                                endIndent:
                                    20.0, // Set the line end indent (space on the right)
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Align the icons at the top
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                UserCredential? facebookUserCredential = await signInWithFacebook();
                                if (facebookUserCredential != null) {
                                  // Facebook login successful, navigate to the home screen
                                  Navigator.pushNamed(context, '/home2');
                                } else {
                                  // Handle the case where Facebook login failed or was cancelled
                                  if (kDebugMode) {
                                    print('Facebook login failed or cancelled');
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Image.asset(
                                  'assets/facebook.png', // You should have a Facebook icon image asset
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),


                            GestureDetector(
                              onTap: () async {
                                UserCredential? signInWithGoogle = await _authService.signInWithGoogle(context);
                                if (signInWithGoogle != null) {
                                  // Google login successful, navigate to the home screen
                                  Navigator.pushNamed(context, '/home2');
                                } else {
                                  // Handle the case where Google login failed or was cancelled
                                  if (kDebugMode) {
                                    print('Google login failed or cancelled');
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Image.asset(
                                  'assets/google.png',
                                  width: 30,
                                  height: 30,
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
          ),
        // ),
      ),
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;

  const CustomCheckbox({super.key, required this.value, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 17.0,
        height: 17.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.value ? const Color(0xFF8D5765) : const Color(0xFF8D5765),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(1),
        ),
        child: widget.value
            ? const Icon(
                Icons.check,
                size: 20.0,
                color: Color(0xFF8D5765),
              )
            : null,
      ),
    );
  }


}
