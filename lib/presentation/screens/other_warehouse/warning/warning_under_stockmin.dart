// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import '../../../../../constant.dart';

import '../../../bloc/blocs/other/warning_bloc.dart';
import '../../../bloc/events/other/warning_stocklevel_events.dart';
import '../../../bloc/states/other/warning_states.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

class WarningUnderStockminScreen extends StatefulWidget {
  const WarningUnderStockminScreen({super.key});

  @override
  State<WarningUnderStockminScreen> createState() =>
      _WarningUnderStockminScreenSate();
}

class _WarningUnderStockminScreenSate
    extends State<WarningUnderStockminScreen> {
  List<Warehouse> warehouseDropdownData = [];
  Warehouse? selectedWarehouse;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/warning_function_screen");
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/warning_function_screen');
              },
            ),
            backgroundColor: Constants.mainColor,
            title: Text(
              'Cảnh báo',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body: Column(
            children: [
              BlocConsumer<WarningBloc, WarningState>(
                  listener: (context, state) {
                if (state is GetWarehouseSuccessState) {
                  warehouseDropdownData = state.warehouse;
                }
                if (state is MinimumStockWarningSuccessState) {
                  warehouseDropdownData = state.warehouse;
                }
                if (state is MinimumStockWarningLoadingState)
                {}
              }, builder: (context, state) {
                if (state is GetWarehouseSuccessState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state.warehouse
                                .map((e) => e.warehouseName)
                                .toList(),
                            showSearchBox: true,
                            label: "Kho hàng",
                            onChanged: (value) {
                              selectedWarehouse = null;
                              setState(() {
                                selectedWarehouse = state.warehouse.firstWhere(
                                    (element) =>
                                        element.warehouseName == value);
                              });
                            },
                            selectedItem: selectedWarehouse == null
                                ? ''
                                : selectedWarehouse!.warehouseId,
                          ),
                        ),
                      ),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<WarningBloc>(context).add(
                                LoadMinimumStockWarningEvent(
                                    DateTime.now(),
                                    selectedWarehouse!.warehouseId,
                                    state.warehouse

                                    //state.warehouse
                                    ));
                          }),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Constants.mainColor,
                        thickness: 1,
                      ),
                      ExceptionErrorState(
                        title: 'Chưa có thông tin để truy xuất',
                        message: "Chọn kho hàng để truy xuất",
                      ),
                    ],
                  );
                }
                if (state is MinimumStockWarningSuccessState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state.warehouse
                                .map((e) => e.warehouseName)
                                .toList(),
                            showSearchBox: true,
                            label: "Kho hàng",
                            onChanged: (value) {
                              selectedWarehouse = null;
                              setState(() {
                                selectedWarehouse = state.warehouse.firstWhere(
                                    (element) =>
                                        element.warehouseName == value);
                              });
                            },
                            selectedItem: selectedWarehouse == null
                                ? ''
                                : selectedWarehouse!.warehouseId,
                          ),
                        ),
                      ),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<WarningBloc>(context).add(
                                LoadMinimumStockWarningEvent(
                                    DateTime.now(),
                                    selectedWarehouse!.warehouseId,
                                    state.warehouse

                                    //state.warehouse
                                    ));
                          }),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Constants.mainColor,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 450 * SizeConfig.ratioHeight,
                        child: ListView.builder(
                            itemCount: state.itemLot.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    // trailing: Icon(Icons.edit,
                                    //     size: 17 * SizeConfig.ratioFont),
                                    title: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8.0, 0, 8.0),
                                      child: Text(
                                        "Mã lô : ${state.itemLot[index].lotId}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16 * SizeConfig.ratioFont,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150 * SizeConfig.ratioWidth,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont,
                                                    color: Colors.black,
                                                  ),
                                                  "Mã hàng: ${state.itemLot[index].item!.itemId}"),
                                              Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont,
                                                    color: Colors.black,
                                                  ),
                                                  "Tên hàng: ${state.itemLot[index].item!.itemName}"),
                                              Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont,
                                                    color: Colors.black,
                                                  ),
                                                  "Số lượng: ${state.itemLot[index].quantity}"),
                                              Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont,
                                                    color: Colors.black,
                                                  ),
                                                  "Vị trí: ${state.itemLot[index].location?.locationId ?? '...'}"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150 * SizeConfig.ratioWidth,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont,
                                                    color: Colors.black,
                                                  ),
                                                  "Định mức: ${state.itemLot[index].sublotSize ?? '...'}  "),
                                              // Text(
                                              //     overflow: TextOverflow.ellipsis,
                                              //     style: TextStyle(
                                              //       fontWeight: FontWeight.w100,
                                              //       fontSize:
                                              //           16 * SizeConfig.ratioFont,
                                              //       color: Colors.black,
                                              //     ),
                                              //     "Số PO: ${state.itemLot[index].purchaseOrderNumber ?? '...'}"),
                                              Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont,
                                                    color: Colors.black,
                                                  ),
                                                  "NSX: ${DateFormat('yyyy-MM-dd').format(state.itemLot[index].productionDate as DateTime)}"),
                                              Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont,
                                                    color: Colors.black,
                                                  ),
                                                  "HSD: ${DateFormat('yyyy-MM-dd').format(state.itemLot[index].expirationDate as DateTime)}"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    isThreeLine: true,
                                    onTap: () {},
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                }
                if (state is MinimumStockWarningFailState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state.warehouse
                                .map((e) => e.warehouseName)
                                .toList(),
                            showSearchBox: true,
                            label: "Kho hàng",
                            onChanged: (value) {
                              selectedWarehouse = null;
                              setState(() {
                                selectedWarehouse = state.warehouse.firstWhere(
                                    (element) =>
                                        element.warehouseName == value);
                              });
                            },
                            selectedItem: selectedWarehouse == null
                                ? ''
                                : selectedWarehouse!.warehouseId,
                          ),
                        ),
                      ),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<WarningBloc>(context).add(
                                LoadMinimumStockWarningEvent(
                                    DateTime.now(),
                                    selectedWarehouse!.warehouseId,
                                    state.warehouse

                                    //state.warehouse
                                    ));
                          }),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Constants.mainColor,
                        thickness: 1,
                      ),
                      Center(
                        child: ExceptionErrorState(
                          title: state.detail,
                          message: "Chọn lại thông tin để truy xuất",
                        ),
                      ),
                    ],
                  );
                }
                if (state is MinimumStockWarningLoadingState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state.warehouse
                                .map((e) => e.warehouseName)
                                .toList(),
                            showSearchBox: true,
                            label: "Kho hàng",
                            onChanged: (value) {
                              selectedWarehouse = null;
                              setState(() {
                                selectedWarehouse = state.warehouse.firstWhere(
                                    (element) =>
                                        element.warehouseName == value);
                              });
                            },
                            selectedItem: selectedWarehouse == null
                                ? ''
                                : selectedWarehouse!.warehouseId,
                          ),
                        ),
                      ),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<WarningBloc>(context).add(
                                LoadMinimumStockWarningEvent(
                                    DateTime.now(),
                                    selectedWarehouse!.warehouseId,
                                    state.warehouse

                                    //state.warehouse
                                    ));
                          }),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Constants.mainColor,
                        thickness: 1,
                      ),
                      const Dialog(
                        // The background color
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state.warehouse
                                .map((e) => e.warehouseName)
                                .toList(),
                            showSearchBox: true,
                            label: "Kho hàng",
                            onChanged: (value) {
                              selectedWarehouse = null;
                              setState(() {
                                selectedWarehouse = state.warehouse.firstWhere(
                                    (element) =>
                                        element.warehouseName == value);
                              });
                            },
                            selectedItem: selectedWarehouse == null
                                ? ''
                                : selectedWarehouse!.warehouseId,
                          ),
                        ),
                      ),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            BlocProvider.of<WarningBloc>(context).add(
                                LoadMinimumStockWarningEvent(
                                    DateTime.now(),
                                    selectedWarehouse!.warehouseId,
                                    state.warehouse

                                    //state.warehouse
                                    ));
                          }),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Constants.mainColor,
                        thickness: 1,
                      ),
                      Center(
                        child: ExceptionErrorState(
                          title: 'Chưa có thông tin để truy xuất',
                          message: "Chọn kho hàng để truy xuất",
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          )),
    );
  }
}
