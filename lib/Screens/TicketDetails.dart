import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TicketDetails extends StatefulWidget {
  final info;
  const TicketDetails({Key? key, required this.info}) : super(key: key);

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  get info => widget.info;
  var key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Tickets Details",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ),
                Expanded(
                  child: RepaintBoundary(
                    key: key,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Image.memory(
                                  base64Decode(info["image"]),
                                  height: 200,
                                ),
                              ),
                              Text(
                                "Ticket type:${info["type"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                              Text(
                                "Audience's name : ${info["name"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                              Text(
                                "Time:${info["time"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                              Text(
                                "Seat:${info["seat"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        RenderRepaintBoundary boundary = key.currentContext!
                            .findRenderObject() as RenderRepaintBoundary;
                        var image = await boundary.toImage(pixelRatio: 2);
                        var data =
                            await image.toByteData(format: ImageByteFormat.png);
                        File("/storage/emulated/0/Download/${Random().nextInt(100000)}.png")
                            .writeAsBytes(data!.buffer.asUint8List(
                                data.offsetInBytes, data.lengthInBytes));
                      },
                      child: Text("Download"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
