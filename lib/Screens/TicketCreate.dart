import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../SqlMethod.dart';

class TicketCreate extends StatefulWidget {
  const TicketCreate({Key? key}) : super(key: key);

  @override
  State<TicketCreate> createState() => _TicketCreateState();
}

class _TicketCreateState extends State<TicketCreate> {
  var eventValue = "Opening Ceremony";
  var controller = TextEditingController();
  var base64 = "";

  XFile? image;

  Future<XFile?> gatImage() async {
    var picker = ImagePicker();
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    var file = File(image!.path);
    var img = await decodeImageFromList(file.readAsBytesSync());
    print(img.width);
    print(img.height);
    if (img.width > 5000 || img.height > 5000) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image is too large.")));
      return null;
    }
    var byteArray = await file.readAsBytes();
    base64 = base64Encode(byteArray);

    return image!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 300) / 2,
            vertical: 20),
        child: SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: () async {
              if (base64.isNotEmpty && controller.text.isNotEmpty) {
                var time = DateTime.now();
                var formater = DateFormat("yyyy-MM-dd HH:MM");
                var ch = ["A", "B", "C"];
                var rd = Random();
                Ticket().insert(
                    eventValue,
                    controller.text,
                    formater.format(time),
                    "${ch[rd.nextInt(3)]}${rd.nextInt(10) + 1} Row${rd.nextInt(10) + 1} Column${rd.nextInt(10) + 1}",
                    base64);
                Get.back();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Plese fill in all boxes.")));
              }
            },
            child: const Text("Create"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Tickets Create",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: DropdownButton(
                      isExpanded: true,
                      value: eventValue,
                      items: const [
                        DropdownMenuItem(
                          value: "Opening Ceremony",
                          child: Text("Opening Ceremony"),
                        ),
                        DropdownMenuItem(
                          value: "Closing Ceremony",
                          child: Text("Closing Ceremony"),
                        ),
                      ],
                      onChanged: (value) {
                        eventValue = value.toString();
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Input your name",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () async {
                          var picker = ImagePicker();
                          image = await gatImage();
                          setState(() {});
                        },
                        child: const Text("Chose one picture")),
                  ),
                  image != null
                      ? Image.file(
                          File(image!.path),
                          width: 300,
                        )
                      : Container(),
                  // Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
