import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  var recoder = FlutterSoundRecorder();
  var player = FlutterSoundPlayer();
  var enable = false;
  var nowFile = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recoder.openRecorder();
    player.openPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recoder.closeRecorder();
    player.closePlayer();
  }

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
                    "Records",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade500, width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 100, top: 8, left: 8),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    alignment: Alignment.centerLeft),
                                onPressed: () async {
                                  if (await Permission.microphone.isDenied) {
                                    await Permission.microphone.request();
                                  } else {
                                    if (recoder.isStopped) {
                                      await recoder.startRecorder(
                                          toFile: "$nowFile.aac",
                                          codec: Codec.aacADTS);
                                      print("Start");
                                    } else if (recoder.isRecording) {
                                      await recoder.stopRecorder();
                                      enable = true;
                                      print("Stop");
                                    }
                                  }
                                  setState(() {});
                                },
                                child: Text(!recoder.isStopped
                                    ? "Record Stop"
                                    : "Voice Record")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 100, left: 8),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  alignment: Alignment.centerLeft),
                              onPressed: enable
                                  ? () async {
                                      await player.startPlayer(
                                          fromURI: "$nowFile.aac",
                                          codec: Codec.aacADTS);
                                    }
                                  : null,
                              child: const Text(
                                "Voice Play",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                                onPressed: enable
                                    ? () {
                                        nowFile++;
                                        enable = false;
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const Dialog(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 50),
                                                  child: Text(
                                                    "Submit Successfully",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              );
                                            });
                                        setState(() {});
                                      }
                                    : null,
                                child: const Text("Submit"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade500, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text("Audio List"),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: nowFile,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: InkWell(
                                      onTap: () async {
                                        await player.startPlayer(
                                            fromURI: "$index.aac",
                                            codec: Codec.aacADTS);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child:
                                            Text("audio${index + 1}        >"),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
