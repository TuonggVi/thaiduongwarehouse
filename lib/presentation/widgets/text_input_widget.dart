// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

class TextInputWidget extends StatefulWidget {
  TextEditingController contentTextField;
  TextInputWidget({super.key, required this.contentTextField});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5 * SizeConfig.ratioHeight),
        alignment: Alignment.centerRight,
        width: 200 * SizeConfig.ratioWidth,
        height: 55 * SizeConfig.ratioHeight,
        //color: Colors.grey[200],
        child: TextField(
          onChanged: (value) => widget.contentTextField.text = value,
          enabled: true,
          
          //    readOnly: true,
          controller:widget.contentTextField,
         // textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20 * SizeConfig.ratioFont),
          // decoration: InputDecoration(
          //   contentPadding:
          //       EdgeInsets.symmetric(horizontal: 10 * SizeConfig.ratioHeight),
          //   border: OutlineInputBorder(
          //       borderSide: BorderSide(
          //           width: 1.0 * SizeConfig.ratioWidth, color: Colors.black)),
          //   focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //           width: 1.0 * SizeConfig.ratioWidth, color: Colors.black)),
          // ),
        ));
  }
}
