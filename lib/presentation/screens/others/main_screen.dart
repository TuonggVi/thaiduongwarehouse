// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/export_function_screen.dart';

import '../../widgets/button_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
           leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
             Navigator.pushNamed(context, '//');
            },
          ),
        backgroundColor: Constants.mainColor,
        title: Text(
          'Quản lý kho',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainIconCustomizedButton(
                    icon: Icons.input_outlined,
                    text: "NHẬP KHO",
                    onPressed: () {
                      Navigator.pushNamed(context, '/main_receipt_screen');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ImportFunctionScreen()),
                      // );
                    }),
                MainIconCustomizedButton(
                    icon: Icons.output,
                    text: "XUẤT KHO",
                    onPressed: () {
                      
                      Navigator.pushNamed(context, '/export_main_screen');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ExportFunctionScreen()),
                      // );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainIconCustomizedButton(
                    icon: Icons.warehouse,
                    text: "TỒN KHO",
                    onPressed: () {
                      Navigator.pushNamed(context, '/stockcard_function_screen');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const StockcardFunctionScreen()),
                      // );
                    }),
                MainIconCustomizedButton(
                    icon: Icons.fact_check_outlined,
                    text: "KIỂM KÊ",
                    onPressed: () {
                       Navigator.pushNamed(context, '/scan_adjustment_screen');

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => BarcodeScannerScreen()),
                      // );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainIconCustomizedButton(
                    icon: Icons.cabin,
                    text: "KỆ KHO",
                    onPressed: () {
                       Navigator.pushNamed(context, '/shelves_function_screen');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ShelveFunctionScreen()),
                      // );
                    }),
                MainIconCustomizedButton(
                    icon: Icons.history_outlined,
                    text: "LỊCH SỬ",
                    onPressed: () {
                      Navigator.pushNamed(context, '/history_function_screen');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const HistoryFunctionScreen()),
                      // );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainIconCustomizedButton(
                    icon: Icons.hourglass_disabled_outlined,
                    text: "CÁCH LY",
                    onPressed: () {
                      Navigator.pushNamed(context, '/isolation_function_screen');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const IsolationFunctionScreen()),
                      // );
                    }),
                MainIconCustomizedButton(
                    icon: Icons.warning_amber_outlined,
                    text: "CẢNH BÁO",
                    onPressed: () {
                    Navigator.pushNamed(context, '/warning_function_screen');

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const WarningFunctionScreen()),
                      // );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
