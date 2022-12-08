import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool?> displayDialogOKCallBack(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('ok', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop(true);
                // true here means you clicked ok
              },
            ),
          ],
        );
      },
    );
  }

  static Future<String?> displayConfirmationDialogCallBack(
      BuildContext context, String title, String message) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('ok', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop('ok');
                // true here means you clicked ok
              },
            ),
            TextButton(
              child: const Text('cancel', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop('cancel');
                // true here means you clicked ok
              },),
          ],
        );
      },
    );
  }
}
