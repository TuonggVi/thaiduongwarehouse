import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/adjustment_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/dialog/dialog_two_button.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

import '../../../bloc/events/other/adjustment_events.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String scanResult = '-1'; //Scan QR ra
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
      scanResult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () async {
        Navigator.pushReplacementNamed(context, "/main_screen");
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.west, //mũi tên back
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/main_screen');
              },
            ),
            // leading: IconButton(
            //     icon: const Icon(Icons.west_outlined),
            //     onPressed: () {
            //       // if (scanResult != "-1") {
            //       //   AlertDialogTwoBtnCustomized(
            //       //           context,
            //       //           'Bạn có chắc',
            //       //           'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
            //       //           'Trở lại',
            //       //           'Tiếp tục', () {
            //       //     Navigator.pushNamed(context, '///');
            //       //   }, () {}, 18, 22)
            //       //       .show();
            //       // } else {
            //       //   Navigator.of(context).pop();
            //       // }
            //     }),
            backgroundColor: Constants.mainColor,
            title: Text(
              'Quét mã',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          //endDrawer: DrawerUser(),
          body: Builder(builder: (BuildContext context) {
            return Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          scanResult != '-1'
                              ? 'Kết quả : $scanResult\n'
                              : 'Quét mã lô cần kiểm kê',
                          style: TextStyle(
                              fontSize: 22 * SizeConfig.ratioFont,
                              color: scanResult != '-1'
                                  ? Colors.black
                                  : Colors.red)),
                      SizedBox(
                        height: 20 * SizeConfig.ratioHeight,
                      ),
                      CustomizedButton(
                        onPressed: () {
                          scanResult = '-1';
                          scanQR();
                        },
                        text: "Quét mã",
                      ),
                      SizedBox(
                        height: 10 * SizeConfig.ratioHeight,
                      ),
                      CustomizedButton(
                          onPressed: scanResult == '-1'
                              ? () {
                                  AlertDialogTwoBtnCustomized(
                                          context,
                                          'Chưa có sản phẩm được quét',
                                          'Ấn tiếp tục để quét lại',
                                          'Fail_image.png',
                                          'Tiếp tục',
                                          'Trở lại',
                                          () async {}, () {
                                    Navigator.pushNamed(
                                        context, '/main_receipt_screen');
                                  }, 18, 22)
                                      .show();
                                  //    BlocProvider.of<AdjustmentBloc>(context).add(
                                  //     GetLotEvent(DateTime.now(), "Lo008"));
                                  // Navigator.pushNamed(
                                  //     context, '/lot_adjustment_screen');
                                }
                              : () {
                                  BlocProvider.of<AdjustmentBloc>(context).add(
                                      GetLotEvent(DateTime.now(), scanResult));
                                  Navigator.pushNamed(
                                      context, '/lot_adjustment_screen');
                                },
                          text: 'Xác nhận')
                    ]));
          })),
    );
  }
}
