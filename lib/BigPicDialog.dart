import 'dart:convert';

import 'package:flutter/material.dart';

class BigPicDialog extends StatefulWidget {
  final List pics;
  final int index;

  const BigPicDialog({Key? key, required this.pics, required this.index})
      : super(key: key);

  @override
  State<BigPicDialog> createState() => _BigPicDialogState();
}

class _BigPicDialogState extends State<BigPicDialog>
    with TickerProviderStateMixin {
  PageController? controller;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.index);
    base64Encode(utf8.encode("aaa"));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.pics.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                widget.pics[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
