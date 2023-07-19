import 'dart:convert';

import 'package:aa_0718/Screens/EventDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var readed = List.empty(growable: true).obs;

class _HomeScreenState extends State<HomeScreen> {
  var selected = 0;
  var jsons = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncFun();
  }

  void asyncFun() async {
    var jsonText =
        await DefaultAssetBundle.of(context).loadString("res/events_data.json");
    jsons = jsonDecode(jsonText);
    var sp = await SharedPreferences.getInstance();
    List readedJson = jsonDecode(sp.getString("readed") ?? "[0,0,0,0]");
    for (int i = 0; i < readedJson.length; i++) {
      readed.add(readedJson[i]);
    }
    setState(() {});
  }

  void setRead(var id) async {
    readed[id] += 1;
    var newJson = jsonEncode(readed.value);
    var sp = await SharedPreferences.getInstance();
    sp.setString("readed", newJson);
    Get.to(EventDetails(
      info: jsons[id],
      readCount: readed[id],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Events List",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: Text(
                          "All",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: selected == 0 ? Colors.red : Colors.black),
                        ),
                        onTap: () {
                          selected = 0;
                          setState(() {});
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("/"),
                      ),
                      InkWell(
                        child: Text(
                          "Unread",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: selected == 1 ? Colors.red : Colors.black),
                        ),
                        onTap: () {
                          selected = 1;
                          setState(() {});
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("/"),
                      ),
                      InkWell(
                        child: Text(
                          "Read",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: selected == 2 ? Colors.red : Colors.black),
                        ),
                        onTap: () {
                          selected = 2;
                          setState(() {});
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jsons.length,
              itemBuilder: (BuildContext context, int index) {
                if (selected == 1 && readed[index] != 0) return Container();
                if (selected == 2 && readed[index] == 0) return Container();
                return Obx(() => InkWell(
                      onTap: () {
                        setRead(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.network(
                                jsons[index]["pics"][0],
                                loadingBuilder:
                                    (context, widget, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return widget;
                                  }
                                  return const CircularProgressIndicator(
                                    color: Colors.red,
                                  );
                                },
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(jsons[index]["title"]),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Text(
                                        jsons[index]["context"],
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      readed[index] != 0 ? "Read" : "Unread",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
