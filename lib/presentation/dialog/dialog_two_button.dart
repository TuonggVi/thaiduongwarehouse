// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertDialogTwoBtnCustomized {
  BuildContext context;
  String title;
  String desc;
  String textBtn1;
  String textBtn2;
  //Color bgBtn1, bgBtn2, fgBtn1, fgBtn2;
  double titleFSize, descFSize;
  VoidCallback onPressedBtn1, onPressedBtn2;
  AlertDialogTwoBtnCustomized(
    this.context,
    this.title,
    this.desc,
    this.textBtn1,
    this.textBtn2,
    // this.bgBtn1 = Constants.mainColor,
    // this.bgBtn2 = Colors.transparent,
    // this.fgBtn1 = Colors.white,
    // this.fgBtn2 = Constants.mainColor,
    this.onPressedBtn1,
    this.onPressedBtn2,
   // this.closeFunction,
    //18
    this.descFSize,
    //22
    this.titleFSize,
  );
  void show() {
    Alert(
            context: context,
            content: Container(
              width: SizeConfig.screenWidth * 0.8,
            ),
            title: title,
            desc: desc,
            closeFunction: () {
              Navigator.of(context).pop();
            },
            buttons: [
              DialogButton(
                height: 45 * SizeConfig.ratioHeight,
                radius: BorderRadius.all(
                    Radius.circular(8 * SizeConfig.ratioRadius)),
                color: Constants.mainColor,
                child: Text(textBtn1,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                   if (onPressedBtn1 != null) {
                    onPressedBtn1();
                  }
                },
              ),
              DialogButton(
                color: Colors.transparent,
                child: Text(textBtn2,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont,
                        color: Constants.mainColor,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                   if (onPressedBtn2 != null) {
                    onPressedBtn2();
                  }
                },
              )
            ],
            style: AlertStyle(
                descStyle: TextStyle(
                    fontSize: descFSize * SizeConfig.ratioFont,
                    fontWeight: FontWeight.normal,
                    height: 1.5),
                titleStyle:
                    TextStyle(fontSize: titleFSize * SizeConfig.ratioFont)))
        .show();
  }
}