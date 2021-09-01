import 'package:flutter/material.dart';

class OZBusy extends StatelessWidget {
  bool busy = false;
  Widget child;

  OZBusy({
    required this.busy,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return busy
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : child;
  }
}