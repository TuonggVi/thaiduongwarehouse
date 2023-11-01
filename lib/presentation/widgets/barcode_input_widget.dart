// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

typedef StringToVoidFunc = void Function(String);

class BarcodeinputWidget extends StatefulWidget {
  String textController, textLabel;
  StringToVoidFunc onChange;
  StringToVoidFunc onScan;

  BarcodeinputWidget(
      {super.key,
      required this.textController,
      required this.textLabel,
      required this.onChange,
      required this.onScan});

  @override
  State<BarcodeinputWidget> createState() => _BarcodeinputWidgetState();
}

class _BarcodeinputWidgetState extends State<BarcodeinputWidget> {
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#e60000', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      widget.textController = barcodeScanRes;
      widget.onScan(barcodeScanRes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 350 * SizeConfig.ratioWidth,
        child: TextField(
          enabled: true,
          onChanged: widget.onChange,
          controller: TextEditingController(text: widget.textController),
          //readOnly: true,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            enabled: true,
            suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(end: 12.0),
                child: IconButton(
                    onPressed: () {
                      widget.textController = "-1";
                      scanQR();
                    },
                    icon: const Icon(Icons
                        .document_scanner_outlined)) // myIcon is a 48px-wide widget.
                ),
            // prefixIcon: Icon(Icons.search),
            // contentPadding: EdgeInsets.all(12.0),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.textLabel,
            // labelStyle: const TextStyle(
            //   fontWeight: FontWeight.bold,
            //   color: Colors.black,
            // ),
            hintText: "Nhập hoặc quét ${widget.textLabel} ",
            hintMaxLines: 2,
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Constants.buttonColor),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            //focusedBorder: kFocusedBorder,
          ),
        ),
      ),
    );
  }
}