// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/create_new_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/create_new_receipt_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/fill_info_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/create_new_receipt_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/exception_widget.dart';
import '../../../dialog/dialog_one_button.dart';

// trang tạo phiếu nhập kho, nhập mã ncc và số phiếu
class CreateNewReceiptScreen extends StatefulWidget {
  const CreateNewReceiptScreen({super.key});

  @override
  State<CreateNewReceiptScreen> createState() => _CreateNewReceiptScreenState();
}

class _CreateNewReceiptScreenState extends State<CreateNewReceiptScreen> {
  GoodsReceipt goodsReceipt =
      GoodsReceipt('', '', [], DateTime.now(), null, false);
  var receiptId = TextEditingController();
  var supplyId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/main_receipt_screen");
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/main_receipt_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Nhập kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: BlocConsumer<CreateReceiptBloc, CreateReceiptState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AddLotToGoodsReceiptStateLoading ||
                state is UpdateLotReceiptStateLoading ||
                state is PostReceiptStateLoadingState) {
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
            if (state is PostReceiptStateSuccess) {
              return Center(
                child: Column(
                  children: [
                    ExceptionErrorState(
                      icon: Icons.check_box_outlined,
                      title: "Thành công",
                      message: "Đã tạo đơn nhập kho",
                    ),
                    CustomizedButton(
                        text: "Trở về",
                        onPressed: () {
                          // reset lại trang tạo phiếu
                          BlocProvider.of<CreateReceiptBloc>(context)
                              .add(UpdateReceiptFailEvent(
                            DateTime.now(),
                            GoodsReceipt('', '', [], null, null, false),
                          ));
                          Navigator.pushNamed(
                            context,
                            '/main_receipt_screen',
                          );
                        }),
                  ],
                ),
              );
            } else if (state is PostReceiptStateFailure) {
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
                          BlocProvider.of<CreateReceiptBloc>(context)
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
                          BlocProvider.of<CreateReceiptBloc>(context)
                              .add(UpdateReceiptFailEvent(
                            DateTime.now(),
                            // tạo mới goodReiceip với các trường thông tin chưa được điền
                            GoodsReceipt('', '', [], null, null, false),
                          ));
                          Navigator.pushNamed(
                            context,
                            '/main_receipt_screen',
                          );
                        }),
                  ],
                ),
              );
            } else if (state is UpdateLotReceiptStateSuccess ||
                state is PostReceiptStateFailure) {
              goodsReceipt = state.goodsReceipt as GoodsReceipt;
              receiptId.text = goodsReceipt.goodsReceiptId.toString();
              supplyId.text = goodsReceipt.supply.toString();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10 * SizeConfig.ratioHeight,
                  ),
                  Container(
                    width: 350 * SizeConfig.ratioWidth,
                    height: 60 * SizeConfig.ratioHeight,
                    margin: EdgeInsets.symmetric(
                        vertical: 5 * SizeConfig.ratioHeight),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          // filled: true,
                          // fillColor: Constants.buttonColor,
                          labelText: "Mã NCC (nếu có)"),
                      controller: supplyId,
                      onChanged: (value) => {
                        goodsReceipt.supply = value,
                        receiptId.text =
                            "${DateFormat('yyMMdd').format(DateTime.now())}-$value",
                        goodsReceipt.goodsReceiptId = receiptId.text,
                      },
                    ),
                  ),
                  Container(
                    width: 350 * SizeConfig.ratioWidth,
                    height: 60 * SizeConfig.ratioHeight,
                    margin: EdgeInsets.symmetric(
                        vertical: 5 * SizeConfig.ratioHeight),
                    child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            // filled: true,
                            // fillColor: Constants.buttonColor,
                            labelText: "Số phiếu"),
                        controller: receiptId,
                        onChanged: (value) {
                          goodsReceipt.goodsReceiptId = value;
                        }),
                  ),
                  // const Divider(
                  //   indent: 30,
                  //   endIndent: 30,
                  //   color: Constants.mainColor,
                  //   thickness: 1,
                  // ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    "Danh sách các lô hàng",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20 * SizeConfig.ratioFont,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 330 * SizeConfig.ratioHeight,
                    child: ListView.builder(
                        itemCount: state.goodsReceipt!.lots.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                trailing: Icon(Icons.edit,
                                    size: 17 * SizeConfig.ratioFont),
                                title: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                                  child: Text(
                                    "Mã lô : ${state.goodsReceipt?.lots[index].goodsReceiptLotId}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16 * SizeConfig.ratioFont,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 130 * SizeConfig.ratioWidth,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize:
                                                    16 * SizeConfig.ratioFont,
                                                color: Colors.black,
                                              ),
                                              "Mã SP: ${state.goodsReceipt?.lots[index].item!.itemId}"),
                                          Text(
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize:
                                                    16 * SizeConfig.ratioFont,
                                                color: Colors.black,
                                              ),
                                              "Số lượng: ${state.goodsReceipt?.lots[index].quantity}"),
                                          Text(
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize:
                                                    16 * SizeConfig.ratioFont,
                                                color: Colors.black,
                                              ),
                                              "NSX: ${state.goodsReceipt?.lots[index].productionDate ?? '...'}"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 130 * SizeConfig.ratioWidth,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize:
                                                    16 * SizeConfig.ratioFont,
                                                color: Colors.black,
                                              ),
                                              "Tên hàng: ${state.goodsReceipt?.lots[index].item!.itemName}"),
                                          Text(
                                              style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize:
                                                    16 * SizeConfig.ratioFont,
                                                color: Colors.black,
                                              ),
                                              "HSD: ${state.goodsReceipt?.lots[index].expirationDate ?? '...'}"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                                onTap: () {
                                  BlocProvider.of<FillReceiptLotBloc>(context)
                                      .add(FillReceiptLotEvent(
                                          DateTime.now(),
                                          state.goodsReceipt as GoodsReceipt,
                                          index));
                                  Navigator.pushNamed(
                                    context,
                                    '/fill_lot_receipt_screen',
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                  CustomizedButton(
                      text: "Tiếp tục",
                      onPressed: () {
                        BlocProvider.of<FillReceiptLotBloc>(context)
                            .add(FillReceiptLotEvent(
                          DateTime.now(),
                          state.goodsReceipt as GoodsReceipt,
                          -1,
                        ));
                        Navigator.pushNamed(
                          context,
                          '/fill_lot_receipt_screen',
                        );
                      }),
                  CustomizedButton(
                      text: "Hoàn thành",
                      onPressed: () {
                        //  _showForm('', state.items);

                        state.goodsReceipt!.goodsReceiptId == ''
                            ? AlertDialogOneBtnCustomized(
                                    context,
                                    'Cảnh báo',
                                    'Vui lòng nhập Mã đơn',
                                    'Tiếp tục',
                                    'warning_image.png',
                                    () {},
                                    15,
                                    29,
                                    () {},
                                    false)
                                .show()
                            : BlocProvider.of<CreateReceiptBloc>(context).add(
                                PostNewReceiptEvent(DateTime.now(),
                                    state.goodsReceipt as GoodsReceipt));
                      })
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 5 * SizeConfig.ratioHeight),
                    width: 350 * SizeConfig.ratioWidth,
                    height: 60 * SizeConfig.ratioHeight,
                    margin: EdgeInsets.symmetric(
                        vertical: 5 * SizeConfig.ratioHeight),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          labelText: "Mã NCC (nếu có)"),
                      controller: supplyId,
                      onChanged: (value) => {
                        goodsReceipt.supply = value,
                        receiptId.text =
                            "${DateFormat('yyMMdd').format(DateTime.now())}-$value",
                        goodsReceipt.goodsReceiptId = receiptId.text,
                      },
                    ),
                  ),
                  Container(
                    width: 350 * SizeConfig.ratioWidth,
                    height: 60 * SizeConfig.ratioHeight,
                    margin: EdgeInsets.symmetric(
                        vertical: 5 * SizeConfig.ratioHeight),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          // filled: true,
                          // fillColor: Constants.buttonColor,
                          labelText: "Số phiếu"),
                      controller: receiptId,
                      onChanged: (value) => goodsReceipt.goodsReceiptId = value,
                    ),
                  ),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Constants.mainColor,
                    thickness: 1,
                  ),
                  Center(
                    child: Center(
                      child: ExceptionErrorState(
                        title: "Chưa có lô hàng được nhập",
                        message: "Chọn Tiếp tục để nhập kho",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: CustomizedButton(
                        text: "Tiếp tục",
                        onPressed: () {
                          //  _showForm('', state.items);
                          BlocProvider.of<FillReceiptLotBloc>(context)
                              .add(FillReceiptLotEvent(
                            DateTime.now(),
                            goodsReceipt,
                            -1,
                          ));
                          Navigator.pushNamed(
                            context,
                            '/fill_lot_receipt_screen',
                          );
                        }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
