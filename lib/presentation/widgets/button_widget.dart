// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

class CustomizedButton extends StatelessWidget {
  String text;

  double width, height, radius, fontSize;
  Color bgColor;
  Color fgColor;
  VoidCallback onPressed;
  CustomizedButton(
      {super.key,
      this.text = "Tên nút",
      this.width = 250,
      this.height = 60,
      this.radius = 60,
      this.bgColor = Constants.mainColor,
      this.fgColor = Colors.white,
      this.fontSize = 27,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            backgroundColor: bgColor,
            // padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize * SizeConfig.ratioFont, color: fgColor),
          ),
        ),
      ),
    );
  }
}

class IconCustomizedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double width, height, radius, fontSize;
  final Color bgColor;
  final Color fgColor;
  final VoidCallback onPressed;
  const IconCustomizedButton(
      {super.key,
      required this.text,
      required this.icon,
      this.width = 280,
      this.height = 120,
      this.radius = 10,
      this.bgColor = Constants.buttonColor,
      this.fgColor = Colors.black,
      this.fontSize = 20,
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
              //padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  size: 70 * SizeConfig.ratioFont,
                  color: fgColor,
                ),
                //SizedBox(width: 10*SizeConfig.ratioWidth,),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize * SizeConfig.ratioFont,
                      color: fgColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainIconCustomizedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double width, height, radius, fontSize;
  final Color bgColor;
  final Color fgColor;
  final VoidCallback onPressed;
   const MainIconCustomizedButton({
    Key? key,
    required this.text,
    required this.icon,
    this.width = 130,
    this.height = 120,
    this.radius = 10,
    this.bgColor = Constants.buttonColor,
    this.fgColor = Colors.black,
    this.fontSize = 20,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            onPressed: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  icon,
                  size: 60 * SizeConfig.ratioFont,
                  color: fgColor,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize * SizeConfig.ratioFont,
                    color: fgColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
