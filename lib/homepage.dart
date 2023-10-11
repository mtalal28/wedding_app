import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pic1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 540), // Add space above the buttons
            Container(
              width: 300,
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color:Color(0xFF8D5765),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color(0xFF8D5765),
                textColor: Colors.white,
                child: const Text(
                  "Log in",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
             // Add space between the buttons
            Container(
              width: 300,
              padding:  const EdgeInsets.all(16.0),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                textColor: Colors.black,
                child: const Text(
                  "Sign up",
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
    );
  }
}
