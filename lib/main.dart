// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wedding_app/bill.dart';
import 'package:wedding_app/food.dart';
import 'package:wedding_app/gallery.dart';
import 'package:wedding_app/path_to_auth_service/auth_service.dart';
import 'package:wedding_app/register.dart';
import 'package:wedding_app/venue.dart';
import 'forget.dart';
import 'home2.dart';
import 'model.dart';
import 'homepage.dart';
import 'login.dart';









void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Create an instance of your AuthService
  AuthService _authService = AuthService();

  // Attempt auto-login
  // UserCredential? autoLoginResult = await _authService.tryAutoLogin();

  // Run the app
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'register': (context) => const MyRegister(),
        'login': (context)=> const MyLogin(),
        'forget': (context) => const MyForget(),
        '/home2': (context) =>  const MyHomePage(),
        'model': (context)=> const Model(),
        'food': (context) =>  const Food(),
        '/gallery': (context) =>  const Gallery(),
        '/venue': (context) =>  const Venue(),
        '/bill': (context) =>  const BillPage(),
      },

    );
  }
}