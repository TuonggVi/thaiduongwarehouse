// ignore_for_file: unused_local_variable, deprecated_member_use, avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/department.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import '../../../constant.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/entities/location.dart';
import '../../bloc/blocs/history_bloc.dart';
import '../../bloc/events/history_events.dart';
import '../../bloc/states/history_states.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/customized_date_picker.dart';

class ImportHistoryScreen extends StatefulWidget {
  const ImportHistoryScreen({super.key});

  @override
  State<ImportHistoryScreen> createState() => _ImportHistoryScreenState();
}

class _ImportHistoryScreenState extends State<ImportHistoryScreen> {
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
            'Lịch sử nhập kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body:  SingleChildScrollView(
          child: ExpansionPanelList.radio(
            children: [
              ExpansionPanelRadio(value: 1, headerBuilder: ((context, isExpanded){return const Text('Truy xuất theo sản phẩm');}), body: 
                 Column(
            children: [
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
                        if(state is GetAllInfoImportSuccessState){
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: SizedBox(
                                  width: 170 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  child: DropdownSearch<dynamic>(
                                    mode: Mode.MENU,
                                    items:
                                         state.warehouse.map((e) => e.warehouseId)
                                            .toList(),
                                        // state is GetAllInfoImportSuccessState
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
                                      selectedItem=null;
                                      print(value);
                                       setState(() {
                                              selectedWarehouse = state.warehouse
                                                  .firstWhere((element) =>
                                                      element.warehouseId == value);
                                              BlocProvider.of<HistoryBloc>(context)
                                                  .add(GetItemByWarehouseEvent(
                                                      DateTime.now(),
                                                      selectedWarehouse!.warehouseId,
                                                      state.item,
                                                      state.item,
                                                      state.warehouse,
                                                      state.department));
                                            })
                                         ;
                                      
                                    },
                                    selectedItem: selectedWarehouse == null
                                        ? ''
                                        : selectedWarehouse!.warehouseName,
                                  ),
                                ),
                              ),
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                 child: SizedBox(
                                  width: 170 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    items: state.department.map((e) => e.name).toList(),
                                    // state is GetAllInfoImportSuccessState
                                    //     ? state.department.map((e) => e.name).toList()
                                    //     : state is GetItemByWarehouseSuccessState
                                    //         ? state.department
                                    //             .map((e) => e.name)
                                    //             .toList()
                                    //         : [],
                                    showSearchBox: true,
                                    label: "Nhà cung cấp",
                                    onChanged: (value) {
                                      state is GetAllInfoImportSuccessState
                                          ?
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
                               ),
                                ],
                              ),
                              SizedBox(
                                width: 350 * SizeConfig.ratioWidth,
                                height: 60 * SizeConfig.ratioHeight,
                                child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  items: state.item
                                          .map((e) => e.itemId.toString())
                                          .toList(),
                                  // state is GetAllInfoImportSuccessState
                                  //     ? state.item
                                  //         .map((e) => e.itemId.toString())
                                  //         .toList()
                                  //     : state is GetItemByWarehouseSuccessState
                                  //         ? state.item
                                  //             .map((e) => e.itemId.toString())
                                  //             .toList()
                                  //         : [],
                                  showSearchBox: true,
                                  label: "Mã sản phẩm",
                                  onChanged: (value) {
                                    print(value);
                                    print(value);
                                    setState(() {
                                              selectedItem = state.item.firstWhere(
                                                  (element) =>
                                                      element.itemId == value);
                                            });
                                      // state is GetAllInfoImportSuccessState
                                      //     ? setState(() {
                                      //         selectedItem = state.item.firstWhere(
                                      //             (element) =>
                                      //                 element.itemId == value);
                                      //       })
                                      //     : state is GetItemByWarehouseSuccessState
                                      //         ? setState(() {
                                      //             selectedItem = state.item
                                      //                 .firstWhere((element) =>
                                      //                     element.itemId == value);
                                      //           })
                                      //         : {};
                                   
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
                                    items: state.item
                                            .map((e) => e.itemName.toString())
                                            .toList(),
                                    // state is GetAllInfoImportSuccessState
                                    //     ? state.item
                                    //         .map((e) => e.itemName.toString())
                                    //         .toList()
                                    //     : state is GetItemByWarehouseSuccessState
                                    //         ? state.item
                                    //             .map((e) => e.itemName.toString())
                                    //             .toList()
                                    //         : [],
                                    showSearchBox: true,
                                    label: "Tên sản phẩm",
                                    // hint: "country in menu mode",
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                              selectedItem = state.item.firstWhere(
                                                  (element) =>
                                                      element.itemName == value);
                                            });
                                      // state is GetAllInfoImportSuccessState
                                      //     ? setState(() {
                                      //         selectedItem = state.item.firstWhere(
                                      //             (element) =>
                                      //                 element.itemName == value);
                                      //       })
                                      //     : state is GetItemByWarehouseSuccessState
                                      //         ? setState(() {
                                      //             selectedItem = state.item
                                      //                 .firstWhere((element) =>
                                      //                     element.itemName == value);
                                      //           })
                                      //         : {};
                                    
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
                                '/list_import_history_screen',
                              );
                            }),
                            ],
                          );
                        }if(state is GetItemByWarehouseSuccessState){
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: SizedBox(
                                  width: 170 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  child: DropdownSearch<dynamic>(
                                    mode: Mode.MENU,
                                    items:
                                         state.warehouse.map((e) => e.warehouseId)
                                            .toList(),
                                        // state is GetAllInfoImportSuccessState
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
                                    // hint: "country in menu mode",
                                    onChanged: (value) {
                                      selectedItem=null;
                                      print(value);
                                       setState(() {
                                              selectedWarehouse = state.warehouse
                                                  .firstWhere((element) =>
                                                      element.warehouseId == value);
                                              BlocProvider.of<HistoryBloc>(context)
                                                  .add(GetItemByWarehouseEvent(
                                                      DateTime.now(),
                                                      selectedWarehouse!.warehouseId,
                                                      state.listAllItem,
                                                      state.item,
                                                      state.warehouse,
                                                     state.department));
                                            })
                                         ;
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
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                 child: SizedBox(
                                  width: 170 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    items: state.department.map((e) => e.name).toList(),
                                    // state is GetAllInfoImportSuccessState
                                    //     ? state.department.map((e) => e.name).toList()
                                    //     : state is GetItemByWarehouseSuccessState
                                    //         ? state.department
                                    //             .map((e) => e.name)
                                    //             .toList()
                                    //         : [],
                                    showSearchBox: true,
                                    label: "Nhà cung cấp",
                                    onChanged: (value) {
                                      state is GetAllInfoImportSuccessState
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
                               ),
                                ],
                              ),
                              SizedBox(
                                width: 350 * SizeConfig.ratioWidth,
                                height: 60 * SizeConfig.ratioHeight,
                                child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  items: state.item
                                          .map((e) => e.itemId.toString())
                                          .toList(),
                                  // state is GetAllInfoImportSuccessState
                                  //     ? state.item
                                  //         .map((e) => e.itemId.toString())
                                  //         .toList()
                                  //     : state is GetItemByWarehouseSuccessState
                                  //         ? state.item
                                  //             .map((e) => e.itemId.toString())
                                  //             .toList()
                                  //         : [],
                                  showSearchBox: true,
                                  label: "Mã sản phẩm",
                                  // hint: "country in menu mode",
                                  onChanged: (value) {
                                    print(value);
                                    print(value);
                                    setState(() {
                                              selectedItem = state.item.firstWhere(
                                                  (element) =>
                                                      element.itemId == value);
                                            });
                                      // state is GetAllInfoImportSuccessState
                                      //     ? setState(() {
                                      //         selectedItem = state.item.firstWhere(
                                      //             (element) =>
                                      //                 element.itemId == value);
                                      //       })
                                      //     : state is GetItemByWarehouseSuccessState
                                      //         ? setState(() {
                                      //             selectedItem = state.item
                                      //                 .firstWhere((element) =>
                                      //                     element.itemId == value);
                                      //           })
                                      //         : {};
                                    // //  print(value);
                                    // setState(() {
                                    //   selectedItem = state.item.firstWhere(
                                    //       (element) => element.itemId == value);
                                    // });
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
                                    items: state.item
                                            .map((e) => e.itemName.toString())
                                            .toList(),
                                    // state is GetAllInfoImportSuccessState
                                    //     ? state.item
                                    //         .map((e) => e.itemName.toString())
                                    //         .toList()
                                    //     : state is GetItemByWarehouseSuccessState
                                    //         ? state.item
                                    //             .map((e) => e.itemName.toString())
                                    //             .toList()
                                    //         : [],
                                    showSearchBox: true,
                                    label: "Tên sản phẩm",
                                    // hint: "country in menu mode",
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                              selectedItem = state.item.firstWhere(
                                                  (element) =>
                                                      element.itemName == value);
                                            });
                                      // state is GetAllInfoImportSuccessState
                                      //     ? setState(() {
                                      //         selectedItem = state.item.firstWhere(
                                      //             (element) =>
                                      //                 element.itemName == value);
                                      //       })
                                      //     : state is GetItemByWarehouseSuccessState
                                      //         ? setState(() {
                                      //             selectedItem = state.item
                                      //                 .firstWhere((element) =>
                                      //                     element.itemName == value);
                                      //           })
                                      //         : {};
                                    
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
                                '/list_import_history_screen',
                              );
                            }),
                            ],
                          );
                        }else{
        return CircularProgressIndicator();
        
                        }
                      }),
                       
            ],
          ),
              ),
                            ExpansionPanelRadio(value: 2, headerBuilder: ((context, isExpanded){return const Text('TRUY XUẤT THEO NHÀ CUNG CẤP');}), body:   BlocConsumer<HistoryBloc, HistoryState>(
                          listener: (context, state) {
                        if (state is GetAllInfoImportSuccessState) {
                          warehouseDropdownData = state.warehouse;
                          itemsDropdownData = state.item;
                        }
                        if (state is GetItemByWarehouseSuccessState) {
                          itemsDropdownData = state.item;
                        }
                      }, builder: (context, state) {
                        if(state is GetAllInfoImportSuccessState){
                         return  SizedBox(
                                width: 160 * SizeConfig.ratioWidth,
                                height: 60 * SizeConfig.ratioHeight,
                                child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  items: state.department.map((e) => e.name).toList(),
                                  // state is GetAllInfoImportSuccessState
                                  //     ? state.department.map((e) => e.name).toList()
                                  //     : state is GetItemByWarehouseSuccessState
                                  //         ? state.department
                                  //             .map((e) => e.name)
                                  //             .toList()
                                  //         : [],
                                  showSearchBox: true,
                                  label: "Nhà cung cấp",
                                  onChanged: (value) {
                                    state is GetAllInfoImportSuccessState
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
                              );
                        }else{
                          return CircularProgressIndicator();
                        }
                      }),
                                         


           ),
            ExpansionPanelRadio(value: 3, headerBuilder: ((context, isExpanded){return const Text('TRUY XUẤT THEO PO');}), body: Text('hihi'))
            ],
           
          ),
          
        
        ));
  }
}
