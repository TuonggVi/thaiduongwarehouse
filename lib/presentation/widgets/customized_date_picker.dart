// ignore_for_file: avoid_print, must_be_immutable, library_private_types_in_public_api, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

class CustomizeDatePicker extends StatefulWidget {
  String name;
  Function okBtnClickedFunction;
  FontWeight fontWeight;
  Color fontColor;

  DateTime initDateTime;
  CustomizeDatePicker(
      {super.key, required this.name,
      required this.okBtnClickedFunction,
      required this.fontColor,
      required this.fontWeight,
      required this.initDateTime});
  @override
  _CustomizeDatePickerState createState() => _CustomizeDatePickerState();
}

class _CustomizeDatePickerState extends State<CustomizeDatePicker> {
  String reference = '';
  @override
  Widget build(BuildContext context) {
    Future<void> selectTimePicker(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: widget.initDateTime,
          firstDate: DateTime(1940),
          lastDate: DateTime(2030),
          builder: (context, Widget? child) {
            return Theme(
              data: ThemeData(
                  primaryColor: const Color(0xFFC41A3B), colorScheme: ColorScheme.fromSwatch(primarySwatch: Constants.materialMainColor).copyWith(secondary: const Color(0xFFC41A3B))),
              child: child!,
            );
          });
      if (picked != null && picked != widget.initDateTime) {
        setState(() {
          widget.initDateTime = picked;
          reference = picked.toString();
          print(widget.initDateTime.toString());
        });
      }
      if (widget.okBtnClickedFunction != null) {
        widget.okBtnClickedFunction(widget.initDateTime);
      }
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
           
            side: const BorderSide(
             width: 0.3
            ),
          ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // reference != widget.initDateTime.toString()
            //     ? Text(widget.name,
            //         style: TextStyle(
            //             fontSize: 16 * SizeConfig.ratioFont,
            //             color: widget.fontColor,
            //             fontWeight: widget.fontWeight))
            //     : 
                Text(DateFormat('dd/MM/yyyy').format(widget.initDateTime),
                    style: TextStyle(
                        fontSize: 16 * SizeConfig.ratioFont,
                        color: widget.fontColor,
                        fontWeight: widget.fontWeight)),
            SizedBox(
              width: 20 * SizeConfig.ratioWidth,
            ),
            Icon(
              Icons.date_range,
              color: Constants.mainColor,
              size: 20 * SizeConfig.ratioFont,
            )
          ],
        ),
      onPressed: () {
        selectTimePicker(context);
      },
    );
  }
}