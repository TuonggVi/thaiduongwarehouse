import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import '../../../constant.dart';
import '../../dialog/dialog_two_button.dart';
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
           // height: 400 * SizeConfig.ratioHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 80 * SizeConfig.ratioHeight,
                ),
                const MainAppName(),
                SizedBox(
                  height: 180 * SizeConfig.ratioHeight,
                ),
                CustomizedButton(
                  text: "Đăng nhập",
                  onPressed: () {
                    //  AlertDialogTwoBtnCustomized(
                    //                     context,
                    //                     'Bạn có chắc',
                    //                     'Chưa có sản phẩm được quét? Ấn tiếp tục để quét lại',
                    //                     'Fail_image.png',
                    //                     'Tiếp tục',
                    //                     'Trở lại',
                    //                     () async {}, () {
                    //               Navigator.pushNamed(
                    //                   context, '/main_receipt_screen');
                    //             }, 18, 22)
                    //                 .show();
            //           AlertDialogOneBtnCustomized(context, 'Thất bại',
            //         'Không thể hoàn thành việc tạo đơn', 'Trở lại','Fail_image.png', () {
            //   // Navigator.pushNamed(context, '/main_receipt_screen');
            // }, 20, 15, () {}, false)
            //     .show();
                    Navigator.pushNamed(context, '//');
                   
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
