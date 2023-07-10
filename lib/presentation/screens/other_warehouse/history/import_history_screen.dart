// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/history_bloc/import_history_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/history_event/import_history_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/history_state/import_history_state.dart';
import '../../../../constant.dart';
import '../../../../domain/entities/item.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/customized_date_picker.dart';

class ImportHistoryScreen extends StatefulWidget {
  const ImportHistoryScreen({super.key});

  @override
  State<ImportHistoryScreen> createState() => _ImportHistoryScreenSate();
}

class _ImportHistoryScreenSate extends State<ImportHistoryScreen> {
  List<Item> itemsDropdownData = [];
  Item selectedItem = Item('', '', '', '', 0, 0);
  // String warehouse = '';
  //List<String> supplierDropdownData = [];
  String? selectedSupplier;
  //List<Warehouse> warehouseDropdownData = [];
  Warehouse selectedWarehouse = Warehouse('', '', const []);
  String? selectedPo;
  DateTime startDate = DateFormat('yyyy-MM-dd')
      .parse(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 30))));
  DateTime endDate = DateFormat('yyyy-MM-dd')
      .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  // void _moveToScreen2(BuildContext context) =>
  //     Navigator.pushReplacementNamed(context, "/history_function_screen");
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
              'Lịch sử nhập kho',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body: SingleChildScrollView(
            child: ExpansionPanelList.radio(
              children: [
                ExpansionPanelRadio(
                  value: 1,
                  headerBuilder: ((context, isExpanded) {
                    return SizedBox(
                      width: 370 * SizeConfig.ratioHeight,
                      height: 60 * SizeConfig.ratioHeight,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          Text(
                            'Truy xuất theo sản phẩm   ',
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
                      BlocConsumer<ImportHistoryBloc, ImportHistoryState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 360 * SizeConfig.ratioWidth,
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
                                          BlocProvider.of<ImportHistoryBloc>(
                                                  context)
                                              .add(
                                                  GetImportItemByWarehouseEvent(
                                                      DateTime.now(),
                                                      state.poNumber,
                                                      selectedWarehouse
                                                          .warehouseId,
                                                      state.listAllItem,
                                                      state.warehouse,
                                                      state.supplier));
                                        });
                                      },
                                      selectedItem:
                                          selectedWarehouse.warehouseName,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                      selectedItem: selectedItem.itemId,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                      selectedItem: selectedItem.itemName,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Row(
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
                                ),
                                CustomizedButton(
                                    text: "Truy xuất",
                                    onPressed: () {
                                      selectedWarehouse.warehouseId == '' &&
                                              selectedItem.itemName == ''
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
                                              // if (selectedItem == null)
                                              //   {
                                              //     selectedItem =
                                              //         Item('', '', '', '', 0, 0)
                                              //   },
                                              BlocProvider.of<
                                                          ImportHistoryBloc>(
                                                      context)
                                                  .add(
                                                      AccessImportHistoryByItemIdEvent(
                                                          DateTime.now(),
                                                          startDate,
                                                          endDate,
                                                          selectedItem.itemId,
                                                          selectedWarehouse
                                                              .warehouseId,
                                                          state.warehouse,
                                                          state.itemSort,
                                                          state.listAllItem,
                                                          state.poNumber,
                                                          state.supplier)),
                                              Navigator.pushNamed(
                                                context,
                                                '/list_import_history_screen',
                                              )
                                            };
                                    }),
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.add_home_outlined,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          Text(
                            'Truy xuất theo nhà cung cấp    ',
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
                  body: BlocConsumer<ImportHistoryBloc, ImportHistoryState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        // if (state is GetAllInfoExportSuccessState) {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: SizedBox(
                              width: 350 * SizeConfig.ratioWidth,
                              height: 60 * SizeConfig.ratioHeight,
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                items: state.supplier.map((e) => e).toList(),
                                showSearchBox: true,
                                label: "NCC",
                                onChanged: (value) {
                                  setState(() {
                                    selectedSupplier = state.supplier
                                        .firstWhere(
                                            (element) => element == value);
                                  });
                                },
                                selectedItem: selectedSupplier ?? '',
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
                          CustomizedButton(
                              text: "Truy xuất",
                              onPressed: () {
                                 selectedSupplier == null
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
                                BlocProvider.of<ImportHistoryBloc>(context).add(
                                    AccessImportHistoryBySupplierEvent(
                                        DateTime.now(),
                                        startDate,
                                        endDate,
                                        selectedSupplier!,
                                        state.warehouse,
                                        state.itemSort,
                                        state.listAllItem,
                                        state.poNumber,
                                        state.supplier)),
                                Navigator.pushNamed(
                                  context,
                                  '/list_import_history_screen',
                                )};
                              })
                        ]);
                        // }
                        // else {
                        //   return const CircularProgressIndicator();
                        // }
                      }),
                ),
                ExpansionPanelRadio(
                  value: 3,
                  headerBuilder: ((context, isExpanded) {
                    return SizedBox(
                      width: 370 * SizeConfig.ratioHeight,
                      height: 60 * SizeConfig.ratioHeight,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.document_scanner_outlined,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          Text(
                            'Truy xuất theo PO                  ',
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
                  body: BlocConsumer<ImportHistoryBloc, ImportHistoryState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        //   if (state is GetAllInfoExportSuccessState) {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: SizedBox(
                              width: 350 * SizeConfig.ratioWidth,
                              height: 60 * SizeConfig.ratioHeight,
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                items: state.poNumber.map((e) => e).toList(),
                                showSearchBox: true,
                                label: "PO",
                                onChanged: (value) {
                                  selectedPo = value;
                                },
                                selectedItem: selectedPo ?? '',
                              ),
                            ),
                          ),
                          CustomizedButton(
                              text: "Truy xuất",
                              onPressed: () {
                                BlocProvider.of<ImportHistoryBloc>(context).add(
                                    AccessImportHistoryByPOEvent(
                                        DateTime.now(),
                                        selectedPo.toString(),
                                        state.warehouse,
                                        state.itemSort,
                                        state.listAllItem,
                                        state.poNumber,
                                        state.supplier));
                                Navigator.pushNamed(
                                  context,
                                  '/list_import_history_screen',
                                );
                              })
                        ]);
                        // } else {
                        //   return const CircularProgressIndicator();
                        // }
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
