// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';


import '../../../constant.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/main_app_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60 * SizeConfig.ratioHeight,
        backgroundColor: Constants.mainColor,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 25 * SizeConfig.ratioRadius,
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      // endDrawer: DrawerUser(),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: 600 * SizeConfig.ratioHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              //   MainAppName(),
                SizedBox(
                  height: 80 * SizeConfig.ratioHeight,
                ),
                CustomizedButton(
                  text: "Đăng nhập",
                  onPressed: () {
                     Navigator.pushNamed(context, '//');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
