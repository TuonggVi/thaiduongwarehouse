import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_receipt_model.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/uncompleted_receipt_lot_event.dart';
import '../../../../domain/entities/other/goods_receipt.dart';
import '../../../../function.dart';
import '../../../bloc/blocs/other/receipt_bloc/add_receipt_lot_bloc.dart';
import '../../../bloc/blocs/other/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import '../../../bloc/blocs/other/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import '../../../bloc/events/other/receipt_event/add_receipt_lot_event.dart';
import '../../../bloc/events/other/receipt_event/fill_info_receipt_lot_event.dart';
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
      GoodsReceipt('', '',  [], DateTime.now(), null, false);
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
                            'Không thể hoàn thành việc cập nhật',
                            'Trở lại',
                            'Fail_image.png', () {
                      Navigator.pushNamed(context, '/importing_receipt_lot_screen');
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
                      Navigator.pushNamed(context, '/main_receipt_screen');
                    }, 15, 20, () {}, false)
                        .show();
                  }
                },
                builder: (context, state) {
                  if (state is PatchReceiptLotChangedSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ExceptionErrorState(
                          title: "Thành công",
                          message: "Đã hoàn thành việc cập nhật",
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
                  else if (state is  PostReceiptLotChangedFailState) {
              return Center(
                child: Column(
                  children: [
                    ExceptionErrorState(
                      icon: Icons.error_outline,
                      title: "Thất bại",
                      message: "Đã có lỗi trong lúc tạo đơn",
                    ),
                     CustomizedButton(
                        text: "Chỉnh sửa",
                        onPressed: () {
                          BlocProvider.of<ExportingReceiptLotBloc>(context)
                              .add(UpdateReceiptFailEvent(
                            DateTime.now(),
                            // truyền thông tin phiếu nhập cũ
                            state.goodsReceipt as GoodsReceipt,
                          ));
                        }),
                    CustomizedButton(
                        text: "Trở về",
                        onPressed: () {
                          // reset lại trang tạo phiếu
                            BlocProvider.of<ExportingReceiptLotBloc>(context)
                              .add(UpdateReceiptFailEvent(
                            DateTime.now(),
                            // tạo mới goodReiceip với các trường thông tin chưa được điền
                          GoodsReceipt('', '',  [], null, null, false),
                          ));
                          Navigator.pushNamed(
                            context,
                            '/main_receipt_screen',
                          );
                        }),
                   
                  ],
                ),
              );
            }
                  if (state is UpdateReceiptLotSuccessState) {
                    goodsReceipt = state.goodsReceipt;
                    return Column(
                      children: [
                        SizedBox(
                            height: 400 * SizeConfig.ratioHeight,
                            child: ListView.builder(
                                itemCount: state.goodsReceipt.lots.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        // leading: const Icon(Icons.list),
                                        // shape: RoundedRectangleBorder(
                                        //   side: BorderSide(width: 1),
                                        //   borderRadius: BorderRadius.circular(10),
                                        // ),
                                        trailing: Icon(Icons.edit,
                                            size: 15 * SizeConfig.ratioFont),
                                        title: Text(
                                            "Mã lô : ${state.goodsReceipt.lots[index].goodsReceiptLotId}"),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width:
                                                  150 * SizeConfig.ratioWidth,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .ratioFont,
                                                        color: Colors.black,
                                                      ),
                                                      "Mã hàng: ${state.goodsReceipt.lots[index].item!.itemId}"),
                                                  Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .ratioFont,
                                                        color: Colors.black,
                                                      ),
                                                      "Số lượng: ${state.goodsReceipt.lots[index].quantity}"),
                                                  // Text(
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     style: TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.w100,
                                                  //       fontSize: 16 *
                                                  //           SizeConfig
                                                  //               .ratioFont,
                                                  //       color: Colors.black,
                                                  //     ),
                                                  //     "Vị trí: ${state.goodsReceipt.lots[index].location ?? '...'}"),
                                                  // Text(
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     style: TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.w100,
                                                  //       fontSize: 16 *
                                                  //           SizeConfig
                                                  //               .ratioFont,
                                                  //       color: Colors.black,
                                                  //     ),
                                                  //     "NSX: ${state.goodsReceipt.lots[index].productionDate ?? '...'}"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  130 * SizeConfig.ratioWidth,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .ratioFont,
                                                        color: Colors.black,
                                                      ),
                                                      "Tên hàng: ${state.goodsReceipt.lots[index].item!.itemName}"),
                                                  Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .ratioFont,
                                                        color: Colors.black,
                                                      ),
                                                      "Định mức: ${state.goodsReceipt.lots[index].sublotSize ?? '...'}  "),
                                                  // Text(
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     style: TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.w100,
                                                  //       fontSize: 16 *
                                                  //           SizeConfig
                                                  //               .ratioFont,
                                                  //       color: Colors.black,
                                                  //     ),
                                                  //     "Số PO: ${state.goodsReceipt.lots[index].purchaseOrderNumber ?? '...'}"),
                                                  // Text(
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     style: TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.w100,
                                                  //       fontSize: 16 *
                                                  //           SizeConfig
                                                  //               .ratioFont,
                                                  //       color: Colors.black,
                                                  //     ),
                                                  //     "HSD: ${state.goodsReceipt.lots[index].expirationDate ?? '...'}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        isThreeLine: true,
                                        onTap: () {
                                          BlocProvider.of<FillReceiptLotBloc>(
                                                  context)
                                              .add(RefillReceiptLotEvent(
                                                  DateTime.now(),
                                                  state.goodsReceipt,
                                                  index));
                                          Navigator.pushNamed(
                                            context,
                                            '/update_lot_receipt_screen',
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                })),                     
                        CustomizedButton(
                            text: "Thêm lô",
                            onPressed: () {
                              //  _showForm('', state.items);
                              BlocProvider.of<FillInfoNewReceiptLotBloc>(context)
                                  .add(FillNewReceiptLotEvent(
                                DateTime.now(),
                                goodsReceipt,
                                -1,
                              ));
                              Navigator.pushNamed(
                                context,
                                '/add_receipt_lot_screen',
                              );
                            }),
                        CustomizedButton(
                            text: "Xác nhận",
                            onPressed: () {
                              BlocProvider.of<ExportingReceiptLotBloc>(context)
                                  .add(PatchReceiptChangedEvent(
                                      DateTime.now(), state.goodsReceipt));
                 
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
                  } else {
                    return const Dialog(
                      // The background color
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
