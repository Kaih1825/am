import 'package:aa_0718/BigPicDialog.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  final Map<String, dynamic> info;
  final int readCount;

  const EventDetails({Key? key, required this.info, required this.readCount})
      : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Event Details",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Text(
                    widget.info["title"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text("View Counts: ${widget.readCount}"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BigPicDialog(
                                    pics: widget.info["pics"], index: 0);
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.network(widget.info["pics"][0]),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BigPicDialog(
                                    pics: widget.info["pics"], index: 1);
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.network(widget.info["pics"][1]),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BigPicDialog(
                                    pics: widget.info["pics"], index: 2);
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.network(
                              widget.info["pics"][2],
                              loadingBuilder: (context, child, loading) {
                                if (loading == null) return child;
                                return const CircularProgressIndicator();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(widget.info["context"]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
