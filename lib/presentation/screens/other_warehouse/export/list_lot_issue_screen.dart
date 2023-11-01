// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/list_lot_issue_event.dart';

import '../../../../domain/entities/location.dart';
import '../../../bloc/blocs/other/issue_bloc/list_goods_issue_uncompleted_bloc.dart';
import '../../../bloc/blocs/other/issue_bloc/list_lot_issue_uncompleted_bloc.dart';
import '../../../bloc/events/other/issue_event/list_goods_issue_event.dart';
import '../../../bloc/states/other/issue_state/list_lot_issue_state.dart';
import '../../../dialog/dialog_one_button.dart';
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

  double subLotQuantity = 0;
  int tabIndex = 0;
  GoodsIssueLot goodsIssueLot = GoodsIssueLot('', null, '', null, null, []);
  GoodsIssueSublot goodsIssueSublot = GoodsIssueSublot('', null, null);
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
                      children: state.lotsSuggest.asMap().entries.map((entry) {
                        final int index1 = entry
                            .key; // Lấy ra index của phần tử trong danh sách
                        final e = entry
                            .value; // Lấy ra giá trị (element) tương ứng với index
                        List<GoodsIssueSublot> goodsIssueSublots = [];
                        double quantity = 0;
                        for (int index = 0;
                            index <
                                state.lotsSuggest[index1].itemLotSubLot.length;
                            index++) {
                          GoodsIssueSublot sublot = GoodsIssueSublot(
                            e.itemLotSubLot[index].locationId,
                            e.itemLotSubLot[index].quantityPerLocation,
                            e.itemLotSubLot[index].newQuantityPerLocation ??
                                0, // Sử dụng '??' để xác định giá trị mặc định nếu null.
                          );

                          goodsIssueSublots.add(sublot);

                          e.itemLotSubLot[index].newQuantityPerLocation ??= 0;
                          quantity = quantity.toDouble() +
                              e.itemLotSubLot[index].newQuantityPerLocation!
                                  .toDouble();
                          if (quantity == e.quantity) {
                            note = "Xuất cả lô";
                          } else if (quantity <
                              double.parse(e.quantity.toString())) {
                            note = "Xuất một phần";
                          } else {
                            note = "Số lượng không hợp lệ";
                          }
                        }

                        return ExpansionPanelRadio(
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
                                      "Sản phẩm : ${e.item?.itemId.toString()} \nSố lượng : ${e.quantity.toString()}"),
                                  //onTap: () {},
                                ),
                              );
                            }),
                            body: Column(children: [
                              SizedBox(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: e.itemLotSubLot.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      title: Column(
                                        children: [
                                          Text(
                                              "Vị trí: ${e.itemLotSubLot[index].locationId}"),
                                          Text(
                                              "Số lượng: ${e.itemLotSubLot[index].quantityPerLocation}"),
                                        ],
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    5 * SizeConfig.ratioHeight),
                                            alignment: Alignment.centerRight,
                                            width: 300 * SizeConfig.ratioWidth,
                                            height: 60 * SizeConfig.ratioHeight,
                                            //color: Colors.grey[200],
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  // filled: true,
                                                  // fillColor: Constants.buttonColor,
                                                  labelText:
                                                      "Nhập số lượng xuất"),
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: true),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp('[0-9.,]')),
                                              ],
                                              onSubmitted: (value) {
                                                // Cập nhật giá trị quantityPerLocation cho mục hiện tại
                                                e.itemLotSubLot[index]
                                                        .newQuantityPerLocation
                                                    //  sublotQuantity[index]
                                                    = value.isNotEmpty
                                                        ? double.parse(value)
                                                        : 0;
                                              },
                                              onChanged: (value) => value != ''
                                                  ? e.itemLotSubLot[index]
                                                          .newQuantityPerLocation =
                                                      double.parse(value)
                                                  : e.itemLotSubLot[index]
                                                          .newQuantityPerLocation =
                                                      double.parse('0'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Column(
                                children: [
                                  Container(           
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    child: Text(
                                        "Tổng số lượng xuất: ${quantity.toString()}", style: TextStyle(fontSize: 17.5*SizeConfig.ratioFont),),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    child: Text("Ghi chú: $note",  style: TextStyle(fontSize: 17.5*SizeConfig.ratioFont),),
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: 5 * SizeConfig.ratioHeight),
                                  //   alignment: Alignment.centerRight,
                                  //   width: 300 * SizeConfig.ratioWidth,
                                  //   height: 60 * SizeConfig.ratioHeight,
                                  //   //color: Colors.grey[200],

                                  //   child: TextField(
                                  //     controller: TextEditingController(
                                  //         text: quantity.toString()),
                                  //     decoration: InputDecoration(
                                  //         border: OutlineInputBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(5)),
                                  //         // filled: true,
                                  //         // fillColor: Constants.buttonColor,
                                  //         labelText: "Tổng số lượng xuất"),
                                  //     keyboardType:
                                  //         const TextInputType.numberWithOptions(
                                  //             decimal: true),
                                  //     inputFormatters: [
                                  //       FilteringTextInputFormatter.allow(
                                  //           RegExp('[0-9.,]')),
                                  //     ],
                                  //     onSubmitted: (value) {
                                  //       // Cập nhật "quantity" từ giá trị mới nhập vào TextField khi người dùng ấn submit
                                  //       quantity = double.tryParse(value) ?? 0.0;
                                  //     },
                                  //     onChanged: (value) => setState(() {
                                  //       quantity = double.tryParse(value) ?? 0.0;
                                  //       if (double.tryParse(value) ==
                                  //           double.parse(e.quantity.toString())) {
                                  //         note = "Xuất cả lô";
                                  //       } else if (double.tryParse(value)! <
                                  //           double.parse(e.quantity.toString())) {
                                  //         note = "Xuất một phần";
                                  //       } else {
                                  //         note = "Số lượng không hợp lệ";
                                  //       }

                                  //       value != ''
                                  //           ? quantity = double.parse(value)
                                  //           : quantity = 0.0;
                                  //     }),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   width: 300 * SizeConfig.ratioWidth,
                                  //   height: 60 * SizeConfig.ratioHeight,
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: 5 * SizeConfig.ratioHeight),
                                  //   child: TextField(
                                  //       controller:
                                  //           TextEditingController(text: note),
                                  //       decoration: InputDecoration(
                                  //           border: OutlineInputBorder(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(5)),
                                  //           // filled: true,
                                  //           // fillColor: Constants.buttonColor,
                                  //           labelText: "Ghi chú"),
                                  //       onChanged: (value) {
                                  //         setState(() {
                                  //           // Cập nhật "note" từ giá trị mới nhập vào TextField
                                  //           note = value;
                                  //         });
                                  //       }),
                                  // ),
                                  TextButton(
                                      onPressed: () async {
                                        if (e.quantity! < quantity || quantity == 0) {
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
                                                          BlocProvider.of<ListGoodsIssueLotUncompletedBloc>(context).add(
                                                              AddGoodsIssueLotEvent(
                                                                  DateTime
                                                                      .now(),
                                                                  true,
                                                                  state.itemId,
                                                                  state
                                                                      .goodsIssueId,
                                                                  // truyền các thông tin trong itemLot vào goodsIssueLot
                                                                  GoodsIssueLot(
                                                                      e.lotId,
                                                                      quantity,
                                                                      e.item!
                                                                          .unit,
                                                                      null,
                                                                     'Xuất cả lô',
                                                                      goodsIssueSublots),
                                                                  state
                                                                      .lotsSuggest,
                                                                  state
                                                                      .lotsExpected,
                                                                  state
                                                                      .itemLotSublot,
                                                                  state
                                                                      .goodsIssueSublots)),
                                                          DefaultTabController
                                                                  .of(context)
                                                              .animateTo(1)
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
                                                                      e.item!
                                                                          .unit,
                                                                      null,
                                                                      'Xuất một phần',
                                                                      goodsIssueSublots),
                                                                  state
                                                                      .lotsSuggest,
                                                                  state
                                                                      .lotsExpected,
                                                                  state
                                                                      .itemLotSublot,
                                                                  state
                                                                      .goodsIssueSublots)),
                                                          DefaultTabController
                                                                  .of(context)
                                                              .animateTo(1)
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
                              )
                            ]));
                      }).toList(),
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
                  return  Dialog(
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
                        height: 480 * SizeConfig.ratioHeight,
                        child: ListView.builder(
                            itemCount: state.lotsExpected.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            55, 0, 20, 0),
                                        child: ListTile(
                                          // leading: const Icon(Icons.list),
                                          isThreeLine: true,
                                          title: Text(
                                              "Mã lô : ${state.lotsExpected[index].goodsIssueLotId}",
                                              style: const TextStyle(fontSize: 16)),
                                          subtitle: Text(
                                              "Sản phẩm : ${state.itemId} \nSố lượng : ${state.lotsExpected[index].quantity} ",
                                              style: const TextStyle(fontSize: 16)),
                                          onTap: () {},
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state.lotsExpected[index]
                                            .goodsIssueSublot.length,
                                        itemBuilder:
                                            (BuildContext context, int index3) {
                                          return ListTile(
                                            leading: const Icon(Icons.list),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${state.lotsExpected[index].goodsIssueSublot[index3].locationId}"),
                                                Text(
                                                    "Số lượng: ${state.lotsExpected[index].goodsIssueSublot[index3].quantityPerLocation}"),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
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
                              state.lotsExpected,
                            ));
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
                                  .add(LoadGoodsIssuesEvent(
                                      DateTime.now(), state.goodsIssueLot));
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
                                  .add(LoadGoodsIssuesEvent(
                                      DateTime.now(), state.goodsIssueLot));
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
