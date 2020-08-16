import 'package:flutter/material.dart';
import 'package:perpus/screens/home_screen.dart';
// import 'screens/selected_book_screen.dart';
import 'screens/checkout.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xFFFFAAA5),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      home: HomeScreen(),
      routes: {
        "/homeScreen":(_)=>new HomeScreen(),
        "/checkout":(_)=>new Checkout()
      },
    );
  }
}