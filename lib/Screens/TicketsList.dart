import 'package:aa_0718/Screens/TicketCreate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../SqlMethod.dart';

class TicketsList extends StatefulWidget {
  const TicketsList({Key? key}) : super(key: key);

  @override
  State<TicketsList> createState() => _TicketsListState();
}

var closingTickets = List.empty().obs;
var openingTickets = List.empty().obs;

class _TicketsListState extends State<TicketsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSql();
  }

  void getSql() async {
    closingTickets.value = List.from(await Ticket().closing());
    openingTickets.value = List.from(await Ticket().opening());
  }

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
                    onPressed: () => Get.to(
                          const TicketCreate(),
                        ),
                    child: const Text("Create a new ticket")),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Opening Ceremony Tickets",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Obx(
                  () => ReorderableListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: openingTickets.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        key: UniqueKey(),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Dismissible(
                          onDismissed: (dismiss) {
                            Ticket().remove(openingTickets[index]["id"]);
                          },
                          key: UniqueKey(),
                          child: Card(
                            color: Colors.grey.shade200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 10),
                                  child: Text(
                                    openingTickets[index]["name"],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, bottom: 5, right: 10),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      openingTickets[index]["seat"],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onReorder: (int oldIndex, int newIndex) {},
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Closing Ceremony Tickets",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Obx(() => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: closingTickets.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Dismissible(
                            onDismissed: (_) {
                              Ticket().remove(closingTickets[index]["id"]);
                            },
                            key: UniqueKey(),
                            child: Card(
                              color: Colors.grey.shade200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5, left: 10),
                                    child: Text(
                                      closingTickets[index]["name"],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, bottom: 5, right: 10),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        closingTickets[index]["seat"],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
