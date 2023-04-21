// ignore_for_file: deprecated_member_use, avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

import '../../../constant.dart';
import '../../bloc/blocs/warning_bloc.dart';
import '../../bloc/events/warning_events.dart';
import '../../bloc/states/warning_states.dart';
import '../../widgets/button_widget.dart';

class WarningUnderStockminScreen extends StatefulWidget {
  const WarningUnderStockminScreen({super.key});

  @override
  State<WarningUnderStockminScreen> createState() =>
      _WarningUnderStockminScreenSate();
}

class _WarningUnderStockminScreenSate
    extends State<WarningUnderStockminScreen> {
  Warehouse? selectedWarehouse;
  String warehouse = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
        body: Column(children: [
          BlocConsumer<WarningBloc, WarningState>(
              listener: (context, state) {},
              builder: (context, state) {
                //if (state is GetWarehouseSuccessState) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: SizedBox(
                          width: 340 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: state is GetWarehouseSuccessState
                                ? state.warehouse
                                    .map((e) => e.warehouseId)
                                    .toList():state is MinimumStockWarningSuccessState
                                ? state.listWarehouse
                                    .map((e) => e.warehouseId)
                                    .toList()
                                : [],
                         
                            showSearchBox: true,
                            label: "Kho hàng",
                            onChanged: (value) {
                              //  print(value);
                              print(value);
                              state is GetWarehouseSuccessState
                                  ? setState(() {
                                      selectedWarehouse = state.warehouse
                                          .firstWhere((element) =>
                                              element.warehouseId == value);
                                      // BlocProvider.of<WarningBloc>(context)
                                      //     .add(MinimumStockWarningEvent(
                                      //   DateTime.now(),
                                      //   selectedWarehouse!.warehouseId,
                                      //   state.warehouse,
                                      //   state.warehouse,
                                      // ));
                                    })
                                  : {};
                            },
                            selectedItem: selectedWarehouse == null
                                ? ''
                                : selectedWarehouse!.warehouseName,
                          ),
                        ),
                      ),
                      CustomizedButton(
                          text: "Truy xuất",
                          onPressed: () {
                            // BlocProvider.of<WarningBloc>(context).add(
                            //     MinimumStockWarningEvent(
                            //         DateTime.now(),
                            //         selectedWarehouse!.warehouseId,
                                    
                            //         state.warehouse));
                          }),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Constants.mainColor,
                        thickness: 1,
                      ),
                      //]);
                      //}
                      BlocConsumer<WarningBloc, WarningState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is MinimumStockWarningSuccessState) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 340 * SizeConfig.ratioWidth,
                                      height: 60 * SizeConfig.ratioHeight,
                                      child: DropdownSearch<dynamic>(
                                        mode: Mode.MENU,
                                        items: state.listWarehouse
                                            .map((e) => e.warehouseName)
                                            .toList(),
                                        showSearchBox: true,
                                        label: "Kho hàng",
                                        // hint: "country in menu mode",
                                        onChanged: (value) {
                                          //  print(value);
                                          setState(() {
                                            selectedWarehouse = state
                                                .listWarehouse
                                                .firstWhere((element) =>
                                                    element.warehouseName ==
                                                    value);
                                          });
                                        },
                                        selectedItem: selectedWarehouse == null
                                            ? ''
                                            : selectedWarehouse!.warehouseName,
                                      ),
                                    ),
                                  ),
                                  CustomizedButton(
                                      text: "Truy xuất",
                                      onPressed: () {
                                        // BlocProvider.of<WarningBloc>(context)
                                        //     .add(MinimumStockWarningEvent(
                                        //         DateTime.now(),
                                        //         selectedWarehouse!
                                        //             .warehouseName,
                                               
                                        //         state.listWarehouse));
                                      }),
                                  const Divider(
                                    indent: 30,
                                    endIndent: 30,
                                    color: Constants.mainColor,
                                    thickness: 1,
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    "Danh sách các lô hàng",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20 * SizeConfig.ratioFont,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                      height: 450 * SizeConfig.ratioHeight,
                                      child: ListView.builder(
                                          itemCount: state.itemLot.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 110.0 *
                                                      SizeConfig.ratioHeight,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ListTile(
                                                      leading: const Icon(
                                                          Icons.list),

                                                      // shape: RoundedRectangleBorder(
                                                      //   side: const BorderSide(width: 1),
                                                      //   borderRadius: BorderRadius.circular(10),
                                                      // ),

                                                      trailing: Icon(
                                                          Icons
                                                              .arrow_drop_down_sharp,
                                                          size: 15 *
                                                              SizeConfig
                                                                  .ratioFont),
                                                      title: Text(
                                                          "Mã lô : ${state.itemLot[index].lotId}"),
                                                      subtitle: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Sản phẩm : ${state.itemLot[index].item.itemId.toString()}  \nSố lượng : ${state.itemLot[index].quantity.toString()} \nVị trí : ${state.itemLot[index].location.toString()}"),
                                                          Text(
                                                              "Số PO : ${state.itemLot[index].purchaseOrderNumber.toString()} \nĐịnh mức : ${state.itemLot[index].sublotSize.toString()}"),
                                                        ],
                                                      ),
                                                      isThreeLine: true,
                                                      onTap: () {}),
                                                ));
                                          })),
                                ],
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          })
                    ]);
              })
        ]));
  }
}
