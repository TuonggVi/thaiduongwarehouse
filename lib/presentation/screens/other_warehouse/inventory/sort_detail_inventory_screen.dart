// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

import '../../../../constant.dart';
import '../../../../domain/entities/location.dart';
import '../../../bloc/blocs/other/inventory_bloc.dart';
import '../../../bloc/events/other/inventory_events.dart';
import '../../../bloc/states/other/inventory_states.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/customized_date_picker.dart';

// trang nhập thông tin truy xuất tồn kho
class StockcardScreen extends StatefulWidget {
  const StockcardScreen({super.key});

  @override
  State<StockcardScreen> createState() => _StockcardScreenState();
}

class _StockcardScreenState extends State<StockcardScreen> {
  List<Item> itemsDropdownData = [];
  Item? selectedItem;
  Warehouse? selectedWarehouse;
  List<Warehouse> warehouseDropdownData = [];
  String warehose = '';
  @override
  Widget build(BuildContext context) {
    DateTime startDate = (DateFormat('yyyy-MM-dd')
        .parse(DateTime.now().subtract(const Duration(days: 30)).toString()));
    // trừ 30 ngày ??
    DateTime endDate =
        (DateFormat('yyyy-MM-dd').parse(DateTime.now().toString()));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/stockcard_function_screen");
        return false;
      },
      child: Scaffold(
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
                  // cần dropdown nào thì lấy state đó
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
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: SizedBox(
                        width: 350 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        // cho phép tìm kiếm theo ký tự nhập vào 
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: state.warehouse
                              .map((e) => e.warehouseId)
                              .toList(),
                          showSearchBox: true,
                          label: "Kho hàng",
                          onChanged: (value) {
                            setState(() {
                              selectedWarehouse = state.warehouse.firstWhere(
                                  (element) => element.warehouseId == value);
                              BlocProvider.of<InventoryBloc>(context)
                                  .add(GetAllItemIdByWarehouseEvent(
                                DateTime.now(),
                                selectedWarehouse!.warehouseId,
                                state.item,
                                state.item,
                                state.warehouse,
                              ));
                            });
                          },
                          selectedItem: selectedWarehouse == null
                              ? ''
                              : selectedWarehouse!.warehouseName,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state.item.map((e) => e.itemId).toList(),
                        showSearchBox: true,
                        label: "Mã hàng",
                        onChanged: (value) {
                          selectedItem = null;
                          setState(() {
                            selectedItem = state.item.firstWhere(
                                (element) => element.itemId == value);
                          });
                        },
                        selectedItem:
                            selectedItem == null ? '' : selectedItem!.itemId,
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
                          showSearchBox: true,
                          label: "Tên hàng",
                          onChanged: (value) {
                            setState(() {
                              selectedItem = state.item.firstWhere(
                                  (element) => element.itemName == value);
                            });
                          },
                          selectedItem: selectedItem == null
                              ? ''
                              : selectedItem!.itemName,
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
                          selectedItem == null
                              ? {
                                  AlertDialogOneBtnCustomized(
                                          context,
                                          'Cảnh báo',
                                          'Vui lòng chọn thông tin để truy xuất',
                                          'Trở lại',
                                          'warning_image.png', () {
                                    // Navigator.pushNamed(context, '/main_receipt_screen');
                                  }, 20, 15, () {}, false)
                                      .show()
                                }
                              :
                              // BlocProvider.of<InventoryBloc>(context).add(
                              //     LoadInventoryLotEvent(
                              //         DateTime.now(),
                              //         selectedWarehouse!.warehouseId,
                              //        ));
                              {
                                  BlocProvider.of<InventoryBloc>(context).add(
                                      LoadInventoryEvent(
                                          DateTime.now(),
                                          selectedItem!.itemId,
                                          startDate,
                                          endDate,
                                          state.item,
                                          state.warehouse)),
                                  Navigator.pushNamed(
                                    context,
                                    '/list_inventory_screen',
                                  )
                                };
                        }),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Constants.mainColor,
                      thickness: 1,
                    ),
                  ],
                );
              }),
            ],
          )),
    );
  }
}
