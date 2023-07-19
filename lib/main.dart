import 'package:aa_0718/Screens/FlashPage.dart';
import 'package:aa_0718/Screens/HomeContainer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const HomeContainer(),
        },
        home: FlashPage());
  }
}
