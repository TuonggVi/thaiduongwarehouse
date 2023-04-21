import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

class MainAppName extends StatelessWidget {
 final String title;
  const MainAppName({super.key, this.title = "QUẢN LÝ KHO"});
  @override
  Widget build(BuildContext context) {
        SizeConfig().init(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 45 * SizeConfig.ratioFont,
                fontWeight: FontWeight.bold,
                color: Constants.mainColor),
          ),
          SizedBox(height: 20 * SizeConfig.ratioHeight),
          const Image(
            image: AssetImage('lib/assets/logo_TD.png'),
           // width: 200 * SizeConfig.ratioWidth,
          ),
        ]);
  }
}