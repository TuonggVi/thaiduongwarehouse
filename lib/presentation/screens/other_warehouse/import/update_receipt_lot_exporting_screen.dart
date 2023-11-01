// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_receipt_model.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/uncompleted_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/update_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/barcode_input_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../../datasource/models/location_model.dart';
import '../../../../domain/entities/other/goods_receipt.dart';
import '../../../bloc/blocs/other/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import '../../../bloc/blocs/other/receipt_bloc/update_receipt_lot_bloc.dart';
import '../../../bloc/states/other/receipt_state/update_receipt_lot_states.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../widgets/customized_date_picker.dart';

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
  //List<GoodsReceiptSublot> listGoodsReceiptSublot = [];
  GoodsReceiptSublotModel goodsReceiptSublotModel =
      GoodsReceiptSublotModel('', null);

  GoodsReceiptLot goodsReceiptLot =
      GoodsReceiptLot('', '', '', [], null, null, null, null, null, null, null);
  double totalQuantity = 0;
  var quantity = TextEditingController();
  var sublotSize = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  int currentIndex = 1;
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
        body: BlocConsumer<GoodsReceiptSublotBloc, UpdateReceiptLotState>(
          listener: (context, state) {
            if (state is LoadItemDataUpdateSuccessState) {
              if (state.index != -1) {
                //goodsReceiptLot = state.lots[state.index];
                // print(state.lots[state.index]);
                // print('và');
                // print(goodsReceiptLot);
              }
            }
          },
          builder: (context, state) {
            if (state is LoadItemDataUpdateSuccessState) {
         
              if (state.index != -1) {
                goodsReceiptLot = state.goodsReceipt.lots[state.index]
                    as GoodsReceiptLotModel;
                for (int i = 0;
                    i <
                        state.goodsReceipt.lots[state.index].goodsReceiptSublots
                            .length;
                    i++) {
                  goodsReceiptSublotModel = state.goodsReceipt.lots[state.index]
                      .goodsReceiptSublots[i] as GoodsReceiptSublotModel;
                }
              }
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                reverse: true,
                child: Container(
                  // height: 300*SizeConfig.ratioHeight,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              // filled: true,
                              // fillColor: Constants.buttonColor,
                              labelStyle: TextStyle(
                                  fontSize: 15 * SizeConfig.ratioFont),
                              label: const Text("Mã lô cũ"),
                            ),
                            child: Text(
                              goodsReceiptLot.goodsReceiptLotId!,
                              style: (TextStyle(
                                  fontSize: 17.5 * SizeConfig.ratioFont)),
                            ),
                          ),
                        ),
                      ),
               

                      BarcodeinputWidget(
                        textController:
                            goodsReceiptLot.newGoodsReceiptLotId?.isEmpty ??
                                    true
                                ? goodsReceiptLot.goodsReceiptLotId!
                                : goodsReceiptLot.newGoodsReceiptLotId!,
                        textLabel: "Mã lô mới",
                        onChange: (data) {
                          goodsReceiptLot.newGoodsReceiptLotId = data;
                        },
                        onScan: (data) {
                          goodsReceiptLot.newGoodsReceiptLotId = data;
                        },
                      ),

                  
                      SizedBox(
                        width: 350 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: state.items.map((e) => e.itemId).toList(),
                          showSearchBox: true,
                          label: "Mã hàng",
                          onChanged: (value) {},
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
                            onChanged: (value) {},
                            selectedItem: goodsReceiptLot.item == null
                                ? ''
                                : goodsReceiptLot.item!.itemName,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 160 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            child: DropdownSearch<String>(
                              mode: Mode.MENU,
                              items: state.items
                                  .map((e) => e.unit!.toString())
                                  .toList(),
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
                          Container(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: 10 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 160 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              controller:
                                  // quantity,
                                  TextEditingController(
                                      text: goodsReceiptLot.quantity == null
                                          ? ''
                                          : goodsReceiptLot.quantity
                                              .toString()),
                              onSubmitted: (value) => value != ''
                                  ? goodsReceiptLot.quantity =
                                      double.parse(value)
                                  : goodsReceiptLot.quantity =
                                      double.parse('0'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  // filled: true,
                                  // fillColor: Constants.buttonColor,
                                  labelStyle: TextStyle(
                                      fontSize: 15 * SizeConfig.ratioFont),
                                  labelText: "Tổng lượng"),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ],
                              onChanged: (value) => goodsReceiptLot.quantity =
                                  double.parse(value),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 175 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            child: CustomizeDatePicker(
                              name: "NSX",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                              initDateTime: goodsReceiptLot.productionDate ==
                                      null
                                  ? DateFormat('yyyy-MM-dd')
                                      .parse(DateTime.now().toString())
                                  : goodsReceiptLot.productionDate as DateTime,
                              okBtnClickedFunction: (pickedTime) {
                                goodsReceiptLot.productionDate = pickedTime;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 175 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            child: CustomizeDatePicker(
                              name: "HSD",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                              initDateTime: goodsReceiptLot.expirationDate ==
                                      null
                                  ? DateFormat('yyyy-MM-dd')
                                      .parse(DateTime.now().toString())
                                  : goodsReceiptLot.expirationDate as DateTime,
                              okBtnClickedFunction: (pickedTime) {
                                goodsReceiptLot.expirationDate = pickedTime;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.centerRight,
                                  width: 300 * SizeConfig.ratioWidth,
                                  height: 65 * SizeConfig.ratioHeight,
                                  child: BarcodeinputWidget(
                                    textController: locationController.text,
                                    textLabel: "Vị trí",
                                    onScan: (data) {
                                      setState(() {
                                        locationController.text = data;
                                      });
                                    },
                                    onChange: (data) {
                                      locationController.text = data;
                                    },
                                  )),
                              SizedBox(
                                width: 280 * SizeConfig.ratioWidth,
                                height: 60 * SizeConfig.ratioHeight,
                                //color: Colors.grey[200],
                                child: TextField(
                                  controller: quantityController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelStyle: TextStyle(
                                          fontSize: 17 * SizeConfig.ratioFont),
                                      labelText: "Số lượng "),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.,]')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          FloatingActionButton(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              tooltip: 'Thêm vị trí',
                              mini: true,
                              onPressed: () {
                                // GoodsReceiptSublot sublot =
                                //     GoodsReceiptSublot('', null);
                                goodsReceiptSublotModel.locationId =
                                    locationController.text;
                                goodsReceiptSublotModel.quantityPerLocation =
                                    double.tryParse(quantityController.text);
                                BlocProvider.of<GoodsReceiptSublotBloc>(context)
                                    .add(AddGoodsReceiptSublotEvent(
                                  state.goodsReceipt,
                                  state.index,
                                  goodsReceiptSublotModel,
                                  // truyền thông tin phiếu nhập cũ
                                  state.goodsReceipt.lots[state.index]
                                      as GoodsReceiptLotModel,
                                  state.items, DateTime.now(),
                                ));
                                locationController.clear();
                                quantityController.clear();
                                //Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.add)),
                        ],
                      ),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: goodsReceiptLot.goodsReceiptSublots.length,
                          itemBuilder: (BuildContext context, int index) {
                            final goodsReceiptSublotModel =
                                goodsReceiptLot.goodsReceiptSublots[index]
                                    as GoodsReceiptSublotModel;

                            return ListTile(
                              title: Text(goodsReceiptSublotModel.locationId
                                  .toString()),
                              subtitle: Text(goodsReceiptSublotModel
                                  .quantityPerLocation
                                  .toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<GoodsReceiptSublotBloc>(
                                          context)
                                      .add(RemoveGoodsReceiptSublotEvent(
                                    state.goodsReceipt,
                                    state.index,
                                    goodsReceiptSublotModel,
                                    // truyền thông tin phiếu nhập cũ
                                    state.goodsReceipt.lots[state.index]
                                        as GoodsReceiptLotModel,
                                    state.items,
                                    DateTime.now(),
                                  ));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          for (int i = 0;
                              i <
                                  state.goodsReceiptLot!.goodsReceiptSublots
                                      .length;
                              i++) {
                            totalQuantity = totalQuantity +
                                goodsReceiptLot
                                    .goodsReceiptSublots[i].quantityPerLocation!
                                    .toDouble();
                          }
                          if (goodsReceiptLot.goodsReceiptLotId == '' ||
                              goodsReceiptLot.item!.itemId == '' ||
                              goodsReceiptLot.quantity == null) {
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Cảnh báo",
                                    "Vui lòng điền đầy đủ các thông tin trong phần bắt buộc",
                                    "Trở lại",
                                    '', () {
                              Navigator.pushNamed(
                                context,
                                '/importing_receipt_lot_screen',
                              );
                            }, 18, 22, () {}, false)
                                .show();
                          }
                          if (totalQuantity != goodsReceiptLot.quantity) {
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Cảnh báo",
                                    "Sai số lượng ở các vị trí",
                                    "Trở lại",
                                    'Fail_image.png', () {
                               
                              Navigator.pushNamed(
                                context,
                                '/update_lot_receipt_screen',
                              );
                            }, 18, 22, () {}, false)
                                .show();
                          } else {
                            BlocProvider.of<ExportingReceiptLotBloc>(context)
                                .add(UpdateReceiptLotEvent(state.index,
                                    goodsReceiptLot, state.goodsReceipt));
                            Navigator.pushNamed(
                                context, '/importing_receipt_lot_screen');
                          }
                        },
                        child: const Text('Cập nhật'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<ExportingReceiptLotBloc>(context).add(
                              RemoveGoodsReceiptLotEvent(
                                  state.goodsReceipt,
                                  state.index,
                                  goodsReceiptLot,
                                  DateTime.now()));
                          // Navigator.pushNamed(
                          //     context, '/importing_receipt_lot_screen');
                        },
                        child: const Text('   Xóa lô  '),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is AddGoodsReceiptSublotSuccessState) {
              goodsReceiptLot.goodsReceiptSublots =
                  state.goodsReceiptLot!.goodsReceiptSublots;
              goodsReceiptLot = state.goodsReceipt.lots[state.index];
              GoodsReceiptSublotModel goodsReceiptSublotModel =
                  GoodsReceiptSublotModel('', null);

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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              // filled: true,
                              // fillColor: Constants.buttonColor,
                              labelStyle: TextStyle(
                                  fontSize: 15 * SizeConfig.ratioFont),
                              label: const Text("Mã lô cũ"),
                            ),
                            child: Text(
                              goodsReceiptLot.goodsReceiptLotId!,
                              style: (TextStyle(
                                  fontSize: 17.5 * SizeConfig.ratioFont)),
                            ),
                          ),
                        ),
                      ),
                      BarcodeinputWidget(
                        textController:
                            goodsReceiptLot.newGoodsReceiptLotId?.isEmpty ??
                                    true
                                ? goodsReceiptLot.goodsReceiptLotId!
                                : goodsReceiptLot.newGoodsReceiptLotId!,
                        textLabel: "Mã lô mới",
                        onChange: (data) {
                          goodsReceiptLot.newGoodsReceiptLotId = data;
                        },
                        onScan: (data) {
                          goodsReceiptLot.newGoodsReceiptLotId = data;
                        },
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
                           
                            },
                            selectedItem: goodsReceiptLot.item == null
                                ? ''
                                : goodsReceiptLot.item!.itemName,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 160 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            child: DropdownSearch<String>(
                              mode: Mode.MENU,
                              items: state.items
                                  .map((e) => e.unit!.toString())
                                  .toList(),
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
                          Container(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: 10 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 160 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              controller:
                                  // quantity,
                                  TextEditingController(
                                      text: goodsReceiptLot.quantity == null
                                          ? ''
                                          : goodsReceiptLot.quantity
                                              .toString()),
                              onSubmitted: (value) => value != ''
                                  ? goodsReceiptLot.quantity =
                                      double.parse(value)
                                  : goodsReceiptLot.quantity =
                                      double.parse('0'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  // filled: true,
                                  // fillColor: Constants.buttonColor,
                                  labelStyle: TextStyle(
                                      fontSize: 15 * SizeConfig.ratioFont),
                                  labelText: "Tổng lượng"),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ],
                              onChanged: (value) => goodsReceiptLot.quantity =
                                  double.parse(value),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 175 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            child: CustomizeDatePicker(
                              name: "NSX",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                              initDateTime: goodsReceiptLot.productionDate ==
                                      null
                                  ? DateFormat('yyyy-MM-dd')
                                      .parse(DateTime.now().toString())
                                  : goodsReceiptLot.productionDate as DateTime,
                              okBtnClickedFunction: (pickedTime) {
                                goodsReceiptLot.productionDate = pickedTime;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 175 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            child: CustomizeDatePicker(
                              name: "HSD",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                              initDateTime: goodsReceiptLot.expirationDate ==
                                      null
                                  ? DateFormat('yyyy-MM-dd')
                                      .parse(DateTime.now().toString())
                                  : goodsReceiptLot.expirationDate as DateTime,
                              okBtnClickedFunction: (pickedTime) {
                                goodsReceiptLot.expirationDate = pickedTime;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.centerRight,
                                  width: 300 * SizeConfig.ratioWidth,
                                  height: 65 * SizeConfig.ratioHeight,
                                  child: BarcodeinputWidget(
                                    textController: locationController.text,
                                    textLabel: "Vị trí",
                                    onScan: (data) {
                                      setState(() {
                                        locationController.text = data;
                                      });
                                    },
                                    onChange: (data) {
                                      locationController.text = data;
                                    },
                                  )),
                              SizedBox(
                                width: 280 * SizeConfig.ratioWidth,
                                height: 60 * SizeConfig.ratioHeight,
                                //color: Colors.grey[200],
                                child: TextField(
                                  controller: quantityController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelStyle: TextStyle(
                                          fontSize: 17 * SizeConfig.ratioFont),
                                      labelText: "Số lượng "),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.,]')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          FloatingActionButton(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              tooltip: 'Thêm vị trí',
                              mini: true,
                              onPressed: () {
                                // GoodsReceiptSublot sublot =
                                //     GoodsReceiptSublot('', null);
                                goodsReceiptSublotModel.locationId =
                                    locationController.text;
                                goodsReceiptSublotModel.quantityPerLocation =
                                    double.tryParse(quantityController.text);
                                BlocProvider.of<GoodsReceiptSublotBloc>(context)
                                    .add(AddGoodsReceiptSublotEvent(
                                  state.goodsReceipt,
                                  state.index,
                                  goodsReceiptSublotModel,
                                  // truyền thông tin phiếu nhập cũ
                                  state.goodsReceipt.lots[state.index]
                                      as GoodsReceiptLotModel,
                                  state.items, DateTime.now(),
                                ));
                                locationController.clear();
                                quantityController.clear();
                                //Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.add)),
                        ],
                      ),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: goodsReceiptLot.goodsReceiptSublots.length,
                          itemBuilder: (BuildContext context, int index) {
                            final goodsReceiptSublotModel =
                                goodsReceiptLot.goodsReceiptSublots[index]
                                    as GoodsReceiptSublotModel;

                            return ListTile(
                              title: Text(state.goodsReceiptLot!
                                  .goodsReceiptSublots[index].locationId
                                  .toString()),
                              subtitle: Text(state
                                  .goodsReceiptLot!
                                  .goodsReceiptSublots[index]
                                  .quantityPerLocation
                                  .toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<GoodsReceiptSublotBloc>(
                                          context)
                                      .add(RemoveGoodsReceiptSublotEvent(
                                    state.goodsReceipt,
                                    state.index,
                                    goodsReceiptSublotModel,
                                    // truyền thông tin phiếu nhập cũ
                                    state.goodsReceipt.lots[state.index]
                                        as GoodsReceiptLotModel,
                                    state.items,
                                    DateTime.now(),
                                  ));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          for (int i = 0;
                              i <
                                  state.goodsReceiptLot!.goodsReceiptSublots
                                      .length;
                              i++) {
                            totalQuantity = totalQuantity +
                                goodsReceiptLot
                                    .goodsReceiptSublots[i].quantityPerLocation!
                                    .toDouble();
                          }

                          if (goodsReceiptLot.goodsReceiptLotId == '' ||
                              goodsReceiptLot.item!.itemId == '' ||
                              goodsReceiptLot.quantity == null) {
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Cảnh báo",
                                    "Vui lòng điền đầy đủ các thông tin trong phần bắt buộc",
                                    "Trở lại",
                                    '', () {
                              Navigator.pushNamed(
                                context,
                                '/importing_receipt_lot_screen',
                              );
                            }, 18, 22, () {}, false)
                                .show();
                          }
                          if (totalQuantity != goodsReceiptLot.quantity) {
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Cảnh báo",
                                    "Sai số lượng ở các vị trí",
                                    "Trở lại",
                                    'Fail_image.png', () {
                        
                                 
                              Navigator.pushNamed(
                                context,
                                '/update_lot_receipt_screen',
                              );
                            }, 18, 22, () {}, false)
                                .show();
                          } else {
                            BlocProvider.of<ExportingReceiptLotBloc>(context)
                                .add(UpdateReceiptLotEvent(state.index,
                                    goodsReceiptLot, state.goodsReceipt));
                            Navigator.pushNamed(
                                context, '/importing_receipt_lot_screen');
                          }
                        },
                        child: const Text('Cập nhật'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // if (goodsReceiptLot.goodsReceiptLotId == '' ||
                          //     goodsReceiptLot.item!.itemId == '' ||
                          //     goodsReceiptLot.quantity == null) {
                          //   AlertDialogOneBtnCustomized(
                          //           context,
                          //           "Cảnh báo",
                          //           "Bạn muốn xóa lô này",
                          //           "Trở lại",
                          //           '', () {
                          //     // Navigator.pushNamed(
                          //     //   context,
                          //     //   '/fill_main_info_issue_screen',
                          //     // );
                          //   }, 18, 22, () {}, false)
                          //       .show();
                          // } else {
                          BlocProvider.of<ExportingReceiptLotBloc>(context).add(
                              RemoveGoodsReceiptLotEvent(
                                  state.goodsReceipt,
                                  state.index,
                                  goodsReceiptLot,
                                  DateTime.now()));
                          // Navigator.pushNamed(
                          //     context, '/importing_receipt_lot_screen');
                        },
                        child: const Text('   Xóa lô  '),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is RemoveReceiptSublotSuccessState) {
              goodsReceiptLot.goodsReceiptSublots =
                  state.goodsReceiptLot!.goodsReceiptSublots;
             goodsReceiptLot = state.goodsReceipt.lots[state.index];
              GoodsReceiptSublotModel goodsReceiptSublotModel =
                  GoodsReceiptSublotModel('', null);
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              // filled: true,
                              // fillColor: Constants.buttonColor,
                              labelStyle: TextStyle(
                                  fontSize: 15 * SizeConfig.ratioFont),
                              label: const Text("Mã lô cũ"),
                            ),
                            child: Text(
                              goodsReceiptLot.goodsReceiptLotId!,
                              style: (TextStyle(
                                  fontSize: 17.5 * SizeConfig.ratioFont)),
                            ),
                          ),
                        ),
                      ),
                      BarcodeinputWidget(
                        textController:
                            goodsReceiptLot.newGoodsReceiptLotId?.isEmpty ??
                                    true
                                ? goodsReceiptLot.goodsReceiptLotId!
                                : goodsReceiptLot.newGoodsReceiptLotId!,
                        textLabel: "Mã lô mới",
                        onChange: (data) {
                          goodsReceiptLot.newGoodsReceiptLotId = data;
                        },
                        onScan: (data) {
                          goodsReceiptLot.newGoodsReceiptLotId = data;
                        },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 160 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            child: DropdownSearch<String>(
                              mode: Mode.MENU,
                              items: state.items
                                  .map((e) => e.unit!.toString())
                                  .toList(),
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
                          Container(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: 10 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 160 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              controller:
                                  // quantity,
                                  TextEditingController(
                                      text: goodsReceiptLot.quantity == null
                                          ? ''
                                          : goodsReceiptLot.quantity
                                              .toString()),
                              onSubmitted: (value) => value != ''
                                  ? goodsReceiptLot.quantity =
                                      double.parse(value)
                                  : goodsReceiptLot.quantity =
                                      double.parse('0'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  // filled: true,
                                  // fillColor: Constants.buttonColor,
                                  labelStyle: TextStyle(
                                      fontSize: 15 * SizeConfig.ratioFont),
                                  labelText: "Tổng lượng"),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ],
                              onChanged: (value) => goodsReceiptLot.quantity =
                                  double.parse(value),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 175 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            child: CustomizeDatePicker(
                              name: "NSX",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                              initDateTime: goodsReceiptLot.productionDate ==
                                      null
                                  ? DateFormat('yyyy-MM-dd')
                                      .parse(DateTime.now().toString())
                                  : goodsReceiptLot.productionDate as DateTime,
                              okBtnClickedFunction: (pickedTime) {
                                goodsReceiptLot.productionDate = pickedTime;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 175 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            child: CustomizeDatePicker(
                              name: "HSD",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                              initDateTime: goodsReceiptLot.expirationDate ==
                                      null
                                  ? DateFormat('yyyy-MM-dd')
                                      .parse(DateTime.now().toString())
                                  : goodsReceiptLot.expirationDate as DateTime,
                              okBtnClickedFunction: (pickedTime) {
                                goodsReceiptLot.expirationDate = pickedTime;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.centerRight,
                                  width: 300 * SizeConfig.ratioWidth,
                                  height: 65 * SizeConfig.ratioHeight,
                                  child: BarcodeinputWidget(
                                    textController: locationController.text,
                                    textLabel: "Vị trí",
                                    onScan: (data) {
                                      setState(() {
                                        locationController.text = data;
                                      });
                                    },
                                    onChange: (data) {
                                      locationController.text = data;
                                    },
                                  )),
                              SizedBox(
                                width: 280 * SizeConfig.ratioWidth,
                                height: 60 * SizeConfig.ratioHeight,
                                //color: Colors.grey[200],
                                child: TextField(
                                  controller: quantityController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelStyle: TextStyle(
                                          fontSize: 17 * SizeConfig.ratioFont),
                                      labelText: "Số lượng "),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.,]')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          FloatingActionButton(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              tooltip: 'Thêm vị trí',
                              mini: true,
                              onPressed: () {
                                // GoodsReceiptSublot sublot =
                                //     GoodsReceiptSublot('', null);
                                goodsReceiptSublotModel.locationId =
                                    locationController.text;
                                goodsReceiptSublotModel.quantityPerLocation =
                                    double.tryParse(quantityController.text);
                                BlocProvider.of<GoodsReceiptSublotBloc>(context)
                                    .add(AddGoodsReceiptSublotEvent(
                                  state.goodsReceipt,
                                  state.index,
                                  goodsReceiptSublotModel,

                                  // truyền thông tin phiếu nhập cũ
                                  state.goodsReceipt.lots[state.index]
                                      as GoodsReceiptLotModel,
                                  state.items, DateTime.now(),
                                ));
                                locationController.clear();
                                quantityController.clear();
                                //Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.add)),
                        ],
                      ),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: goodsReceiptLot.goodsReceiptSublots.length,
                          itemBuilder: (BuildContext context, int index) {
                            final goodsReceiptSublotModel =
                                goodsReceiptLot.goodsReceiptSublots[index]
                                    as GoodsReceiptSublotModel;
                            return ListTile(
                              title: Text(state.goodsReceiptLot!
                                  .goodsReceiptSublots[index].locationId
                                  .toString()),
                              subtitle: Text(state
                                  .goodsReceiptLot!
                                  .goodsReceiptSublots[index]
                                  .quantityPerLocation
                                  .toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<GoodsReceiptSublotBloc>(
                                          context)
                                      .add(RemoveGoodsReceiptSublotEvent(
                                    state.goodsReceipt,
                                    state.index,
                                    goodsReceiptSublotModel,
                                    // truyền thông tin phiếu nhập cũ
                                    state.goodsReceipt.lots[state.index]
                                        as GoodsReceiptLotModel,

                                    state.items,
                                    DateTime.now(),
                                  ));
                                },
                              ),
                            );
                          },
                        ),
                      ),
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
                              Navigator.pushNamed(
                                context,
                                '/importing_receipt_lot_screen',
                              );
                            }, 18, 22, () {}, false)
                                .show();
                          }
                          if (totalQuantity != goodsReceiptLot.quantity) {
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Cảnh báo",
                                    "Sai số lượng ở các vị trí",
                                    "Trở lại",
                                    'Fail_image.png', () { 
                                    
                              Navigator.pushNamed(
                                context,
                                '/update_lot_receipt_screen',
                              );
                            }, 18, 22, () {}, false)
                                .show();
                          } else {
                            BlocProvider.of<ExportingReceiptLotBloc>(context)
                                .add(UpdateReceiptLotEvent(state.index,
                                    goodsReceiptLot, state.goodsReceipt));
                            Navigator.pushNamed(
                                context, '/importing_receipt_lot_screen');
                          }
                        },
                        child: const Text('Cập nhật'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<ExportingReceiptLotBloc>(context).add(
                              RemoveGoodsReceiptLotEvent(
                                  state.goodsReceipt,
                                  state.index,
                                  goodsReceiptLot,
                                  DateTime.now()));
                          // Navigator.pushNamed(
                          //     context, '/importing_receipt_lot_screen');
                        },
                        child: const Text('   Xóa lô  '),
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
