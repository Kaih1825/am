import 'package:aa_0718/Screens/TicketCreate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketsList extends StatefulWidget {
  const TicketsList({Key? key}) : super(key: key);

  @override
  State<TicketsList> createState() => _TicketsListState();
}

class _TicketsListState extends State<TicketsList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Tickets List",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => Get.to(const TicketCreate()),
                    child: Text("Create a new ticket")),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Opening Cermony Tickets",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
