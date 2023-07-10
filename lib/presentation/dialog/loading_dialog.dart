import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoadingAlertDialog {
  BuildContext context;

  LoadingAlertDialog(
    this.context,
  );
  void show() {
    Alert(
     
      context: context,
      image: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The loading indicator
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            ),
            // Some text
            Text('Loading...')
          ],
        ),
      ),
    ).show();
  }
}
