import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class AppDialog {
  static void showToast(BuildContext context, {required String msg}) {
    final fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HexColor('#242424')),
        child: Text(
          msg,
          style: TextStyle(
              color: HexColor('#d8d8d8'), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
