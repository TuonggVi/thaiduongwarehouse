import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/list_lot_issue_event.dart';

import '../../../bloc/blocs/other/issue_bloc/list_goods_issue_uncompleted_bloc.dart';
import '../../../bloc/blocs/other/issue_bloc/list_lot_issue_uncompleted_bloc.dart';
import '../../../bloc/events/other/issue_event/list_goods_issue_event.dart';
import '../../../bloc/states/other/issue_state/list_lot_issue_state.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../dialog/dialog_two_button.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

// danh sách xuất hàng hóa đề xuất và dự kiến
class ListLotIssueScreen extends StatefulWidget {
  const ListLotIssueScreen({super.key});

  @override
  State<ListLotIssueScreen> createState() => _ListLotIssueScreenState();
}

class _ListLotIssueScreenState extends State<ListLotIssueScreen> {
  String note = '';
  double quantity = 0;
  int tabIndex = 0;
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
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushNamed(context, '/list_goods_issue_screen');
        // return false;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Hãy chắc chắn bạn đã ấn Xác nhận'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigator.pop(context, true);

                    Navigator.pushNamed(
                      context,
                      '/export_main_screen',
                    );
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return false;

        // return shouldPop!;
      },
      child: DefaultTabController(
        length: 2,
        initialIndex: tabIndex,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.west, //mũi tên back
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/list_goods_issue_screen');
                },
              ),
              bottom: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Creates border
                    color: Constants.secondaryColor),
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(
                    //icon: Icon(Icons.flight),
                    text: 'DS đề xuất',
                  ),
                  Tab(
                    // icon: Icon(Icons.directions_transit),
                    text: 'DS dự kiến',
                  ),
                ],
              ),
              backgroundColor: Constants.mainColor,
              title: Text(
                'Danh sách hàng hóa',
                style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
              ),
            ),
            body: TabBarView(children: [
              BlocConsumer<ListGoodsIssueLotUncompletedBloc,
                  GoodsIssueLotState>(listener: (context, state) {
                //     if(state is PostIssueLotsSuccessState){
                //         AlertDialogOneBtnCustomized(context, 'Thành công',
                //         'Đã hoàn thành việc xuất lô', 'Tiếp tục', () {
                //   Navigator.pushNamed(context, '/export_main_screen');
                // }, 20, 15, () {}, false)
                //     .show();
                //     }
              }, builder: (context, state) {
                if (state is LoadGoodsIssueLotsSuccessState) {
                  return SingleChildScrollView(
                    child: ExpansionPanelList.radio(
                      children: state.lotsSuggest
                          .map((e) => ExpansionPanelRadio(
                              canTapOnHeader: true,
                              value: e.lotId.toString(),
                              headerBuilder: ((context, isExpanded) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    leading: const Icon(Icons.list),
                                    isThreeLine: true,
                                    title: Text("Mã lô : ${e.lotId}"),
                                    subtitle: Text(
                                        "Sản phẩm : ${e.item!.itemId.toString()} \nVị trí : ${e.location!.locationId.toString()} \nSố lượng : ${e.quantity.toString()} \nSố PO : ${e.purchaseOrderNumber.toString()}"),
                                    //onTap: () {},
                                  ),
                                );
                              }),
                              body: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    alignment: Alignment.centerRight,
                                    width: 300 * SizeConfig.ratioWidth,
                                    height: 60 * SizeConfig.ratioHeight,
                                    //color: Colors.grey[200],
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          // filled: true,
                                          // fillColor: Constants.buttonColor,
                                          labelText: "Nhập số lượng xuất"),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9.,]')),
                                      ],                                  
                                      onChanged: (value) => setState(() {                                       
                                        double.tryParse(value) ==
                                                double.parse(
                                                    e.quantity.toString())
                                            ? {note = "Xuất cả lô"}
                                            : {
                                                double.tryParse(value)! <
                                                        double.parse(e.quantity
                                                            .toString())
                                                    ? {note = "Xuất một phần"}
                                                    : {note = "Số lượng không hợp lệ"}
                                              };

                                        value != ''
                                            ? quantity = double.parse(value)
                                            : quantity = double.parse('0');
                                      }),
                                      onSubmitted: (value) => value != ''
                                          ? quantity = double.parse(value)
                                          : quantity = double.parse('0'),
                                    ),
                                  ),
                                  Container(
                                    width: 300 * SizeConfig.ratioWidth,
                                    height: 60 * SizeConfig.ratioHeight,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    child: TextField(
                                      controller:
                                          TextEditingController(text: note),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          // filled: true,
                                          // fillColor: Constants.buttonColor,
                                          labelText: "Ghi chú"),
                                      onChanged: (value) => note = value,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        if (e.quantity! < quantity) {
                                          AlertDialogOneBtnCustomized(
                                                  context,
                                                  'Không hợp lệ',
                                                  'Số lượng nhập không phù hợp',
                                                  'Trở lại',
                                                  'warning_image.png', () {
                                            // Navigator.pushNamed(context, '/main_receipt_screen');
                                          }, 15, 20, () {}, false)
                                              .show();
                                        } else {
                                          await scanQR();
                                          scanResult == e.lotId
                                              ? {
                                                  e.quantity == quantity
                                                      ? {
                                                          BlocProvider.of<
                                                                      ListGoodsIssueLotUncompletedBloc>(
                                                                  context)
                                                              .add(AddGoodsIssueLotEvent(
                                                                  DateTime
                                                                      .now(),
                                                                  true,
                                                                  state.itemId,
                                                                  state
                                                                      .goodsIssueId,
                                                                  GoodsIssueLot(
                                                                      e.lotId,
                                                                      quantity,
                                                                      double.tryParse(e
                                                                          .sublotSize
                                                                          .toString()),
                                                                      null,
                                                                      note),
                                                                  state
                                                                      .lotsSuggest,
                                                                  state
                                                                      .lotsExpected)),
                                                          DefaultTabController
                                                                  .of(context)
                                                              ?.animateTo(1)
                                                        }
                                                      : {
                                                          BlocProvider.of<
                                                                      ListGoodsIssueLotUncompletedBloc>(
                                                                  context)
                                                              .add(AddGoodsIssueLotEvent(
                                                                  DateTime
                                                                      .now(),
                                                                  false,
                                                                  state.itemId,
                                                                  state
                                                                      .goodsIssueId,
                                                                  GoodsIssueLot(
                                                                      e.lotId,
                                                                      quantity,
                                                                      double.tryParse(e
                                                                          .sublotSize
                                                                          .toString()),
                                                                      null,
                                                                      note),
                                                                  state
                                                                      .lotsSuggest,
                                                                  state
                                                                      .lotsExpected)),
                                                          DefaultTabController
                                                                  .of(context)
                                                              ?.animateTo(1)
                                                        }
                                                }
                                              : {
                                                  AlertDialogOneBtnCustomized(
                                                          context,
                                                          'Cảnh báo',
                                                          'Lô không đúng',
                                                          'Trở lại',
                                                          'warning_image.png',
                                                          () {},
                                                          18,
                                                          22,
                                                          () {},
                                                          true)
                                                      .show()
                                                };
                                        }
                                      },
                                      child: const Text('Quét mã xác nhận'))
                                ],
                              )))
                          .toList(),
                    ),
                  );
                }
                if (state is LoadGoodsIssueLotsFailState) {
                  return Center(
                    child: Column(
                      children: [
                        ExceptionErrorState(
                          icon: Icons.check_box_outlined,
                          title: "Lỗi hệ thống",
                          message: "Vui lòng thử lại sau",
                        ),
                        CustomizedButton(
                            text: "Trở về",
                            onPressed: () {
                              // reset lại trang tạo phiếu

                              Navigator.pushNamed(
                                context,
                                '/list_goods_issue_screen',
                              );
                            }),
                      ],
                    ),
                  );
                } else {
                  return Dialog(
                    // The background color
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          // The loading indicator
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 15,
                          ),
                          // Some text
                          Text('Loading...')
                        ],
                      ),
                    ),
                  );
                }
              }),
              BlocConsumer<ListGoodsIssueLotUncompletedBloc,
                  GoodsIssueLotState>(listener: (context, state) {
                // if (state is PostIssueLotsSuccessState) {
                //   AlertDialogOneBtnCustomized(context, 'Thành công',
                //           'Đã xuất lô', 'Tiếp tục', 'Success_image.png', () {

                //     Navigator.pushNamed(context, '/export_main_screen');
                //   }, 20, 15, () {}, false)
                //       .show();
                // }
                // if (state is PostGoodsIssueLotsFailState) {
                //   AlertDialogOneBtnCustomized(
                //           context,
                //           'Thất bại',
                //           'Không thể xuất lô',
                //           'Trở lại',
                //           'Fail_image.png', () {
                //     Navigator.pushNamed(context, '/export_main_screen');
                //   }, 20, 15, () {}, false)
                //       .show();
                // }
              }, builder: (context, state) {
                if (state is LoadGoodsIssueLotsSuccessState) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 400 * SizeConfig.ratioHeight,
                        child: ListView.builder(
                            itemCount: state.lotsExpected.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  leading: const Icon(Icons.list),
                                  isThreeLine: true,
                                  title: Text(
                                      "Mã lô : ${state.lotsExpected[index].goodsIssueLotId}"),
                                  subtitle: Text(
                                      "Sản phẩm : ${state.itemId} \nSố lượng : ${state.lotsExpected[index].quantity} \nĐịnh mức : ${state.lotsExpected[index].sublotSize.toString()}"),
                                  onTap: () {},
                                ),
                              );
                            }),
                      ),
                      CustomizedButton(
                          text: "Xác nhận",
                          onPressed: () {
                            BlocProvider.of<ListGoodsIssueLotUncompletedBloc>(
                                    context)
                                .add(PostGoodsIssueLotEvent(
                                    DateTime.now(),
                                    state.itemId,
                                    state.goodsIssueId,
                                    state.lotsExpected));
                            // Navigator.pushNamed(
                            //   context,
                            //   '/fill_info_entry_screen',
                            // );
                          })
                    ],
                  );
                }
                if (state is PostIssueLotsSuccessState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExceptionErrorState(
                          icon: Icons.check_box_outlined,
                          title: 'Thành công',
                          message: "Đã xuất lô",
                        ),
                        CustomizedButton(
                            text: "Trở lại",
                            onPressed: () {
                              BlocProvider.of<ListGoodsIssueUncompletedBloc>(
                                      context)
                                  .add(LoadGoodsIssuesEvent(DateTime.now()));
                              Navigator.pushNamed(
                                  context, '/list_goods_issue_screen');
                            })
                      ],
                    ),
                  );
                }
                if (state is PostGoodsIssueLotsFailState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExceptionErrorState(
                          icon: Icons.check_box_outlined,
                          title: 'Thất bại',
                          message: "Không thể xuất lô",
                        ),
                        CustomizedButton(
                            text: "Trở lại",
                            onPressed: () {
                              BlocProvider.of<ListGoodsIssueUncompletedBloc>(
                                      context)
                                  .add(LoadGoodsIssuesEvent(DateTime.now()));
                              Navigator.pushNamed(
                                  context, '/list_goods_issue_screen');
                            })
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ])),
      ),
    );
  }
}
