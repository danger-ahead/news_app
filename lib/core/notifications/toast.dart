import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/constants/size.dart';

class ShowToast {
  static void error(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 102, 16, 10),
        textColor: Colors.white,
        fontSize: largeText);
  }
}
