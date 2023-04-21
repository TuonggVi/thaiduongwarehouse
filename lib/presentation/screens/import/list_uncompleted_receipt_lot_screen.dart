// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import '../../../function.dart';
import '../../bloc/blocs/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import '../../bloc/blocs/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import '../../bloc/events/receipt_event/fill_info_receipt_lot_event.dart';
import '../../bloc/states/receipt_state/uncompleted_receipt_lot_state.dart';

class ListUncompletedLotReceiptScreen extends StatefulWidget {
  const ListUncompletedLotReceiptScreen({super.key});

  @override
  State<ListUncompletedLotReceiptScreen> createState() =>
      _ListUncompletedLotReceiptScreenState();
}

class _ListUncompletedLotReceiptScreenState
    extends State<ListUncompletedLotReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool showExpand = false;

    return Scaffold(
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
          'Danh sách lô chưa hoàn thành',
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
                if (state is UpdateReceiptLotSuccessState) {}
              },
              builder: (context, state) {
                if (state is UpdateReceiptLotSuccessState) {
                  return SizedBox(
                      height: 470 * SizeConfig.ratioHeight,
                      child: ListView.builder(
                          itemCount: state.goodsReceipt.lots.length,
                          itemBuilder: (BuildContext context, int index) {
                            return
                                // LotDetailComponent(
                                //   lotid: state.goodsReceipt.lots[index].goodsReceiptLotId
                                //       .toString(),
                                //   itemId:
                                //      state.goodsReceipt.lots[index].itemId.toString(),
                                //   location:
                                //       state.goodsReceipt.lots[index].location.toString(),
                                //   enableEdit: true,
                                //   unit: '',
                                //   quantity: double.parse(
                                //       state.goodsReceipt.lots[index].quantity.toString()),
                                //   sublotSize: double.parse(state.goodsReceipt.lots[index].sublotSize
                                //       .toString()),
                                //   onPressed: () {
                                //     BlocProvider.of<FillReceiptLotBloc>(context)
                                //         .add(FillReceiptLotEvent(DateTime.now(),
                                //             state.goodsReceipt, index, false));
                                //     Navigator.pushNamed(
                                //       context,
                                //       '/fill_lot_receipt_screen',
                                //     );
                                //   });
                                Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: const Icon(Icons.list),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                trailing: Icon(Icons.arrow_drop_down_sharp,
                                    size: 15 * SizeConfig.ratioFont),
                                title: Text(
                                    "Mã lô : ${state.goodsReceipt.lots[index].goodsReceiptLotId}"),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Sản phẩm : ${state.goodsReceipt.lots[index].itemId.toString()}  \nSố lượng : ${state.goodsReceipt.lots[index].quantity.toString().toString()} \nVị trí : ${state.goodsReceipt.lots[index].location.toString()}"),
                                    Text(
                                        "Số PO : ${state.goodsReceipt.lots[index].purchaseOrderNumber.toString()} \nĐịnh mức : ${state.goodsReceipt.lots[index].sublotSize.toString()}"),
                                  ],
                                ),
                                isThreeLine: true,
                                onTap: () {
                                  BlocProvider.of<FillReceiptLotBloc>(context)
                                      .add(FillReceiptLotEvent(DateTime.now(),
                                          state.goodsReceipt, index, false));
                                  Navigator.pushNamed(
                                    context,
                                    '/fill_lot_receipt_screen',
                                  );
                                },
                              ),
                            );
                          }));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}