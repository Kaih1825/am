import 'dart:async';

import 'package:flutter/material.dart';

class FlashPage extends StatefulWidget {
  const FlashPage({Key? key}) : super(key: key);

  @override
  State<FlashPage> createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // Get.off(() => const HomeContainer());
      Navigator.popAndPushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }
}
