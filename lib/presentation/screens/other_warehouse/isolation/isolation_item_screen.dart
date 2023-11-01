// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/isolation_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/isolation_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/isolation_states.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../dialog/dialog_two_button.dart';

import '../../../widgets/exception_widget.dart';

class IsolatedNewItemLotScreen extends StatefulWidget {
  const IsolatedNewItemLotScreen({super.key});

  @override
  _IsolatedNewItemLotScreenState createState() =>
      _IsolatedNewItemLotScreenState();
}

class _IsolatedNewItemLotScreenState extends State<IsolatedNewItemLotScreen> {
  String scanResult = '-1'; //Scan QR ra
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#e60000', 'Cancel', true, ScanMode.QR);
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
        Navigator.pushNamed(context, "/isolation_function_screen");
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
                Navigator.pushNamed(context, '/isolation_function_screen');
              },
            ),
            backgroundColor: Constants.mainColor,
            title: Text(
              'Quét mã',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          //endDrawer: DrawerUser(),
          body: BlocConsumer<IsolationBloc, IsolationState>(
              listener: (context, state) {
            if (state is GetLotByLotIdSuccessState) {
              AlertDialogTwoBtnCustomized(
                context,
                'Xác nhận',
                'Bạn có chắc muốn cách ly lô hàng $scanResult',
                'warning_image.png',
                'Xác nhận',
                'Trở lại',
                () {
                  BlocProvider.of<IsolationBloc>(context)
                      .add(PostNewIsolationEvent(DateTime.now(), scanResult));
                },
                () {
                  Navigator.pushNamed(context, '/isolation_function_screen');
                },
                15,
                20,
              ).show();
            }
            if (state is PostNewIsolationSuccessState) {
              AlertDialogOneBtnCustomized(
                      context,
                      'Thành công',
                      'Đã cách ly lô hàng',
                      'Tiếp tục',
                      'Success_image.png', () {
                Navigator.pushNamed(context, '/isolation_function_screen');
              }, 15, 20, () {}, false)
                  .show();
            }
            if (state is PostNewIsolationFailState) {
              AlertDialogOneBtnCustomized(
                      context,
                      'Thất bại',
                      'Không thể tiến hành cách ly',
                      'Tiếp tục',
                      'Fail_image.png', () {
                Navigator.pushNamed(context, '/isolation_function_screen');
              }, 15, 20, () {}, false)
                  .show();
            }
          }, builder: ((context, state) {
            // if (state is GetLotByLotIdSuccessState) {
            //   return Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Text(
            //             scanResult != '-1'
            //                 ? 'Kết quả : $scanResult\n'
            //                 : 'Vui lòng quét mã lô',
            //             style: TextStyle(
            //                 fontSize: 22 * SizeConfig.ratioFont,
            //                 color: scanResult != '-1'
            //                     ? Colors.black
            //                     : Colors.red)),
            //         SizedBox(
            //           height: 20 * SizeConfig.ratioHeight,
            //         ),
            //         CustomizedButton(
            //           onPressed: () {
            //             scanResult = '1';
            //             scanQR();
            //           },
            //           text: "Quét mã",
            //         ),
            //         SizedBox(
            //           height: 10 * SizeConfig.ratioHeight,
            //         ),
            //         CustomizedButton(
            //             onPressed: scanResult == '-1'
            //                 ? () {
            //                     AlertDialogTwoBtnCustomized(
            //                             context,
            //                             'Cảnh báo',
            //                             'Chưa có lô được quét',
            //                             'Tiếp tục',
            //                             'Trở lại',
            //                             'warning_image.png',
            //                             () async {}, () {
            //                       Navigator.pushNamed(
            //                           context, '/isolation_function_screen');
            //                     }, 18, 22)
            //                         .show();
            //                   }
            //                 : () {
            //                     BlocProvider.of<IsolationBloc>(context).add(
            //                         GetLotByLotIdEvent(
            //                             DateTime.now(), scanResult));
            //                   },
            //             text: 'Xác nhận'),
            //         ListTile(
            //             // leading: ,
            //             // trailing: Icon(
            //             //     Icons.arrow_drop_down_sharp,
            //             //     size: 15 * SizeConfig.ratioFont),
            //             title: Text("Mã lô : ${state.itemLot.lotId}"),
            //             subtitle: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                     "Sản phẩm : ${state.itemLot.item!.itemName.toString()}  \nSố lượng : ${state.itemLot.quantity.toString()}"),
            //                 Text(
            //                     "Định mức : ${state.itemLot.sublotSize.toString()}  \nVị trí : ${state.itemLot.location!.locationId.toString()}"),
            //               ],
            //             ),
            //             isThreeLine: true,
            //             onTap: () {}),
            //         CustomizedButton(
            //             onPressed: (() {
            //               BlocProvider.of<IsolationBloc>(context).add(
            //                   PostNewIsolationEvent(
            //                       DateTime.now(), scanResult));
            //             }),
            //             text: 'Xác nhận'),
            //       ]);
            // }
            if (state is PostNewIsolationFailState) {
              return Container(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20 * SizeConfig.ratioHeight,
                        ),
                        Center(
                          child: ExceptionErrorState(
                            title: 'Lỗi hệ thống',
                            message: "Vui lòng thử lại sau",
                          ),
                        ),
                        CustomizedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/isolation_function_screen');
                            },
                            text: 'Xác nhận')
                      ]));
            } else {
              // return SingleChildScrollView(
              //   child: Container(
              //       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              //       child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Container(
              //               alignment: Alignment.center,
              //               padding:
              //                   EdgeInsets.all(10 * SizeConfig.ratioHeight),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     overflow: TextOverflow.ellipsis,
              //                     "Thông tin lô hàng",
              //                     style: TextStyle(
              //                       fontWeight: FontWeight.w600,
              //                       fontSize: 20 * SizeConfig.ratioFont,
              //                       color: Colors.black,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: 10 * SizeConfig.ratioHeight,
              //                   ),
              //                   Column(
              //                     children: [
              //                       BarcodeinputWidget(
              //                         textController: scanResult,
              //                         textLabel: "Mã lô",
              //                         onChange: ((data) {
              //                           scanResult = data;
              //                           BlocProvider.of<IsolationBloc>(context)
              //                               .add(GetLotByLotIdEvent(
              //                                   DateTime.now(), scanResult));
              //                         }),
              //                         onScan: ((data) {
              //                           scanResult = data;
              //                           BlocProvider.of<IsolationBloc>(context)
              //                               .add(GetLotByLotIdEvent(
              //                                   DateTime.now(), scanResult));
              //                         }),
              //                       ),
              //                       Container(
              //                         padding: const EdgeInsets.fromLTRB(
              //                             25, 10, 0, 0),
              //                         child: Row(
              //                           children: [
              //                             Text(
              //                               overflow: TextOverflow.ellipsis,
              //                               "Mã sản phẩm:    ",
              //                               style: TextStyle(
              //                                 fontWeight: FontWeight.w600,
              //                                 fontSize:
              //                                     20 * SizeConfig.ratioFont,
              //                                 color: Colors.black,
              //                               ),
              //                             ),
              //                             Container(
              //                               width: 160 * SizeConfig.ratioWidth,
              //                               height: 45 * SizeConfig.ratioHeight,
              //                               decoration: const BoxDecoration(
              //                                   shape: BoxShape.rectangle,
              //                                   color: Constants.buttonColor,
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(8.0))),
              //                               child: Center(
              //                                 child: Text(
              //                                   '',
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: TextStyle(
              //                                     fontWeight: FontWeight.w300,
              //                                     fontSize:
              //                                         22 * SizeConfig.ratioFont,
              //                                     color: Colors.black,
              //                                   ),
              //                                 ),
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                       ),
              //                       Container(
              //                         padding: const EdgeInsets.fromLTRB(
              //                             25, 10, 0, 0),
              //                         child: Row(
              //                           children: [
              //                             Text(
              //                               overflow: TextOverflow.ellipsis,
              //                               "Số lượng:            ",
              //                               style: TextStyle(
              //                                 fontWeight: FontWeight.w600,
              //                                 fontSize:
              //                                     20 * SizeConfig.ratioFont,
              //                                 color: Colors.black,
              //                               ),
              //                             ),
              //                             Container(
              //                               // padding:
              //                               // const EdgeInsets.fromLTRB(0, 10, 10, 10),
              //                               width: 160 * SizeConfig.ratioWidth,
              //                               height: 45 * SizeConfig.ratioHeight,
              //                               decoration: const BoxDecoration(
              //                                   shape: BoxShape.rectangle,
              //                                   color: Constants.buttonColor,
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(8.0))),
              //                               child: Center(
              //                                 child: Text(
              //                                   '',
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: TextStyle(
              //                                     fontWeight: FontWeight.w300,
              //                                     fontSize:
              //                                         22 * SizeConfig.ratioFont,
              //                                     color: Colors.black,
              //                                   ),
              //                                 ),
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                       ),
              //                       Container(
              //                         padding: const EdgeInsets.fromLTRB(
              //                             25, 10, 0, 0),
              //                         child: Row(
              //                           children: [
              //                             Text(
              //                               overflow: TextOverflow.ellipsis,
              //                               "PO cũ:                 ",
              //                               style: TextStyle(
              //                                 fontWeight: FontWeight.w600,
              //                                 fontSize:
              //                                     20 * SizeConfig.ratioFont,
              //                                 color: Colors.black,
              //                               ),
              //                             ),
              //                             Container(
              //                               // padding:
              //                               // const EdgeInsets.fromLTRB(0, 10, 10, 10),
              //                               width: 160 * SizeConfig.ratioWidth,
              //                               height: 45 * SizeConfig.ratioHeight,
              //                               decoration: const BoxDecoration(
              //                                   shape: BoxShape.rectangle,
              //                                   color: Constants.buttonColor,
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(8.0))),
              //                               child: Center(
              //                                 child: Text(
              //                                   '',
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: TextStyle(
              //                                     fontWeight: FontWeight.w300,
              //                                     fontSize:
              //                                         22 * SizeConfig.ratioFont,
              //                                     color: Colors.black,
              //                                   ),
              //                                 ),
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(10.0),
              //                     child: CustomizedButton(
              //                         text: "Xác nhận", onPressed: () {}),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ])),
              // );
              return Container(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            scanResult != '-1'
                                ? 'Kết quả : $scanResult\n'
                                : 'Vui lòng quét mã lô',
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
                            scanResult = '1';
                            scanQR(); // gọi hàm scan qr
                          },
                          text: "Quét mã",
                        ),
                        SizedBox(
                          height: 10 * SizeConfig.ratioHeight,
                        ),
                        CustomizedButton(
                            onPressed: scanResult == '-1'
                                ? () {
                                    // BlocProvider.of<IsolationBloc>(context).add(
                                    //     GetLotByLotIdEvent(
                                    //         DateTime.now(), 'Lo008'));
                                    AlertDialogTwoBtnCustomized(
                                            context,
                                            'Cảnh báo',
                                            'Chưa có lô được quét',
                                            'warning_image.png',
                                            'Tiếp tục',
                                            'Trở lại',
                                            () async {}, () {
                                      Navigator.pushNamed(context,
                                          '/isolation_function_screen');
                                    }, 18, 22)
                                        .show();
                                  }
                                : () {
                                    BlocProvider.of<IsolationBloc>(context).add(
                                        GetLotByLotIdEvent(
                                            DateTime.now(), scanResult));
                                  },
                            text: 'Xác nhận')
                      ]));
            }
          }))),
    );
  }
}
