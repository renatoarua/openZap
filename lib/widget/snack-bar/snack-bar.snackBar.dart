import 'package:flutter/material.dart';

class SnackBarAlert {
  static buildSnackBarAlert(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.yellow[300],
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 15,
        ),
      ),
      action: SnackBarAction(
        textColor: Colors.grey[800],
        label: 'X',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static buildSnackBarError(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red[300],
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 15,
        ),
      ),
      action: SnackBarAction(
        textColor: Colors.grey[800],
        label: 'X',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static buildSnackBarSuccefull(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green[300],
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 15,
        ),
      ),
      action: SnackBarAction(
        textColor: Colors.grey[800],
        label: 'X',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
