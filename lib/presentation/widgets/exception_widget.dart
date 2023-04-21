// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

class ExceptionErrorState extends StatelessWidget {
  String title;
  ///Nếu không có message, thì phải gán message = ""
  String message;
  IconData icon;
  double height;
  double width;
  double distanceTextImage;
  ExceptionErrorState(
      {super.key, this.title = "Đây là title báo lỗi",
      this.message = "Đây là message báo lỗi",
      this.icon = Icons.search_off_outlined,
      this.height = 300,
      this.width = 300,
      this.distanceTextImage = 30});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height * SizeConfig.ratioHeight,
      width: width * SizeConfig.ratioWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(icon,size: 150 * SizeConfig.ratioFont,),
         
          SizedBox(
            height: distanceTextImage * SizeConfig.ratioHeight,
          ),
            title == ""
              ? const SizedBox(
                  height: 1,
                )
              : FittedBox(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioHeight,
                        height: 1.5 *
                            SizeConfig
                                .ratioHeight), //do ko cho null dc nen cho fontSize nho xiu
                    textAlign: TextAlign.center,
                  ),
                ),
          SizedBox(
            height: 15 * SizeConfig.ratioHeight,
          ),
          message == ""
              ? const SizedBox(
                  height: 1,
                )
              : FittedBox(
                  child: Text(
                    message,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioHeight,
                        height: 1.5 *
                            SizeConfig
                                .ratioHeight), //do ko cho null dc nen cho fontSize nho xiu
                    textAlign: TextAlign.center,
                  ),
                )
        ],
      ),
    );
  }
}