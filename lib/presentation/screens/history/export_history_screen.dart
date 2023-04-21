// ignore_for_file: unused_local_variable, deprecated_member_use, avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/department.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/history_events.dart';
import '../../../constant.dart';
import '../../../domain/entities/item.dart';
import '../../bloc/blocs/history_bloc.dart';

import '../../bloc/states/history_states.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/customized_date_picker.dart';

class ExportHistoryScreen extends StatefulWidget {
  const ExportHistoryScreen({super.key});

  @override
  State<ExportHistoryScreen> createState() => _ExportHistoryScreenSate();
}

class _ExportHistoryScreenSate extends State<ExportHistoryScreen> {
  List<Item> itemsDropdownData = [];
  Item? selectedItem;
  String warehouse = '';
  List<Department> departmentsDropdownData = [];
  Department? selectedDepartment;
  List<Warehouse> warehouseDropdownData = [];
  Warehouse? selectedWarehouse;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    SizeConfig().init(context);
    DateTime startDate = DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    DateTime endDate = DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

    return Scaffold(
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
        body: Column(children: [
          Container(
              padding: const EdgeInsets.all(8),
              child: Column(children: [
                BlocConsumer<HistoryBloc, HistoryState>(
                    listener: (context, state) {
                  if (state is GetAllInfoImportSuccessState) {
                    warehouseDropdownData = state.warehouse;
                    itemsDropdownData = state.item;
                  }
                  if (state is GetItemByWarehouseSuccessState) {
                    itemsDropdownData = state.item;
                  }
                }, builder: (context, state) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 160 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            child: DropdownSearch<dynamic>(
                              mode: Mode.MENU,
                              items:
                                  //  state.warehouse.map((e) => e.warehouseName)
                                  //     .toList(),
                                  state is GetAllInfoExportSuccessState
                                      ? state.warehouse
                                          .map((e) => e.warehouseId)
                                          .toList()
                                      : state is GetItemByWarehouseSuccessState
                                          ? state.warehouse
                                              .map((e) => e.warehouseId)
                                              .toList()
                                          : [],
                              showSearchBox: true,
                              label: "Kho hàng",
                              // hint: "country in menu mode",
                              onChanged: (value) {
                                print(value);
                                state is GetAllInfoExportSuccessState
                                    ? setState(() {
                                        selectedWarehouse = state.warehouse
                                            .firstWhere((element) =>
                                                element.warehouseId == value);
                                        // BlocProvider.of<HistoryBloc>(context)
                                        //     .add(GetItemByWarehouseEvent(
                                        //         DateTime.now(),
                                        //         selectedWarehouse!.warehouseId,
                                        //         state.item,
                                        //         state.warehouse,
                                        //         state.department));
                                      })
                                    : {};
                                //  setState(() {
                                //                     selectedWarehouse = warehouseDropdownData
                                //                         .firstWhere((element) =>
                                //                             element.warehouseName == value);
                                //                              BlocProvider.of<HistoryBloc>(context)
                                // .add(GetItemByWarehouseEvent(DateTime.now(), selectedWarehouse!.warehouseName, itemsDropdownData));
                                //    });
                              },
                              selectedItem: selectedWarehouse == null
                                  ? ''
                                  : selectedWarehouse!.warehouseName,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state is GetAllInfoExportSuccessState
                                ? state.department.map((e) => e.name).toList()
                                : state is GetItemByWarehouseSuccessState
                                    ? state.department
                                        .map((e) => e.name)
                                        .toList()
                                    : [],
                            showSearchBox: true,
                            label: "Nhà cung cấp",
                            onChanged: (value) {
                              state is GetAllInfoExportSuccessState
                                  ?
                                  //  print(value);
                                  setState(() {
                                      selectedDepartment = state.department
                                          .firstWhere((element) =>
                                              element.name == value);
                                    })
                                  : {};
                            },
                            selectedItem: selectedDepartment == null
                                ? ''
                                : selectedDepartment!.name,
                          ),
                        ),
                        //],
                        //     ),
                        //   ),
                      ]);
                }),
                BlocConsumer<HistoryBloc, HistoryState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(children: [
                        SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state is GetAllInfoExportSuccessState
                                ? state.item
                                    .map((e) => e.itemId.toString())
                                    .toList()
                                : state is GetItemByWarehouseSuccessState
                                    ? state.item
                                        .map((e) => e.itemId.toString())
                                        .toList()
                                    : [],
                            showSearchBox: true,
                            label: "Mã sản phẩm",
                            onChanged: (value) {
                              //print(value);
                              state is GetAllInfoImportSuccessState
                                  ? setState(() {
                                      selectedItem = state.item.firstWhere(
                                          (element) => element.itemId == value);
                                    })
                                  : state is GetItemByWarehouseSuccessState
                                      ? setState(() {
                                          selectedItem = state.item.firstWhere(
                                              (element) =>
                                                  element.itemId == value);
                                        })
                                      : {};
                              //  print(value);
                              //setState(() {
                              // selectedItem = state.item.firstWhere(
                              //     (element) => element.itemId == value);
                              //});
                            },
                            selectedItem: selectedItem == null
                                ? ''
                                : selectedItem!.itemId,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 350 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            child: DropdownSearch<String>(
                              mode: Mode.MENU,
                              items: state is GetAllInfoExportSuccessState
                                  ? state.item
                                      .map((e) => e.itemName.toString())
                                      .toList()
                                  : state is GetItemByWarehouseSuccessState
                                      ? state.item
                                          .map((e) => e.itemName.toString())
                                          .toList()
                                      : [],
                              showSearchBox: true,
                              label: "Tên sản phẩm",
                              onChanged: (value) {
                                print(value);
                                state is GetAllInfoImportSuccessState
                                    ? setState(() {
                                        selectedItem = state.item.firstWhere(
                                            (element) =>
                                                element.itemId == value);
                                      })
                                    : state is GetItemByWarehouseSuccessState
                                        ? setState(() {
                                            selectedItem = state.item
                                                .firstWhere((element) =>
                                                    element.itemId == value);
                                          })
                                        : {};
                              },
                              selectedItem: selectedItem == null
                                  ? ''
                                  : selectedItem!.itemName,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5 * SizeConfig.ratioHeight),
                                width: 160 * SizeConfig.ratioWidth,
                                height: 60 * SizeConfig.ratioHeight,
                                child: CustomizeDatePicker(
                                  name: "Từ ngày",
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  initDateTime: date,
                                  okBtnClickedFunction: (pickedTime) {
                                    date = pickedTime;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5 * SizeConfig.ratioHeight),
                                width: 160 * SizeConfig.ratioWidth,
                                height: 60 * SizeConfig.ratioHeight,
                                child: CustomizeDatePicker(
                                  name: "Đến ngày",
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  initDateTime: date,
                                  okBtnClickedFunction: (pickedTime) {
                                    date = pickedTime;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomizedButton(
                            text: "Truy xuất",
                            onPressed: () {
                              BlocProvider.of<HistoryBloc>(context)
                                  .add(TestHistoryEvent(
                                DateTime.now(),
                                warehouse,
                              ));
                              Navigator.pushNamed(
                                context,
                                '/list_export_history_screen',
                              );
                            }),
                        const Divider(
                          indent: 30,
                          endIndent: 30,
                          color: Constants.mainColor,
                          thickness: 1,
                        ),
                      ]);
                    }),
                // BlocConsumer<HistoryBloc, HistoryState>(
                //     listener: (context, state) {},
                //     builder: (context, state) {
                //       if (state is TestHistorySuccessState) {
                //         return Column(
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(
                //                 overflow: TextOverflow.ellipsis,
                //                 "Danh sách các lô hàng",
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.w600,
                //                   fontSize: 20 * SizeConfig.ratioFont,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //                 height: 500 * SizeConfig.ratioHeight,
                //                 child: ListView.builder(
                //                     // shrinkWrap: true,
                //                     itemCount: state.goodReceiptLots.length,
                //                     itemBuilder:
                //                         (BuildContext context, int index) {
                //                       return Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: Column(
                //                           children: [
                //                             Divider(
                //                               // indent: 30,
                //                               // endIndent: 30,
                //                               color: Constants.mainColor,
                //                               thickness: 1,
                //                             ),
                //                             ListTile(
                //                                 leading: const Icon(Icons.list),
                //                                 // shape: RoundedRectangleBorder(
                //                                 //   side: BorderSide(width: 1),
                //                                 //   borderRadius:
                //                                 //       BorderRadius.circular(10),
                //                                 // ),
                //                                 trailing: Icon(
                //                                     Icons.arrow_drop_down_sharp,
                //                                     size: 15 *
                //                                         SizeConfig.ratioFont),
                //                                 title: Text(
                //                                     "Mã lô : ${state.goodReceiptLots[index].goodsReceiptLotId}"),
                //                                 subtitle: Row(
                //                                   mainAxisAlignment:
                //                                       MainAxisAlignment
                //                                           .spaceBetween,
                //                                   children: [
                //                                     Text(
                //                                         "Sản phẩm : ${state.goodReceiptLots[index].goodsReceiptLotId.toString()}  \nSố lượng : ${state.goodReceiptLots[index].quantity.toString()} \nVị trí : ${state.goodReceiptLots[index].location.toString()}"),
                //                                     Text(
                //                                         "Số PO : ${state.goodReceiptLots[index].purchaseOrderNumber.toString()} \nĐịnh mức : ${state.goodReceiptLots[index].sublotSize.toString()}"),
                //                                   ],
                //                                 ),
                //                                 isThreeLine: true,
                //                                 onTap: () {}),
                //                           ],
                //                         ),
                //                       );
                //                     })),
                //             CustomizedButton(
                //               onPressed: () {},
                //               text: "Trở lại",
                //             )
                //           ],
                //         );
                //       } else {
                //         print(state);
                //         return const Center(child: CircularProgressIndicator());
                //       }
                // }
                // )
              ]))
        ]));
  }
}
