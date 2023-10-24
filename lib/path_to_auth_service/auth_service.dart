// // TODO Implement this library.



// TODO Implement this library.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print("Sign-In Error: $error");
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive']);

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = await GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      } else {
        print("Google Sign-In Cancelled");
        return null;
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
      return null;
    }
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> storeCredentials(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);
    } catch (error) {
      print('Error storing credentials: $error');
      // Handle error appropriately, such as showing a user-friendly message.
    }
  }

  Future<UserCredential?> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    if (storedEmail != null && storedPassword != null) {
      try {
        return await signInWithEmailAndPassword(storedEmail, storedPassword);
      } catch (error) {
        print("Auto Login Error: $error");
        return null;
      }
    }

    return null;
  }

  Future<UserCredential?> signInWithCredential(AuthCredential credential) async {
    try {
      return await _auth.signInWithCredential(credential);
    } catch (error) {
      print("Sign-In with Credential Error: $error");
      return null;
    }
  }

}
















// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//
//
//   Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } catch (error) {
//       print("Sign-In Error: $error");
//       return null;
//     }
//   }
//
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive']);
//
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//
//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//
//         return await _auth.signInWithCredential(credential);
//       } else {
//         print("Google Sign-In Cancelled");
//         return null;
//       }
//     } catch (error) {
//       print("Google Sign-In Error: $error");
//       return null;
//     }
//   }
//
//   User? get currentUser => _auth.currentUser;
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
//
//
//
//
//
