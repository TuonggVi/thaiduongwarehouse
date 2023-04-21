// ignore_for_file: deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/create_new_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/receipt_event/create_new_receipt_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/receipt_event/uncompleted_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/receipt_state/fill_info_receipt_lot_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/barcode_input_widget.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/customized_date_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../bloc/blocs/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import '../../dialog/dialog_one_button.dart';

class FillInfoLotReceiptScreen extends StatefulWidget {
  const FillInfoLotReceiptScreen({super.key});

  @override
  State<FillInfoLotReceiptScreen> createState() =>
      _FillInfoLotReceiptScreenState();
}

class _FillInfoLotReceiptScreenState extends State<FillInfoLotReceiptScreen> {
  Item? selectedItem;
  String unit = '';
  GoodsReceiptLot goodsReceiptLot =
      GoodsReceiptLot('', '', null, null, null, null, '', null, null);
  // String lotId = '', poNumber = '';
  // double sublotSize = 0, quantity = 0;
  // DateTime productionDate = DateFormat('yyyy-MM-dd').parse('');
  // DateTime expiredDate = DateFormat('yyyy-MM-dd').parse('');

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
            Navigator.pushNamed(context, '/create_receipt_screen');
          },
        ),
        backgroundColor: Constants.mainColor,
        title: Text(
          'Nhập kho',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      // body: BlocConsumer<FillReceiptLotBloc, FillInfoReceiptLotState>(
      //   listener: (context, state) {
      //     if (state is LoadItemDataSuccessState) {
      //       if (state.index != -1) {
      //         //goodsReceiptLot = state.lots[state.index];
      //         // print(state.lots[state.index]);
      //         // print('và');
      //         // print(goodsReceiptLot);
      //       }
      //     }
      //   },
      //   builder: (context, state) {
      //     if (state is LoadItemDataSuccessState) {
      //       if (state.index != -1) {
      //         goodsReceiptLot = state.goodsReceipt.lots[state.index];
      //       }
      //       return SingleChildScrollView(
      //         child: Container(
      //           // height: 300*SizeConfig.ratioHeight,
      //           alignment: Alignment.center,
      //           padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               BarcodeinputWidget(
      //                 textController: goodsReceiptLot.goodsReceiptLotId,
      //                 textLabel: "Mã lô",
      //                 onChange: ((data) {
      //                   goodsReceiptLot.goodsReceiptLotId = data;
      //                 }),
      //                 onScan: ((data) {
      //                   goodsReceiptLot.goodsReceiptLotId = data;
      //                 }),
      //               ),
      //               SizedBox(
      //                 width: 350 * SizeConfig.ratioWidth,
      //                 height: 60 * SizeConfig.ratioHeight,
      //                 child: DropdownSearch<String>(
      //                   mode: Mode.MENU,
      //                   items: state.items.map((e) => e.itemId).toList(),
      //                   showSearchBox: true,
      //                   label: "Mã sản phẩm",
      //                   // hint: "country in menu mode",
      //                   onChanged: (value) {
      //                     //  print(value);
      //                     setState(() {
      //                       selectedItem = state.items.firstWhere(
      //                           (element) => element.itemId == value);
      //                       goodsReceiptLot.itemId = value.toString();
      //                     });
      //                   },
      //                   selectedItem:
      //                       selectedItem == null ? '' : selectedItem!.itemId,
      //                   //  goodsReceiptLot.itemId
      //                   // state.index == -1
      //                   //     ? goodsReceiptLot.itemId
      //                   //     : state.lots[state.index].itemId.toString(),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: SizedBox(
      //                   width: 350 * SizeConfig.ratioWidth,
      //                   height: 60 * SizeConfig.ratioHeight,
      //                   child: DropdownSearch<String>(
      //                     mode: Mode.MENU,
      //                     items: state.items.map((e) => e.itemName).toList(),
      //                     showSearchBox: true,
      //                     label: "Tên sản phẩm",
      //                     // hint: "country in menu mode",
      //                     onChanged: (value) {
      //                       //  print(value);
      //                       setState(() {
      //                         selectedItem = state.items.firstWhere(
      //                             (element) => element.itemName == value);
      //                         goodsReceiptLot.itemId = selectedItem!.itemId;
      //                       });
      //                     },
      //                     selectedItem: selectedItem == null
      //                         ? ''
      //                         : selectedItem!.itemName,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: 350 * SizeConfig.ratioWidth,
      //                 height: 60 * SizeConfig.ratioHeight,
      //                 child: DropdownSearch<String>(
      //                   mode: Mode.MENU,
      //                   items: state.items
      //                       .map((e) => e.unit!.name.toString())
      //                       .toList(),
      //                   showSearchBox: true,
      //                   label: "Đơn vị",
      //                   // hint: "country in menu mode",
      //                   onChanged: (value) {
      //                     //  print(value);
      //                     setState(() {
      //                       unit = value.toString();
      //                     });
      //                   },
      //                   selectedItem: selectedItem == null
      //                       ? ''
      //                       : selectedItem!.unit!.name,
      //                 ),
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: [
      //                   Container(
      //                     padding: EdgeInsets.symmetric(
      //                         vertical: 5 * SizeConfig.ratioHeight),
      //                     alignment: Alignment.centerRight,
      //                     width: 160 * SizeConfig.ratioWidth,
      //                     height: 60 * SizeConfig.ratioHeight,
      //                     //color: Colors.grey[200],
      //                     child: TextField(
      //                       controller: TextEditingController(
      //                           text: goodsReceiptLot.sublotSize == null
      //                               ? ''
      //                               : goodsReceiptLot.sublotSize.toString()),
      //                       // state.index == -1
      //                       //     ? TextEditingController()
      //                       //     : TextEditingController(
      //                       //         text: goodsReceiptLot.sublotSize
      //                       //             .toString()),
      //                       onSubmitted: (value) => goodsReceiptLot.sublotSize =
      //                           double.parse(value),
      //                       decoration: InputDecoration(
      //                           border: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(5)),
      //                           // filled: true,
      //                           // fillColor: Constants.buttonColor,
      //                           labelStyle: TextStyle(
      //                               fontSize: 15 * SizeConfig.ratioFont),
      //                           labelText: "Định mức "),
      //                       keyboardType: const TextInputType.numberWithOptions(
      //                           decimal: true),
      //                       inputFormatters: [
      //                         FilteringTextInputFormatter.allow(
      //                             RegExp('[0-9.,]')),
      //                       ],
      //                       // onChanged: (value) => goodsReceiptLot.sublotSize =
      //                       //     double.parse(value),
      //                     ),
      //                   ),
      //                   Container(
      //                     padding: EdgeInsets.symmetric(
      //                         vertical: 5 * SizeConfig.ratioHeight),
      //                     alignment: Alignment.centerRight,
      //                     width: 160 * SizeConfig.ratioWidth,
      //                     height: 60 * SizeConfig.ratioHeight,
      //                     //color: Colors.grey[200],
      //                     child: TextField(
      //                       controller: TextEditingController(
      //                           text: goodsReceiptLot.quantity == null
      //                               ? ''
      //                               : goodsReceiptLot.quantity.toString()),
      //                       // state.index == -1
      //                       //     ? TextEditingController()
      //                       //     :
      //                       // TextEditingController(
      //                       //         text: goodsReceiptLot.sublotSize
      //                       //             .toString()),
      //                       onSubmitted: (value) =>
      //                           goodsReceiptLot.quantity = double.parse(value),
      //                       decoration: InputDecoration(
      //                           border: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(5)),
      //                           // filled: true,
      //                           // fillColor: Constants.buttonColor,
      //                           labelStyle: TextStyle(
      //                               fontSize: 15 * SizeConfig.ratioFont),
      //                           labelText: "Tổng lượng"),
      //                       keyboardType: const TextInputType.numberWithOptions(
      //                           decimal: true),
      //                       inputFormatters: [
      //                         FilteringTextInputFormatter.allow(
      //                             RegExp('[0-9.,]')),
      //                       ],
      //                       // onChanged: (value) =>
      //                       //     goodsReceiptLot.quantity = double.parse(value),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: [
      //                   Container(
      //                     // padding: EdgeInsets.symmetric(
      //                     //     vertical: 5 * SizeConfig.ratioHeight),
      //                     margin: EdgeInsets.symmetric(
      //                         vertical: 5 * SizeConfig.ratioHeight),
      //                     width: 160 * SizeConfig.ratioWidth,
      //                     height: 60 * SizeConfig.ratioHeight,
      //                     // padding: EdgeInsets.symmetric(
      //                     //     vertical: 5 * SizeConfig.ratioHeight),
      //                     // decoration: BoxDecoration(
      //                     //     color: Constants.buttonColor,
      //                     //     border: Border.all(
      //                     //         width: 1, color: Constants.buttonColor),
      //                     //     borderRadius:
      //                     //         const BorderRadius.all(Radius.circular(5))),
      //                     child: CustomizeDatePicker(
      //                       name: "NSX",
      //                       fontColor: Colors.black,
      //                       fontWeight: FontWeight.normal,
      //                       initDateTime: goodsReceiptLot.productionDate == null
      //                           ? DateFormat('yyyy-MM-dd')
      //                               .parse(DateTime.now().toString())
      //                           : goodsReceiptLot.productionDate as DateTime,
      //                       okBtnClickedFunction: (pickedTime) {
      //                         goodsReceiptLot.productionDate = pickedTime;
      //                       },
      //                     ),
      //                   ),
      //                   Container(
      //                     // padding: EdgeInsets.symmetric(
      //                     //     vertical: 5 * SizeConfig.ratioHeight),
      //                     margin: EdgeInsets.symmetric(
      //                         vertical: 5 * SizeConfig.ratioHeight),
      //                     width: 160 * SizeConfig.ratioWidth,
      //                     height: 60 * SizeConfig.ratioHeight,
      //                     // padding: EdgeInsets.symmetric(
      //                     //     vertical: 5 * SizeConfig.ratioHeight),
      //                     // decoration: BoxDecoration(
      //                     //     color: Constants.buttonColor,
      //                     //     border: Border.all(width: 1, color: Colors.grey),
      //                     //     borderRadius:
      //                     //         const BorderRadius.all(Radius.circular(5))),
      //                     child: CustomizeDatePicker(
      //                       name: "HSD",
      //                       fontColor: Colors.black,
      //                       fontWeight: FontWeight.normal,
      //                       initDateTime: goodsReceiptLot.expirationDate == null
      //                           ? DateFormat('yyyy-MM-dd')
      //                               .parse(DateTime.now().toString())
      //                           : goodsReceiptLot.expirationDate as DateTime,
      //                       okBtnClickedFunction: (pickedTime) {
      //                         goodsReceiptLot.expirationDate = pickedTime;
      //                       },
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               BarcodeinputWidget(
      //                 textController: goodsReceiptLot.location.toString(),
      //                 textLabel: "Vị trí",
      //                 onChange: ((data) {
      //                   goodsReceiptLot.location = data;
      //                 }),
      //                 onScan: ((data) {
      //                   goodsReceiptLot.location = data;
      //                 }),
      //               ),
      //               Row(children: [
      //                 Text(
      //                   overflow: TextOverflow.ellipsis,
      //                   "Đối với thành phẩm",
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.w600,
      //                     fontSize: 20 * SizeConfig.ratioFont,
      //                     color: Colors.black,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                       margin:
      //                           const EdgeInsets.only(left: 20.0, right: 10.0),
      //                       child: const Divider(
      //                         color: Colors.black,
      //                         height: 36,
      //                       )),
      //                 ),
      //               ]),
      //               Container(
      //                 width: 350 * SizeConfig.ratioWidth,
      //                 height: 60 * SizeConfig.ratioHeight,
      //                 margin: EdgeInsets.symmetric(
      //                     vertical: 5 * SizeConfig.ratioHeight),
      //                 child: TextField(
      //                   controller: TextEditingController(
      //                       text: goodsReceiptLot.purchaseOrderNumber),
      //                   // state.index == -1
      //                   //     ? TextEditingController()
      //                   //     : TextEditingController(
      //                   //         text: state
      //                   //             .lots[state.index].purchaseOrderNumber
      //                   //             .toString(),
      //                   //       ),
      //                   decoration: InputDecoration(
      //                       border: OutlineInputBorder(
      //                           borderRadius: BorderRadius.circular(5)),
      //                       // filled: true,
      //                       // fillColor: Constants.buttonColor,
      //                       labelText: "Nhập số PO"),
      //                   onChanged: (value) =>
      //                       goodsReceiptLot.purchaseOrderNumber = value,
      //                 ),
      //               ),
      //               ElevatedButton(
      //                 onPressed: () async {
      //                   if (goodsReceiptLot.goodsReceiptLotId == '' ||
      //                       goodsReceiptLot.itemId == '' ||
      //                       goodsReceiptLot.quantity == null) {
      //                     AlertDialogOneBtnCustomized(
      //                             context,
      //                             "Cảnh báo",
      //                             "Vui lòng điền đầy đủ các thông tin trong phần bắt buộc",
      //                             "Trở lại", () {
      //                       // Navigator.pushNamed(
      //                       //   context,
      //                       //   '/fill_main_info_issue_screen',
      //                       // );
      //                     }, 18, 22, () {}, false)
      //                         .show();
      //                   } else {
      //                     state.function
      //                         ? {
      //                             state.index == -1
      //                                 ? {
      //                                     BlocProvider.of<CreateReceiptBloc>(
      //                                             context)
      //                                         .add(AddLotToGoodsReceiptEvent(
      //                                             goodsReceiptLot,
      //                                             state.goodsReceipt)),
      //                                     Navigator.pushNamed(
      //                                         context, '/create_receipt_screen')
      //                                   }
      //                                 : {
      //                                     BlocProvider.of<CreateReceiptBloc>(
      //                                             context)
      //                                         .add(UpdateLotReceiptEvent(
      //                                             goodsReceiptLot,
      //                                             state.goodsReceipt,
      //                                             state.index)),
      //                                     Navigator.pushNamed(context,
      //                                         '/create_receipt_screen'),
      //                                   },
      //                           }
      //                         : {
      //                             BlocProvider.of<ExportingReceiptLotBloc>(
      //                                     context)
      //                                 .add(UpdateReceiptLotEvent(state.index,
      //                                     goodsReceiptLot, state.goodsReceipt)),
      //                             Navigator.pushNamed(
      //                                 context, '/importing_receipt_lot_screen')
      //                           };
      //                   }
      //                 },
      //                 child: const Text('Tạo mới'),
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}