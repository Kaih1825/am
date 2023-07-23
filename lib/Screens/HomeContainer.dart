import 'package:aa_0718/Screens/HomeScreen.dart';
import 'package:aa_0718/Screens/Records.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_actions/quick_actions.dart';

import 'TicketsList.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  var screens = [const HomeScreen(), const TicketsList(), const Records()];
  var selected = 0;
  var quickActions = const QuickActions();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quickActions.setShortcutItems([
      const ShortcutItem(
          type: "records", localizedTitle: "Records", icon: "record"),
      const ShortcutItem(
          type: "Tickets", localizedTitle: "Tickets", icon: "ticket"),
      const ShortcutItem(
          type: "Events", localizedTitle: "Events", icon: "home"),
    ]);

    quickActions.initialize((type) {
      switch (type) {
        case "records":
          selected = 0;
          break;
        case "Tickets":
          selected = 1;
          break;
        case "Events":
          selected = 2;
          break;
      }
      setState(() {});
    });
  }

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
              label: ""),
          BottomNavigationBarItem(
              icon: Text(
                "Records",
                style:
                    TextStyle(color: selected == 2 ? Colors.red : Colors.black),
              ),
              label: ""),
        ],
        onTap: (value) {
          selected = value;
          setState(() {});
        },
      ),
    );
  }
}
