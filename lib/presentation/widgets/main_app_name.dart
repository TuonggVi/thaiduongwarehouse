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
       // mainAxisAlignment: MainAxisAlignment.end,
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
            Image(
            image: const AssetImage('lib/assets/Logo_demo.png'),
            width: 400 * SizeConfig.ratioWidth,
          ),
        //  SizedBox(height: 10 * SizeConfig.ratioHeight),
        //   Container(
        //     width: 200 * SizeConfig.ratioWidth,
        //     alignment: Alignment.center,
        //     child: Row(
        //       children: [
                
        //         Image(
        //           image: const AssetImage('lib/assets/Logo_BK.png'),
        //           width: 100 * SizeConfig.ratioWidth,
        //         ),
        //         Image(
        //           image: const AssetImage('lib/assets/logoBoMonNew.png'),
        //           width: 100 * SizeConfig.ratioWidth,
        //         ),
        //       ],
        //     ),
        //   ),
        ]);
  }
}
