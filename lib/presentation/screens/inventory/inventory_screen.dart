// ignore_for_file: prefer_const_constructors, avoid_print, deprecated_member_use, unused_import

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

import '../../../constant.dart';
import '../../../domain/entities/location.dart';
import '../../bloc/blocs/inventory_bloc.dart';
import '../../bloc/events/inventory_events.dart';
import '../../bloc/states/inventory_states.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/customized_date_picker.dart';

class StockcardScreen extends StatefulWidget {
  const StockcardScreen({super.key});

  @override
  State<StockcardScreen> createState() => _StockcardScreenState();
}

class _StockcardScreenState extends State<StockcardScreen> {
  List<Item> itemsDropdownData = [];
  Item? selectedItem;
  List<ItemClass> itemClassDropdownData = [];
  ItemClass? selectedItemClass;
  Warehouse? selectedWarehouse;
  List<Warehouse> warehouseDropdownData = [];
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
              Navigator.pushNamed(context, '/stockcard_function_screen');
            },
          ),
          title: Text(
            'Truy xuất tồn kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: Column(
          children: [
            BlocConsumer<InventoryBloc, InventoryState>(
                listener: (context, state) {
              if (state is GetWarehouseIdSuccessState) {
                warehouseDropdownData = state.warehouse;
                itemsDropdownData = state.item;
              }
              if (state is GetAllItemByWarehouseSuccessState) {
                itemsDropdownData = state.item;
              }
            }, builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: SizedBox(
                      width: 340 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state is GetWarehouseIdSuccessState
                            ? state.warehouse.map((e) => e.warehouseId).toList()
                            : state is GetAllItemByWarehouseSuccessState
                                ? state.warehouse
                                    .map((e) => e.warehouseId)
                                    .toList()
                                : [],
                        showSearchBox: true,
                        label: "Kho hàng",
                        onChanged: (value) {
                          //  print(value);
                          print(value);
                          state is GetWarehouseIdSuccessState
                              ? setState(() {
                                  selectedWarehouse = state.warehouse
                                      .firstWhere((element) =>
                                          element.warehouseId == value);
                                  BlocProvider.of<InventoryBloc>(context)
                                      .add(GetAllItemIdByWarehouseEvent(
                                    DateTime.now(),
                                    selectedWarehouse!.warehouseId,
                                    state.item,
                                    state.warehouse,
                                  ));
                                })
                              : {};
                        },
                        selectedItem: selectedWarehouse == null
                            ? ''
                            : selectedWarehouse!.warehouseName,
                      ),
                    ),
                  ),
                  BlocConsumer<InventoryBloc, InventoryState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(
                              width: 350 * SizeConfig.ratioWidth,
                              height: 60 * SizeConfig.ratioHeight,
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                items: state is GetWarehouseIdSuccessState
                                    ? state.item
                                        .map((e) => e.itemId.toString())
                                        .toList()
                                    : state is GetAllItemByWarehouseSuccessState
                                        ? state.item
                                            .map((e) => e.itemId.toString())
                                            .toList()
                                        : [],
                                showSearchBox: true,
                                label: "Mã sản phẩm",
                                onChanged: (value) {
                                  print(value);
                                  print(value);
                                  state is GetWarehouseIdSuccessState
                                      ? setState(() {
                                          selectedItem = state.item.firstWhere(
                                              (element) =>
                                                  element.itemId == value);
                                        })
                                      : state is GetAllItemByWarehouseSuccessState
                                          ? setState(() {
                                              selectedItem = state.item
                                                  .firstWhere((element) =>
                                                      element.itemId == value);
                                            })
                                          : {};
                                },
                                selectedItem: selectedItem == null
                                    ? ''
                                    : selectedItem!.itemId,
                              ),
                            ),
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 350 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state is GetWarehouseIdSuccessState
                            ? state.item
                                .map((e) => e.itemName.toString())
                                .toList()
                            : state is GetAllItemByWarehouseSuccessState
                                ? state.item
                                    .map((e) => e.itemName.toString())
                                    .toList()
                                : [],
                        showSearchBox: true,
                        label: "Tên sản phẩm",
                        // hint: "country in menu mode",
                        onChanged: (value) {
                          print(value);
                          state is GetWarehouseIdSuccessState
                              ? setState(() {
                                  selectedItem = state.item.firstWhere(
                                      (element) => element.itemName == value);
                                })
                              : state is GetAllItemByWarehouseSuccessState
                                  ? setState(() {
                                      selectedItem = state.item.firstWhere(
                                          (element) =>
                                              element.itemName == value);
                                    })
                                  : {};
                        },
                        selectedItem:
                            selectedItem == null ? '' : selectedItem!.itemName,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                        BlocProvider.of<InventoryBloc>(context).add(
                            LoadInventoryEvent(
                                DateTime.now(),
                                selectedWarehouse!.warehouseName,
                                startDate,
                                endDate
                                //state.warehouse
                                ));
                      }),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Constants.mainColor,
                    thickness: 1,
                  ),
              //  ],
             // );
          //  }
               // if (state is LoadInventoryLotSuccessState) {
                  //return
                  //  Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8),
                  //       child: SizedBox(
                  //         width: 340 * SizeConfig.ratioWidth,
                  //         height: 60 * SizeConfig.ratioHeight,
                  //         child: DropdownSearch<String?>(
                  //           mode: Mode.MENU,
                  //           items: state.listItemClass
                  //               .map((e) => e.itemClassId)
                  //               .toList(),
                  //           showSearchBox: true,
                  //           label: "Kho hàng",
                  //           onChanged: (value) {
                  //             //  print(value);
                  //             setState(() {
                  //               selectedItemClass = state.listItemClass
                  //                   .firstWhere((element) =>
                  //                       element.itemClassId == value);
                  //             });
                  //           },
                  //           selectedItem: selectedItemClass == null
                  //               ? ''
                  //               : selectedItemClass!.itemClassId,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 340 * SizeConfig.ratioWidth,
                  //       height: 60 * SizeConfig.ratioHeight,
                  //       child: DropdownSearch<String>(
                  //         mode: Mode.MENU,
                  //         showSearchBox: true,
                  //         label: "Mã sản phẩm",
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: SizedBox(
                  //         width: 340 * SizeConfig.ratioWidth,
                  //         height: 60 * SizeConfig.ratioHeight,
                  //         child: DropdownSearch<String>(
                  //           mode: Mode.MENU,
                  //           showSearchBox: true,
                  //           label: "Tên sản phẩm",
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Container(
                  //             margin: EdgeInsets.symmetric(
                  //                 vertical: 5 * SizeConfig.ratioHeight),
                  //             width: 160 * SizeConfig.ratioWidth,
                  //             height: 60 * SizeConfig.ratioHeight,
                  //             child: CustomizeDatePicker(
                  //               name: "Từ ngày",
                  //               fontColor: Colors.black,
                  //               fontWeight: FontWeight.normal,
                  //               initDateTime: date,
                  //               okBtnClickedFunction: (pickedTime) {
                  //                 date = pickedTime;
                  //               },
                  //             ),
                  //           ),
                  //           Container(
                  //             margin: EdgeInsets.symmetric(
                  //                 vertical: 5 * SizeConfig.ratioHeight),
                  //             width: 160 * SizeConfig.ratioWidth,
                  //             height: 60 * SizeConfig.ratioHeight,
                  //             child: CustomizeDatePicker(
                  //               name: "Đến ngày",
                  //               fontColor: Colors.black,
                  //               fontWeight: FontWeight.normal,
                  //               initDateTime: date,
                  //               okBtnClickedFunction: (pickedTime) {
                  //                 date = pickedTime;
                  //               },
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     CustomizedButton(
                  //         text: "Truy xuất",
                  //         onPressed: () {
                  //           BlocProvider.of<InventoryBloc>(context).add(
                  //               LoadInventoryLotEvent(
                  //                   DateTime.now(),
                  //                   selectedItemClass!.itemClassId,
                  //                   state.listItemClass));
                  //         }),
                  //     const Divider(
                  //       indent: 30,
                  //       endIndent: 30,
                  //       color: Constants.mainColor,
                  //       thickness: 1,
                  //     ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Danh sách các lô hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                      // SizedBox(
                      //     height: 250 * SizeConfig.ratioHeight,
                      //     child: ListView.builder(
                      //       itemCount:
                          // state.itemLots.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Container(
                          //         height: 110.0 * SizeConfig.ratioHeight,
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //             width: 1,
                          //           ),
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         child: ListTile(
                          //             leading: const Icon(Icons.list),
                          //             trailing: Icon(
                          //                 Icons.arrow_drop_down_sharp,
                          //                 size: 15 * SizeConfig.ratioFont),
                          //             title: Text(
                          //                 "Mã lô : ${state.itemLots[index].item.itemId}"),
                          //             subtitle: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Text(
                          //                     "Sản phẩm : ${state.itemLots[index].item.itemName.toString()}  \nSố lượng : ${state.itemLots[index].beforeQuantity.toString()} \nVị trí : ${state.itemLots[index].itemLot.location.toString()}"),
                          //                 Text(
                          //                     "Số PO : ${state.itemLots[index].itemLot.purchaseOrderNumber.toString()} \nĐịnh mức : ${state.itemLots[index].itemLot.sublotSize.toString()}"),
                          //               ],
                          //             ),
                          //             isThreeLine: true,
                          //             onTap: () {}),
                          //       ),
                          //     );
                          //   },
                          // )),
                    ],
                  );
                // } else {
                //   return const Center(child: CircularProgressIndicator());
                // }
                }
                ),
          ],
        ));
  }
}
