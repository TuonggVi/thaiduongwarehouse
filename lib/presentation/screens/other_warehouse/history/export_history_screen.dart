// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/history_bloc/export_history_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/history_event/export_history_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/history_state/export_history_state.dart';
import '../../../../constant.dart';
import '../../../../domain/entities/item.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/customized_date_picker.dart';

class ExportHistoryScreen extends StatefulWidget {
  const ExportHistoryScreen({super.key});

  @override
  State<ExportHistoryScreen> createState() => _ExportHistoryScreenSate();
}

class _ExportHistoryScreenSate extends State<ExportHistoryScreen> {
  List<Item> itemsDropdownData = [];
  Item selectedItem = Item('', '', '', '', 0, 0);
  // String warehouse = '';
  //List<String> supplierDropdownData = [];
  String? selectedReceiver;
  //List<Warehouse> warehouseDropdownData = [];
  Warehouse selectedWarehouse = Warehouse('', '', []);
  String? selectedPo;
  // truy xuất trong 1 tháng
  DateTime startDate = DateFormat('yyyy-MM-dd').parse(DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 30))));
  DateTime endDate = DateFormat('yyyy-MM-dd')
      .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, "/history_function_screen");
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.mainColor,
            leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/history_function_screen');
              },
            ),
            title: Text(
              'Lịch sử xuất kho',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body:

              // Các thuộc tính tùy chỉnh riêng cho từng ExpansionPanelList

              SingleChildScrollView(
            child: ExpansionPanelList.radio(
              children: [
                ExpansionPanelRadio(
                  value: 1,
                  headerBuilder: ((context, isExpanded) {
                    return SizedBox(
                      width: 370 * SizeConfig.ratioHeight,
                      height: 60 * SizeConfig.ratioHeight,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:const [
                          Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          Text(
                            'Truy xuất theo sản phẩm',
                            style: TextStyle(
                              //fontFamily: 'MyFont',
                              fontSize: 18,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  body: Column(
                    children: [
                      BlocConsumer<ExportHistoryBloc, ExportHistoryState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: SizedBox(
                                    width: 350 * SizeConfig.ratioWidth,
                                    height: 60 * SizeConfig.ratioHeight,
                                    child: DropdownSearch<dynamic>(
                                      mode: Mode.MENU,
                                      items: state.warehouse
                                          .map((e) => e.warehouseId)
                                          .toList(),
                                      // state is GetAllInfoExportSuccessState
                                      //     ? state.warehouse
                                      //         .map((e) => e.warehouseId)
                                      //         .toList()
                                      //     : state is GetItemByWarehouseSuccessState
                                      //         ? state.warehouse
                                      //             .map((e) => e.warehouseId)
                                      //             .toList()
                                      //         : [],
                                      showSearchBox: true,
                                      label: "Kho hàng",
                                      onChanged: (value) {
                                        setState(() {
                                          selectedWarehouse = state.warehouse
                                              .firstWhere((element) =>
                                                  element.warehouseId == value);
                                          BlocProvider.of<ExportHistoryBloc>(
                                                  context)
                                              .add(
                                                  GetExportItemByWarehouseEvent(
                                                      DateTime.now(),
                                                      selectedWarehouse
                                                          .warehouseId,
                                                      state.listAllItem,
                                                      state.itemSort,
                                                      state.warehouse,
                                                      state.receiver));
                                        });
                                      },
                                      selectedItem: selectedWarehouse == null
                                          ? ''
                                          : selectedWarehouse.warehouseName,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: SizedBox(
                                    width: 350 * SizeConfig.ratioWidth,
                                    height: 60 * SizeConfig.ratioHeight,
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      items: state.itemSort
                                          .map((e) => e.itemId.toString())
                                          .toList(),
                                      showSearchBox: true,
                                      label: "Mã hàng",
                                      onChanged: (value) {
                                        setState(() {
                                          selectedItem = state.itemSort
                                              .firstWhere((element) =>
                                                  element.itemId == value);
                                        });
                                      },
                                      selectedItem: selectedItem == null
                                          ? ''
                                          : selectedItem.itemId,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: SizedBox(
                                    width: 350 * SizeConfig.ratioWidth,
                                    height: 60 * SizeConfig.ratioHeight,
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      items: state.itemSort
                                          .map((e) => e.itemName.toString())
                                          .toList(),
                                      showSearchBox: true,
                                      label: "Tên hàng",
                                      // hint: "country in menu mode",
                                      onChanged: (value) {
                                        setState(() {
                                          selectedItem = state.itemSort
                                              .firstWhere((element) =>
                                                  element.itemName == value);
                                        });
                                      },
                                      selectedItem: selectedItem == null
                                          ? ''
                                          : selectedItem.itemName,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      // margin: EdgeInsets.symmetric(
                                      //     vertical: 5 * SizeConfig.ratioHeight),
                                      width: 170 * SizeConfig.ratioWidth,
                                      height: 80 * SizeConfig.ratioHeight,
                                      child: CustomizeDatePicker(
                                        name: "Từ ngày",
                                        fontColor: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        initDateTime: startDate,
                                        okBtnClickedFunction: (pickedTime) {
                                          startDate = pickedTime;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      // margin: EdgeInsets.symmetric(
                                      //     vertical: 5 * SizeConfig.ratioHeight),
                                      width: 170 * SizeConfig.ratioWidth,
                                      height: 80 * SizeConfig.ratioHeight,
                                      child: CustomizeDatePicker(
                                        name: "Đến ngày",
                                        fontColor: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        initDateTime: endDate,
                                        okBtnClickedFunction: (pickedTime) {
                                          endDate = pickedTime;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomizedButton(
                                      text: "Truy xuất",
                                      onPressed: () {
                                        selectedWarehouse.warehouseId == '' &&
                                                selectedItem.itemName == ''
                                            ? {
                                                AlertDialogOneBtnCustomized(
                                                        context,
                                                        'Cảnh báo',
                                                        'Vui lòng chọn kho hàng để truy xuất',
                                                        'Trở lại',
                                                        '', () {
                                                  // Navigator.pushNamed(context, '/main_receipt_screen');
                                                }, 20, 15, () {}, false)
                                                    .show()
                                              }
                                            : {
                                                BlocProvider.of<
                                                            ExportHistoryBloc>(
                                                        context)
                                                    .add(
                                                        AccessExportHistoryByItemIdEvent(
                                                            DateTime.now(),
                                                            startDate,
                                                            endDate,
                                                            selectedItem.itemId,
                                                            selectedWarehouse
                                                                .warehouseId,
                                                            state.warehouse,
                                                            state.itemSort,
                                                            state.listAllItem,
                                                            state.receiver)),
                                                Navigator.pushNamed(
                                                  context,
                                                  '/list_export_history_screen',
                                                )
                                              };
                                      }),
                                ),
                              ],
                            );

                            // else {
                            //   return const CircularProgressIndicator();
                            // }
                          }),
                    ],
                  ),
                ),
                ExpansionPanelRadio(
                  value: 2,
                  headerBuilder: ((context, isExpanded) {
                    return SizedBox(
                      width: 370 * SizeConfig.ratioHeight,
                      height: 60 * SizeConfig.ratioHeight,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:const [
                          Icon(
                            Icons.add_home_outlined,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          Text(
                            'Truy xuất theo người nhận',
                            style: TextStyle(
                              //fontFamily: 'MyFont',
                              fontSize: 18,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  body: BlocConsumer<ExportHistoryBloc, ExportHistoryState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        // if (state is GetAllInfoExportSuccessState) {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: SizedBox(
                              width: 350 * SizeConfig.ratioWidth,
                              height: 60 * SizeConfig.ratioHeight,
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                items: state.receiver.map((e) => e).toList(),
                                showSearchBox: true,
                                label: "Người nhận",
                                onChanged: (value) {
                                  setState(() {
                                    selectedReceiver = state.receiver
                                        .firstWhere(
                                            (element) => element == value);
                                  });
                                },
                                selectedItem: selectedReceiver ?? '',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                // margin: EdgeInsets.symmetric(
                                //     vertical: 5 * SizeConfig.ratioHeight),
                                width: 170 * SizeConfig.ratioWidth,
                                height: 80 * SizeConfig.ratioHeight,
                                child: CustomizeDatePicker(
                                  name: "Từ ngày",
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  initDateTime: startDate,
                                  okBtnClickedFunction: (pickedTime) {
                                    startDate = pickedTime;
                                  },
                                ),
                              ),
                              SizedBox(
                                // margin: EdgeInsets.symmetric(
                                //     vertical: 5 * SizeConfig.ratioHeight),
                                width: 170 * SizeConfig.ratioWidth,
                                height: 80 * SizeConfig.ratioHeight,
                                child: CustomizeDatePicker(
                                  name: "Đến ngày",
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  initDateTime: endDate,
                                  okBtnClickedFunction: (pickedTime) {
                                    endDate = pickedTime;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomizedButton(
                                text: "Truy xuất",
                                onPressed: () {
                                  selectedReceiver == null
                                      ? {
                                          AlertDialogOneBtnCustomized(
                                                  context,
                                                  'Cảnh báo',
                                                  'Vui lòng chọn thông tin để truy xuất',
                                                  'Trở lại',
                                                  'warning_image.png', () {
                                            // Navigator.pushNamed(context, '/main_receipt_screen');
                                          }, 15, 20, () {}, false)
                                              .show()
                                        }
                                      : {
                                          BlocProvider.of<ExportHistoryBloc>(
                                                  context)
                                              .add(
                                                  AccessExportHistoryByReceiverEvent(
                                                      DateTime.now(),
                                                      startDate,
                                                      endDate,
                                                      selectedReceiver!,
                                                      state.warehouse,
                                                      state.itemSort,
                                                      state.listAllItem,
                                                      state.receiver)),
                                          Navigator.pushNamed(
                                            context,
                                            '/list_export_history_screen',
                                          )
                                        };
                                }),
                          )
                        ]);
                        // }
                        // else {
                        //   return const CircularProgressIndicator();
                        // }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
