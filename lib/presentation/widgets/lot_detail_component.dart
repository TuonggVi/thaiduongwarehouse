// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

class LotDetailComponent extends StatelessWidget {
  String itemId, lotid, numberPO, unit;
  double quantity, sublotSize;
  double width, height, radius, fontSize;
  bool enableEdit;
  String location;
  Color bgColor;
  Color fgColor;
  VoidCallback onPressed;
  LotDetailComponent(
      {super.key,
      this.itemId = '',
      required this.lotid,
      this.numberPO = '',
      required this.location,
      required this.enableEdit,
      required this.unit,
      required this.quantity,
      required this.sublotSize,
      this.width = 300,
      this.height = 125,
      this.radius = 10,
      this.bgColor = Constants.buttonColor,
      this.fgColor = Constants.tapButtonColor,
      this.fontSize = 16,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          width: width * SizeConfig.ratioWidth,
          height: height * SizeConfig.ratioHeight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(radius * SizeConfig.ratioWidth),
              ),
              shadowColor: Constants.mainColor,
              foregroundColor: Colors.black,
              backgroundColor: bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            onPressed: onPressed,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      "Số lô: $lotid",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize + 2 * SizeConfig.ratioFont,
                        color: Colors.black,
                      ),
                    ),
                    enableEdit == true
                        ? Icon(
                            Icons.edit,
                            size: fontSize * SizeConfig.ratioFont,
                          )
                        : const SizedBox(),
                  ],
                ),
                const Divider(
                  // indent: 50,
                  // endIndent: 50,
                  color: Colors.black,
                  thickness: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Mã sp: $itemId",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: fontSize * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Tên sp: $itemId",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: fontSize * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Tổng lượng: $quantity",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: fontSize * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Định mức: $sublotSize",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: fontSize * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Vị trí: $quantity",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: fontSize * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Text(
                    //     overflow: TextOverflow.ellipsis,
                    //     "Số PO: $numberPO",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: fontSize * SizeConfig.ratioFont,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
