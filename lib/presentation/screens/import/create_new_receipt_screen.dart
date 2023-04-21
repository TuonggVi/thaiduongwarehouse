// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/create_new_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/receipt_event/fill_info_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/receipt_state/create_new_receipt_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/exception_widget.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/lot_detail_component.dart';

class CreateNewReceiptScreen extends StatefulWidget {
  const CreateNewReceiptScreen({super.key});

  @override
  State<CreateNewReceiptScreen> createState() => _CreateNewReceiptScreenState();
}

class _CreateNewReceiptScreenState extends State<CreateNewReceiptScreen> {
  // search button
  TextEditingController controller = TextEditingController();
  GoodsReceipt goodsReceipt = GoodsReceipt('', '', const [], DateTime.now(), false);
  var receiptId = TextEditingController();
  var supplyId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
              state is UpdateLotReceiptStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UpdateLotReceiptStateSuccess) {
            goodsReceipt = state.goodsReceipt;
            receiptId.text = goodsReceipt.goodsReceiptId;
            supplyId.text = goodsReceipt.supply;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Text(
                    //   overflow: TextOverflow.ellipsis,
                    //   "Mã NCC",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 20 * SizeConfig.ratioFont,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    // TextInputWidget(contentTextField: supplyId)
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
                        controller: receiptId,
                        onChanged: (value) => {
                          goodsReceipt.goodsReceiptId = value,
                          supplyId.text =
                              "${DateFormat('dd-MM-yy').format(DateTime.now())}-$value"
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Text(
                    //   overflow: TextOverflow.ellipsis,
                    //   "Số phiếu",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 20 * SizeConfig.ratioFont,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    // TextInputWidget(contentTextField: receiptId)
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
                        controller: supplyId,
                        onChanged: (value) => goodsReceipt.supply = value,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  color: Constants.mainColor,
                  thickness: 1,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  "Danh sách các lô hàng",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20 * SizeConfig.ratioFont,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: ((value) {}),
                    controller: controller,
                    decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                SizedBox(
                  height: 300 * SizeConfig.ratioHeight,
                  child: ListView.builder(
                      itemCount: state.goodsReceipt.lots.length,
                      itemBuilder: (BuildContext context, int index) {
                        return
                            // LotDetailComponent(
                            //     lotid: state
                            //         .goodsReceipt.lots[index].goodsReceiptLotId
                            //         .toString(),
                            //     itemId: state.goodsReceipt.lots[index].itemId
                            //         .toString(),
                            //     location: state.goodsReceipt.lots[index].location
                            //         .toString(),
                            //     enableEdit: true,
                            //     unit: '',
                            //     quantity: double.parse(state
                            //         .goodsReceipt.lots[index].quantity
                            //         .toString()),
                            //     sublotSize: double.parse(state
                            //         .goodsReceipt.lots[index].sublotSize
                            //         .toString()),
                            //     onPressed: () {
                            //       BlocProvider.of<FillReceiptLotBloc>(context).add(
                            //           FillReceiptLotEvent(DateTime.now(),
                            //               state.goodsReceipt, index, true));
                            //       Navigator.pushNamed(
                            //         context,
                            //         '/fill_lot_receipt_screen',
                            //       );
                            //     });
                            Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            //  leading: const Icon(Icons.list),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            trailing: Icon(Icons.edit,
                                size: 15 * SizeConfig.ratioFont),
                            title: Text(
                                "Mã lô : ${state.goodsReceipt.lots[index].goodsReceiptLotId}"),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Sản phẩm : ${state.goodsReceipt.lots[index].itemId.toString()} \nSố lượng : ${state.goodsReceipt.lots[index].quantity.toString().toString()} "),
                                Text(
                                    "Số PO : ${state.goodsReceipt.lots[index].sublotSize.toString().toString()} \nĐịnh mức : ${state.goodsReceipt.lots[index].sublotSize.toString().toString()} \nVị trí : ${state.goodsReceipt.lots[index].location.toString()}"),
                              ],
                            ),
                            isThreeLine: true,
                            onTap: () {
                              BlocProvider.of<FillReceiptLotBloc>(context).add(
                                  FillReceiptLotEvent(DateTime.now(),
                                      state.goodsReceipt, index, true));
                              Navigator.pushNamed(
                                context,
                                '/fill_lot_receipt_screen',
                              );
                            },
                          ),
                        );
                      }),
                ),
                CustomizedButton(
                    text: "Tiếp tục",
                    onPressed: () {
                      BlocProvider.of<FillReceiptLotBloc>(context).add(
                          FillReceiptLotEvent(
                              DateTime.now(), state.goodsReceipt, -1, true));
                      Navigator.pushNamed(
                        context,
                        '/fill_lot_receipt_screen',
                      );
                    })
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                 
                    Container(
                      width: 350 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      margin: EdgeInsets.symmetric(
                          vertical: 5 * SizeConfig.ratioHeight),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          
                            labelText: "Mã NCC (nếu có)"),
                        controller: receiptId,
                        onChanged: (value) => {
                          goodsReceipt.goodsReceiptId = value,
                          supplyId.text =
                              "${DateFormat('dd-MM-yy').format(DateTime.now())}-$value",
                          goodsReceipt.supply = supplyId.text,
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                 
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
                        controller: supplyId,
                        onChanged: (value) => goodsReceipt.supply = value,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  color: Constants.mainColor,
                  thickness: 1,
                ),
                ExceptionErrorState(
                  title: "Chưa có lô hàng được nhập",
                  message: "Chọn Tiếp tục để nhập kho",
                ),
                CustomizedButton(
                    text: "Tiếp tục",
                    onPressed: () {
                      //  _showForm('', state.items);
                      BlocProvider.of<FillReceiptLotBloc>(context).add(
                          FillReceiptLotEvent(
                              DateTime.now(), goodsReceipt, -1, true));
                      Navigator.pushNamed(
                        context,
                        '/fill_lot_receipt_screen',
                      );
                    })
              ],
            );
          }
        },
      ),
    );
  }
//   onSearchTextChanged(String text) async {
//     _searchResult.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }

//     goodsReceiptEntryConainerDataTemp.forEach((userDetail)
//     {
//       if (userDetail.itemId.contains(text)) _searchResult.add(userDetail);
//     });

//     setState(() {});
//   }

//  // List<GoodsReceiptEntryContainerData> _searchResult = [];
}