// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_receipt_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/uncompleted_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/fill_info_receipt_lot_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/barcode_input_widget.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/customized_date_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../bloc/blocs/other/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import '../../../dialog/dialog_one_button.dart';
// cập nhật thông tin chi tiết danh sách lô chưa hoàn thành
class UpdateInfoLotReceiptScreen extends StatefulWidget {
  const UpdateInfoLotReceiptScreen({super.key});

  @override
  State<UpdateInfoLotReceiptScreen> createState() =>
      _UpdateInfoLotReceiptScreenState();
}

class _UpdateInfoLotReceiptScreenState
    extends State<UpdateInfoLotReceiptScreen> {
      
//  Item? selectedItem;
  String unit = '';
  
  GoodsReceiptLotModel goodsReceiptLot = GoodsReceiptLotModel(
      '', null, null, null, null, null, null, '', null, null, null);
  var quantity = TextEditingController();
  var sublotSize = TextEditingController();
  // String lotId = '', poNumber = '';
  // double sublotSize = 0, quantity = 0;
  // DateTime productionDate = DateFormat('yyyy-MM-dd').parse('');
  // DateTime expiredDate = DateFormat('yyyy-MM-dd').parse('');

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
       onWillPop: () async {
        Navigator.pushNamed(context, "/importing_receipt_lot_screen");
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/importing_receipt_lot_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Nhập kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: BlocConsumer<FillReceiptLotBloc, FillInfoReceiptLotState>(
          listener: (context, state) {
            if (state is LoadItemDataSuccessState) {
              if (state.index != -1) {
                //goodsReceiptLot = state.lots[state.index];
                // print(state.lots[state.index]);
                // print('và');
                // print(goodsReceiptLot);
              }
            }
          },
          builder: (context, state) {
            if (state is LoadItemDataSuccessState) {
              if (state.index != -1) {
               goodsReceiptLot = state.goodsReceipt.lots[state.index] as GoodsReceiptLotModel;
              }
              return SingleChildScrollView(
                reverse: true,
                
                child: Container(
                  // height: 300*SizeConfig.ratioHeight,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BarcodeinputWidget(
                        textController: goodsReceiptLot.goodsReceiptLotId,
                        textLabel: "Mã lô",
                        onChange: ((data) {
                          //   goodsReceiptLot.goodsReceiptLotId = data;
                        }),
                        onScan: ((data) {
                          //  goodsReceiptLot.goodsReceiptLotId = data;
                        }),
                      ),
                      SizedBox(
                        width: 350 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: state.items.map((e) => e.itemId).toList(),
                          showSearchBox: true,
                          label: "Mã hàng",
                          // hint: "country in menu mode",
                          onChanged: (value) {
                            //  print(value);
                            // setState(() {
                            //   goodsReceiptLot.item = state.items.firstWhere(
                            //       (element) => element.itemId == value);
                            //   goodsReceiptLot.item!.itemId = value.toString();
                            // });
                          },
                          selectedItem: goodsReceiptLot.item == null
                              ? ''
                              : goodsReceiptLot.item!.itemId,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state.items.map((e) => e.itemName).toList(),
                            showSearchBox: true,
                            label: "Tên hàng",
                            // hint: "country in menu mode",
                            onChanged: (value) {
                              //  print(value);
                              // setState(() {
                              //   goodsReceiptLot.item = state.items.firstWhere(
                              //       (element) => element.itemName == value);
                              //   goodsReceiptLot.item!.itemId =
                              //       goodsReceiptLot.item!.itemId;
                              // });
                            },
                            selectedItem: goodsReceiptLot.item == null
                                ? ''
                                : goodsReceiptLot.item!.itemName,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 350 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items:
                              state.items.map((e) => e.unit!.toString()).toList(),
                          showSearchBox: true,
                          label: "Đơn vị",
                          // hint: "country in menu mode",
                          onChanged: (value) {
                            //  print(value);
                            setState(() {
                              unit = value.toString();
                            });
                          },
                          selectedItem: goodsReceiptLot.item == null
                              ? ''
                              : goodsReceiptLot.item!.unit!,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [                      
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 160 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              controller:
                              // quantity,
                              TextEditingController(
                                  text: goodsReceiptLot.quantity == null
                                      ? ''
                                      : goodsReceiptLot.quantity.toString()),                         
                              onSubmitted: (value) => value != ''
                                  ? goodsReceiptLot.quantity = double.parse(value)
                                  : goodsReceiptLot.quantity = double.parse('0'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  // filled: true,
                                  // fillColor: Constants.buttonColor,
                                  labelStyle: TextStyle(
                                      fontSize: 15 * SizeConfig.ratioFont),
                                  labelText: "Tổng lượng"),
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ],
                              onChanged: (value) =>
                                  goodsReceiptLot.quantity = double.parse(value),
                            ),
                          ),
                            Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 160 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              controller: 
                              //sublotSize,
                               TextEditingController(
                                  text: goodsReceiptLot.sublotSize == null
                                      ? ''
                                      : goodsReceiptLot.sublotSize.toString()),
                              // state.index == -1
                              //     ? TextEditingController()
                              //     : TextEditingController(
                              //         text: goodsReceiptLot.sublotSize
                              //             .toString()),
                              onSubmitted: (value) => value != ''
                                  ? goodsReceiptLot.sublotSize =
                                      double.parse(value)
                                  : goodsReceiptLot.sublotSize =
                                      double.parse('0'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  // filled: true,
                                  // fillColor: Constants.buttonColor,
                                  labelStyle: TextStyle(
                                      fontSize: 15 * SizeConfig.ratioFont),
                                  labelText: "Định mức "),
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ],
                              onChanged: (value) => goodsReceiptLot.sublotSize =
                                  double.parse(value),
                            ),
                          ),
                        ],
                      ),
                      // -- bỏ cập nhật vị trí cho mobile
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     SizedBox(
                      //       width: 175 * SizeConfig.ratioWidth,
                      //       height: 80 * SizeConfig.ratioHeight,
                      //       child: CustomizeDatePicker(
                      //         name: "NSX",
                      //         fontColor: Colors.black,
                      //         fontWeight: FontWeight.normal,
                      //         initDateTime: goodsReceiptLot.productionDate == null
                      //             ? DateFormat('yyyy-MM-dd')
                      //                 .parse(DateTime.now().toString())
                      //             : goodsReceiptLot.productionDate as DateTime,
                      //         okBtnClickedFunction: (pickedTime) {
                      //           goodsReceiptLot.productionDate = pickedTime;
                      //         },
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 175 * SizeConfig.ratioWidth,
                      //       height: 80 * SizeConfig.ratioHeight,
                      //       child: CustomizeDatePicker(
                      //         name: "HSD",
                      //         fontColor: Colors.black,
                      //         fontWeight: FontWeight.normal,
                      //         initDateTime: goodsReceiptLot.expirationDate == null
                      //             ? DateFormat('yyyy-MM-dd')
                      //                 .parse(DateTime.now().toString())
                      //             : goodsReceiptLot.expirationDate as DateTime,
                      //         okBtnClickedFunction: (pickedTime) {
                      //           goodsReceiptLot.expirationDate = pickedTime;
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // BarcodeinputWidget(
                      //   textController: goodsReceiptLot.location == null
                      //       ? ''
                      //       : goodsReceiptLot.location.toString(),
                      //   textLabel: "Vị trí",
                      //   onChange: ((data) {
                      //     goodsReceiptLot.location = data;
                      //   }),
                      //   onScan: ((data) {
                      //     goodsReceiptLot.location = data;
                      //   }),
                      // ),

                    

                   
                      // Row(children: [
                      //   Text(
                      //     overflow: TextOverflow.ellipsis,
                      //     "Đối với thành phẩm",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 20 * SizeConfig.ratioFont,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      //   Expanded(
                      //     child: Container(
                      //         margin:
                      //             const EdgeInsets.only(left: 20.0, right: 10.0),
                      //         child: const Divider(
                      //           color: Colors.black,
                      //           height: 36,
                      //         )),
                      //   ),
                      // ]),
                      // Container(
                      //   width: 350 * SizeConfig.ratioWidth,
                      //   height: 60 * SizeConfig.ratioHeight,
                      //   margin: EdgeInsets.symmetric(
                      //       vertical: 5 * SizeConfig.ratioHeight),
                      //   child: TextField(
                      //     controller: TextEditingController(
                      //         text: goodsReceiptLot.purchaseOrderNumber),
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(5)),
                      //         // filled: true,
                      //         // fillColor: Constants.buttonColor,
                      //         labelText: "Nhập số PO"),
                      //     onChanged: (value) =>
                      //         goodsReceiptLot.purchaseOrderNumber = value,
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: () async {
                          if (goodsReceiptLot.goodsReceiptLotId == '' ||
                              goodsReceiptLot.item!.itemId == '' ||
                              goodsReceiptLot.quantity == null) {
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Cảnh báo",
                                    "Vui lòng điền đầy đủ các thông tin trong phần bắt buộc",
                                    "Trở lại",
                                    '', () {
                              // Navigator.pushNamed(
                              //   context,
                              //   '/fill_main_info_issue_screen',
                              // );
                            }, 18, 22, () {}, false)
                                .show();
                          } else {
                            BlocProvider.of<ExportingReceiptLotBloc>(context).add(
                                UpdateReceiptLotEvent(state.index,
                                    goodsReceiptLot, state.goodsReceipt));
                            Navigator.pushNamed(
                                context, '/importing_receipt_lot_screen');
                          }
                        },
                        child: const Text('Cập nhật'),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}