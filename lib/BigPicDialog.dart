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
      child: SizedBox(
        height: 500 * 180 / 320 - 50,
        width: 500,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: PageView(
            controller: controller,
            children: [
              Image.network(
                widget.pics[0],
                key: key,
              ),
              Image.network(widget.pics[1]),
              Image.network(widget.pics[2])
            ],
          ),
        ),
      ),
    );
  }
}
