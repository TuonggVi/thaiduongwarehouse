// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_receipt_model.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/barcode_input_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../bloc/blocs/other/receipt_bloc/add_receipt_lot_bloc.dart';
import '../../../bloc/blocs/other/receipt_bloc/uncompleted_receipt_lot_bloc.dart';

import '../../../bloc/events/other/receipt_event/add_receipt_lot_event.dart';
import '../../../bloc/events/other/receipt_event/uncompleted_receipt_lot_event.dart';
import '../../../bloc/states/other/receipt_state/add_new_receipt_lot_state.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

// thêm lô vào phiếu nhập chưa hoàn thành
class FillInfoAddLotReceiptScreen extends StatefulWidget {
  const FillInfoAddLotReceiptScreen({super.key});

  @override
  State<FillInfoAddLotReceiptScreen> createState() =>
      _FillInfoLotReceiptScreenState();
}

class _FillInfoLotReceiptScreenState
    extends State<FillInfoAddLotReceiptScreen> {
//  Item? selectedItem;
  // String unit = '';
  GoodsReceiptLotModel goodsReceiptLot = GoodsReceiptLotModel(
      '', '', '', [], null, null, null, null, null, null, null);
  var receiptLotId = TextEditingController();
  var quantity = TextEditingController();
  var sublotSize = TextEditingController();
  // String lotId = '', poNumber = '';

  //double sublotSize = 0, quantity = 0;
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
        body:
            BlocConsumer<FillInfoNewReceiptLotBloc, FillInfoNewReceiptLotState>(
          listener: (context, state) {
            if (state is LoadNewItemDataSuccessState) {
              if (state.index != -1) {
                //goodsReceiptLot = state.lots[state.index];
                // print(state.lots[state.index]);
                // print('và');
                // print(goodsReceiptLot);
              }
            }
          },
          builder: (context, state) {
            if (state is LoadNewItemDataSuccessState) {
              if (state.index != -1) {
                goodsReceiptLot = state.goodsReceipt.lots[state.index]
                    as GoodsReceiptLotModel;
                receiptLotId.text =
                    goodsReceiptLot.goodsReceiptLotId.toString();
              }
              return SingleChildScrollView(
                child: Container(
                  // height: 300*SizeConfig.ratioHeight,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BarcodeinputWidget(
                        textController: goodsReceiptLot.goodsReceiptLotId!,
                        
                        textLabel: "Mã lô",
                        onChange: ((data) {
                          goodsReceiptLot.goodsReceiptLotId = data;
                        }),
                        onScan: ((data) {
                          goodsReceiptLot.goodsReceiptLotId = data;
                          var string = data.split('-').first;
                          setState(() {
                            goodsReceiptLot.item = state.items.firstWhere(
                                (element) => element.itemId == string,
                                orElse: () =>
                                    ItemModel('', '', '', '', null, null));
                            goodsReceiptLot.unit =
                                goodsReceiptLot.item!.unit.toString();
                          });
                        }),
                      ),
                      SizedBox(
                        width: 350 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: state.items.map((e) => e.itemId).toList(),
                          showSearchBox: true,
                          label: "Mã sản phẩm",
                          // hint: "country in menu mode",
                          onChanged: (value) {
                            receiptLotId.text =
                                "$value-${DateFormat('yyMMdd').format(DateTime.now())}-";
                            goodsReceiptLot.goodsReceiptLotId =
                                receiptLotId.text;
                            //  print(value);
                            setState(() {
                              goodsReceiptLot.item = state.items.firstWhere(
                                  (element) => element.itemId == value);
                              goodsReceiptLot.unit =
                                  goodsReceiptLot.item!.unit.toString();
                              //  goodsReceiptLot.item!.itemId = value.toString();
                            });
                          },
                          selectedItem: goodsReceiptLot.item == null
                              ? ''
                              : goodsReceiptLot.item!.itemId,
                          //  goodsReceiptLot.itemId
                          // state.index == -1
                          //     ? goodsReceiptLot.itemId
                          //     : state.lots[state.index].itemId.toString(),
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
                              setState(() {
                                goodsReceiptLot.item = state.items.firstWhere(
                                    (element) => element.itemName == value);
                                goodsReceiptLot.unit =
                                    goodsReceiptLot.item!.unit.toString();
                                // goodsReceiptLot.item!.itemId =
                                //     goodsReceiptLot.item!.itemId;
                              });
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
                          items: state.items
                              .map((e) => e.unit!.toString())
                              .toList(),
                          showSearchBox: true,
                          label: "Đơn vị",
                          // hint: "country in menu mode",
                          onChanged: (value) {
                            //  print(value);
                            setState(() {
                              goodsReceiptLot.unit = value.toString();
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
                            width: 350 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              controller: quantity,
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
                                    RegExp(r'[0-9.,]')),
                              ],
                              onChanged: (value) => value != ''
                                  ? goodsReceiptLot.quantity =
                                      double.parse(value)
                                  : goodsReceiptLot.quantity =
                                      double.parse('0'),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (goodsReceiptLot.goodsReceiptLotId == '' ||
                              goodsReceiptLot.item == null ||
                              goodsReceiptLot.quantity == null) {
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Cảnh báo",
                                    "Vui lòng điền đầy đủ các thông tin trong phần bắt buộc",
                                    "Trở lại",
                                    'warning_image.png', () {
                              // Navigator.pushNamed(
                              //   context,
                              //   '/fill_main_info_issue_screen',
                              // );
                            }, 18, 22, () {}, false)
                                .show();
                          } else {
                            // add lot vào phiếu chưa hoàn thành
                              BlocProvider.of<FillInfoNewReceiptLotBloc>(context)
                                .add(AddNewLotToGoodsReceiptEvent(
                                    goodsReceiptLot, state.goodsReceipt));  
                            BlocProvider.of<FillInfoNewReceiptLotBloc>(context)
                                .add(PostNewReceiptLotEvent(DateTime.now(),
                                    state.goodsReceipt));
                          }
                        },
                        child: const Text('Thêm lô'),
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is PostAddReceiptLotStateSuccess) {
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
                          // load lại trang ds lô chưa hoàn thành
                          BlocProvider.of<ExportingReceiptLotBloc>(context)
                              .add(LoadUncompletedReceiptLotEvent(
                            DateTime.now(),
                            state.goodsReceipt!,
                            
                          ));
                          Navigator.pushNamed(
                            context,
                            '/importing_receipt_lot_screen',
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
          },
        ),
      ),
    );
  }
}
