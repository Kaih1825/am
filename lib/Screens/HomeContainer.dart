import 'package:aa_0718/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TicketsList.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  var screens = [const HomeScreen(), const TicketsList()];
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: screens[selected],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              icon: Text(
                "Events",
                style:
                    TextStyle(color: selected == 0 ? Colors.red : Colors.black),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Text(
                "Tickets",
                style:
                    TextStyle(color: selected == 1 ? Colors.red : Colors.black),
              ),
              label: "")
        ],
        onTap: (value) {
          selected = value;
          setState(() {});
        },
      ),
    );
  }
}
