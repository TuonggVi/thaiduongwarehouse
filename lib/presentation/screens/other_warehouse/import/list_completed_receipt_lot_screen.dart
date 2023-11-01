import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/completed_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/completed_receipt_lot_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';
import '../../../../function.dart';

// danh sách các lô hàng đã hoàn thành
class ListCompletedLotReceiptScreen extends StatelessWidget {
  const ListCompletedLotReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/imported_receipt_screen");
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
              Navigator.pushNamed(context, '/imported_receipt_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Danh sách lô đã nhập',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: BlocBuilder<CompletedReceiptLotBloc, CompletedReceiptLotState>(
            builder: (context, state) {
          if (state is LoadGoodsReceiptLotSuccessState) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "Danh sách các lô hàng",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25 * SizeConfig.ratioFont,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Constants.mainColor,
                    thickness: 1,
                  ),
                  SizedBox(
                      height: 470 * SizeConfig.ratioHeight,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:  MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        
                                   
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Mã lô : ${state.goodsReceipt.lots[index].goodsReceiptLotId}"),
                                                Icon(Icons.edit,
                                            size: 15 * SizeConfig.ratioFont),
                                          ],
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
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
                                                      "Số lượng: ${state.goodsReceipt.lots[index].quantity}"),
                                                
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
                                                      "NSX: ${state.goodsReceipt.lots[index].productionDate ?? '...'}"),
                                                  Text(
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .ratioFont,
                                                        color: Colors.black,
                                                      ),
                                                      "HSD: ${state.goodsReceipt.lots[index].expirationDate ?? '...'}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        isThreeLine: true,
                                        onTap: () {
                                          // BlocProvider.of<FillReceiptLotBloc>(context)
                                          //     .add(FillReceiptLotEvent(DateTime.now(),
                                          //         state.goodsReceipt, index, false));
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   '/fill_lot_receipt_screen',
                                          // );
                                        },
                                      ),
                                     
                                     ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: state
                                                        .goodsReceipt
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
                                                                  "Vị trí: ${state.goodsReceipt.lots[index].goodsReceiptSublots[index1].locationId}",
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
                                                                    "Số lượng: ${state.goodsReceipt.lots[index].goodsReceiptSublots[index1].quantityPerLocation}"),
                                                              ),
                                                            ]),
                                  
                                                      );
                                                    },
                                                  ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                  // CustomizedButton(text: "Truy xuất", onPressed: () {})
                  CustomizedButton(
                      text: "Trở lại",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/imported_receipt_screen');
                      })
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
