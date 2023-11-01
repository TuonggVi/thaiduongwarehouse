// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/uncompleted_receipt_lot_event.dart';
import '../../../../domain/entities/other/goods_receipt.dart';
import '../../../../function.dart';
import '../../../bloc/blocs/other/receipt_bloc/add_receipt_lot_bloc.dart';
import '../../../bloc/blocs/other/receipt_bloc/uncompleted_receipt_bloc.dart';
import '../../../bloc/blocs/other/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import '../../../bloc/blocs/other/receipt_bloc/update_receipt_lot_bloc.dart';
import '../../../bloc/events/other/receipt_event/add_receipt_lot_event.dart';
import '../../../bloc/events/other/receipt_event/uncompleted_receipt_event.dart';
import '../../../bloc/events/other/receipt_event/update_receipt_lot_event.dart';
import '../../../bloc/states/other/receipt_state/uncompleted_receipt_lot_state.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

// danh sách các lô hàng chưa hoàn thành
class ListUncompletedLotReceiptScreen extends StatefulWidget {
  const ListUncompletedLotReceiptScreen({super.key});

  @override
  State<ListUncompletedLotReceiptScreen> createState() =>
      _ListUncompletedLotReceiptScreenState();
}

class _ListUncompletedLotReceiptScreenState
    extends State<ListUncompletedLotReceiptScreen> {
  GoodsReceipt goodsReceipt =
      GoodsReceipt('', '', [], DateTime.now(), null, false);
  GoodsReceiptLot goodsReceiptLot =
      GoodsReceiptLot('', '', '', [], null, null, null, null, null, null, null);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //bool showExpand = false;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/importing_receipt_screen");
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
              Navigator.pushNamed(context, '/importing_receipt_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Danh sách lô',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 10 * SizeConfig.ratioHeight,
              ),
              //  ListTile()
              Text(
                overflow: TextOverflow.ellipsis,
                "Danh sách các lô hàng",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25 * SizeConfig.ratioFont,
                  color: Colors.black,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     onChanged: ((value) {}),
              //     controller: TextEditingController(),
              //     decoration: const InputDecoration(
              //         labelText: "Search",
              //         hintText: "Search",
              //         prefixIcon: Icon(Icons.search),
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              //   ),
              // ),
              BlocConsumer<ExportingReceiptLotBloc, UncompletedReceiptLotState>(
                listener: (context, state) {
                  if (state is PatchReceiptLotChangedFailState) {
                    AlertDialogOneBtnCustomized(
                            context,
                            'Thất bại',
                            'Vị trí không hợp lệ.',
                            'Trở lại',
                            'Fail_image.png', () {
                      BlocProvider.of<ExportingReceiptLotBloc>(context)
                          .add(UpdateReceiptFailEvent(
                              DateTime.now(),
                              // tạo mới goodReiceip với các trường thông tin chưa được điền
                              state.goodsReceipt as GoodsReceipt));
                      Navigator.pushNamed(context, '/importing_receipt_screen');

                      // Navigator.pushNamed(
                      //     context, '/importing_receipt_lot_screen');
                    }, 15, 20, () {}, false)
                        .show();
                  }
                  if (state is PatchReceiptLotChangedSuccessState) {
                    AlertDialogOneBtnCustomized(
                            context,
                            'Thành công',
                            'Đã hoàn thành việc cập nhật',
                            'Tiếp tục',
                            'Success_image.png', () {
                      BlocProvider.of<ExportingReceiptBloc>(context)
                          .add(LoadUncompletedGoodsReceiptEvent(
                        DateTime.now(),
                      ));
                      // tạo mới goodReiceip với các trường thông tin chưa được điền
                      //state.goodsReceipt as GoodsReceipt));
                      Navigator.pushNamed(context, '/importing_receipt_screen');
                    }, 15, 20, () {}, false)
                        .show();
                  }
                  if (state is RemoveReceiptLotFailState) {
                    AlertDialogOneBtnCustomized(
                            context,
                            'Thất bại',
                            'Lô hàng đang/đã xuất kho.',
                            'Trở lại',
                            'Fail_image.png', () {
                      Navigator.pushNamed(
                          context, '/importing_receipt_screen');
                    }, 15, 20, () {}, false)
                        .show();
                  }
                  if (state is RemoveReceiptLotSuccessState) {
                    AlertDialogOneBtnCustomized(
                            context,
                            'Thành công',
                            'Đã hoàn thành',
                            'Tiếp tục',
                            'Success_image.png', () {
                      BlocProvider.of<ExportingReceiptBloc>(context)
                          .add(LoadUncompletedGoodsReceiptEvent(
                        DateTime.now(),
                        //  state.goodsReceipt
                      ));
                      Navigator.pushNamed(context, '/importing_receipt_screen');
                    }, 15, 20, () {}, false)
                        .show();
                  }
                  
                },
                builder: (context, state) {
                  if (state is PatchReceiptLotChangedSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: ExceptionErrorState(
                            title: "Thành công",
                            message: "Đã hoàn thành việc cập nhật",
                          ),
                        ),
                        CustomizedButton(
                            text: "Trở về",
                            onPressed: () {
                              //  _showForm('', state.items);

                              Navigator.pushNamed(
                                context,
                                '/main_receipt_screen',
                              );
                            }),
                      ],
                    );
                  }

                  // load lô trong phiếu nhập kho
                  if (state is UpdateReceiptLotSuccessState) {
                    // lưu thông tin lô khi chuyển trang

                    goodsReceipt = state.goodsReceipt as GoodsReceipt;

                    return Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 380 * SizeConfig.ratioHeight,
                              child: ListView.builder(
                                  itemCount: state.goodsReceipt?.lots.length,
                                  // itemCount: state.goodReceiptLot.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    state.goodsReceipt?.lots[index]
                                            .newGoodsReceiptLotId ??=
                                        goodsReceipt
                                            .lots[index].goodsReceiptLotId;

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ListTile(
                                              // leading: const Icon(Icons.list),
                                              // shape: RoundedRectangleBorder(
                                              //   side: BorderSide(width: 1),
                                              //   borderRadius: BorderRadius.circular(10),
                                              // ),
                                              // trailing: Icon(Icons.edit,
                                              //     size: 15 *
                                              //         SizeConfig.ratioFont),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Mã lô : ${state.goodsReceipt?.lots[index].goodsReceiptLotId}"),
                                                      Text(
                                                          "Mã lô mới: ${state.goodsReceipt?.lots[index].newGoodsReceiptLotId?.isEmpty ?? true ? 
                                                          goodsReceipt.lots[index].goodsReceiptLotId : state.goodsReceipt!.lots[index].newGoodsReceiptLotId}"),
                                                    ],
                                                  ),
                                                  Icon(Icons.edit,
                                                      size: 15 *
                                                          SizeConfig.ratioFont),
                                                ],
                                              ),

                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 150 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                "Mã hàng: ${state.goodsReceipt!.lots[index].item!.itemId}"),
                                                            Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                "Tên hàng: ${state.goodsReceipt!.lots[index].item!.itemName}"),
                                                            Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                "Số lượng: ${state.goodsReceipt!.lots[index].quantity}"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 130 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                "NSX: ${state.goodsReceipt!.lots[index].productionDate ?? 'Chưa cập nhật'}"),
                                                            Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                "HSD: ${state.goodsReceipt!.lots[index].expirationDate ?? 'Chưa cập nhật'}"),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              isThreeLine: true,
                                              onTap: () {
                                                BlocProvider.of<
                                                            GoodsReceiptSublotBloc>(
                                                        context)
                                                    .add(RefillReceiptLotEvent(
                                                  DateTime.now(),
                                                  state.goodsReceipt
                                                      as GoodsReceipt,
                                                  index,
                                                ));
                                                Navigator.pushNamed(
                                                  context,
                                                  '/update_lot_receipt_screen',
                                                );
                                              },
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: state
                                                  .goodsReceipt!
                                                  .lots[index]
                                                  .goodsReceiptSublots
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index1) {
                                                return ListTile(
                                                  title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 150 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                            "Vị trí: ${state.goodsReceipt!.lots[index].goodsReceiptSublots[index1].locationId}",
                                                            // style: TextStyle(
                                                            //     fontSize: 17 *
                                                            //         SizeConfig
                                                            //             .ratioFont, color: Colors.black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 130 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "Số lượng: ${state.goodsReceipt!.lots[index].goodsReceiptSublots[index1].quantityPerLocation}"),
                                                        ),
                                                      ]),
                                                );
                                              },
                                            ),
                                            
                                          ],
                                        ),
                                        
                                      ),
                                      
                                    );
                                    
                                  }),
                                  
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(280, 0, 20, 10),
                              child: FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  tooltip: 'Thêm lô',
                                  mini: true,
                                  onPressed: () {
                                    //  _showForm('', state.items);
                                    BlocProvider.of<FillInfoNewReceiptLotBloc>(
                                            context)
                                        .add(FillNewReceiptLotEvent(
                                      DateTime.now(),
                                      goodsReceipt,
                                      -1,
                                    ));
                                    Navigator.pushNamed(
                                      context,
                                      '/add_receipt_lot_screen',
                                    );
                                  },
                                  child: const Icon(Icons.add)),
                            ),
                          ],
                        ),
                        CustomizedButton(
                            text: "Xác nhận",
                            onPressed: () {
                              BlocProvider.of<ExportingReceiptLotBloc>(context)
                                  .add(PatchReceiptChangedEvent(
                                //-1,
                                // goodsReceiptLot,
                                // goodsReceipt,
                                DateTime.now(),
                                //  goodsReceipt
                                state.goodsReceipt as GoodsReceipt,
                              ));

                              Navigator.pushNamed(
                                  context, '/importing_receipt_lot_screen');
                            }),
                        CustomizedButton(
                            text: "Trở lại",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/importing_receipt_screen');
                            })
                      ],
                    );
                  } else if (state is PatchReceiptLotChangedFailState) {
                    return Center(
                      child: Column(
                        children: [
                          ExceptionErrorState(
                            icon: Icons.error_outline,
                            title: "Thất bại",
                            // message: "Kiểm tra lại thông tin",
                          ),
                          CustomizedButton(
                              text: "Chỉnh sửa",
                              onPressed: () {
                                BlocProvider.of<ExportingReceiptLotBloc>(
                                        context)
                                    .add(UpdateReceiptFailEvent(
                                  DateTime.now(),
                                  // truyền thông tin phiếu nhập cũ
                                  state.goodsReceipt as GoodsReceipt,
                                ));
                                Navigator.pushNamed(
                                  context,
                                  '/add_receipt_lot_screen',
                                );
                              }),
                          CustomizedButton(
                              text: "Trở về",
                              onPressed: () {
                                // reset lại trang tạo phiếu
                                BlocProvider.of<ExportingReceiptLotBloc>(
                                        context)
                                    .add(UpdateReceiptFailEvent(
                                        DateTime.now(),
                                        // tạo mới goodReiceip với các trường thông tin chưa được điền
                                        state.goodsReceipt as GoodsReceipt));
                                Navigator.pushNamed(
                                  context,
                                  '/main_receipt_screen',
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
