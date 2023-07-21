import 'package:aa_0718/Screens/TicketCreate.dart';
import 'package:aa_0718/Screens/TicketDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  var androidSetting = const AndroidInitializationSettings("Flutter");
  var localInitalization = InitializationSettings(android: androidSetting);

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
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        key: Key(openingTickets[index].toString()),
                        child: Dismissible(
                          onDismissed: (dismiss) async {
                            await Ticket().remove(openingTickets[index]["id"]);
                            setState(() {});
                          },
                          key: Key(openingTickets[index].toString()),
                          child: InkWell(
                            onTap: () {
                              Get.to(TicketDetails(
                                info: openingTickets[index],
                              ));
                            },
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
                        ),
                      );
                    },
                    onReorder: (int oldIndex, int newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      var element = openingTickets[oldIndex];
                      openingTickets.removeAt(oldIndex);
                      openingTickets.insert(newIndex, element);
                      Ticket().removeAll();
                      for (var i in openingTickets) {
                        Ticket().insert("Opening Ceremony", i["name"],
                            i["time"], i["seat"], i["image"]);
                      }
                      for (var i in closingTickets) {
                        Ticket().insert("Closing Ceremony", i["name"],
                            i["time"], i["seat"], i["image"]);
                      }
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Closing Ceremony Tickets",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Obx(() => ReorderableListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: closingTickets.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          key: Key(closingTickets[index].toString()),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Dismissible(
                            onDismissed: (_) {
                              Ticket().remove(closingTickets[index]["id"]);
                            },
                            key: Key(closingTickets[index].toString()),
                            child: InkWell(
                              onTap: () {
                                Get.to(TicketDetails(
                                  info: closingTickets[index],
                                ));
                              },
                              child: Card(
                                color: Colors.grey.shade200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10),
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
                          ),
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        var element = closingTickets[oldIndex];
                        closingTickets.removeAt(oldIndex);
                        closingTickets.insert(newIndex, element);
                        Ticket().removeAll();
                        for (var i in openingTickets) {
                          Ticket().insert("Opening Ceremony", i["name"],
                              i["time"], i["seat"], i["image"]);
                        }
                        for (var i in closingTickets) {
                          Ticket().insert("Closing Ceremony", i["name"],
                              i["time"], i["seat"], i["image"]);
                        }
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
