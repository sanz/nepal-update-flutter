import 'package:flutter/material.dart';
import 'package:nepalupdate/constants.dart';

class NoInternetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              color: Colors.grey,
              size: 60.0,
            ),
            SizedBox(height: 10.0),
            Text(
              "No Internet Connection",
              style: kDetailContent,
            )
          ],
        ),
      ),
    );
  }
}
