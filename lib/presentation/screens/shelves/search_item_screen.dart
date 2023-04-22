// ignore_for_file: avoid_print, deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

import '../../../constant.dart';
import '../../../domain/entities/item.dart';
import '../../bloc/blocs/shelve_bloc.dart';
import '../../bloc/states/shelve_states.dart';
import '../../bloc/events/shelve_events.dart';
import '../../widgets/button_widget.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({super.key});

  @override
  State<SearchItemScreen> createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends State<SearchItemScreen> {
  Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.west_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/shelves_function_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Kệ kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: BlocConsumer<ShelveBloc, ShelveState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetAllItemIdSuccessState) {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 340 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state.items.map((e) => e.itemId.toString()).toList(),
                        showSearchBox: true,
                        label: "Mã sản phẩm",
                        // hint: "country in menu mode",
                        onChanged: (value) {
                          //  print(value);
                          setState(() {
                            selectedItem = state.items.firstWhere(
                                (element) => element.itemId == value);
                          });
                        },
                        selectedItem:
                            selectedItem == null ? '' : selectedItem!.itemId,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 340 * SizeConfig.ratioWidth,
                    height: 60 * SizeConfig.ratioHeight,
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      items: state.items.map((e) => e.itemName.toString()).toList(),
                      showSearchBox: true,
                      label: "Tên sản phẩm",
                      // hint: "country in menu mode",
                      onChanged: (value) {
                        //  print(value);
                        setState(() {
                          selectedItem = state.items.firstWhere(
                              (element) => element.itemName == value);
                        });
                      },
                      selectedItem:
                          selectedItem == null ? '' : selectedItem!.itemName,
                    ),
                  ),
                  CustomizedButton(
                      text: "Truy xuất",
                      onPressed: () {
                        BlocProvider.of<ShelveBloc>(context).add(
                            GetLotByItemIdEvent(DateTime.now(),
                                selectedItem!.itemId.toString(), state.items));
                      }),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Constants.mainColor,
                    thickness: 1,
                  ),
                ]);
              }
              if (state is GetLotByItemIdSuccessState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 340 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: state.item.map((e) => e.itemId.toString()).toList(),
                          showSearchBox: true,
                          label: "Mã sản phẩm",
                          // hint: "country in menu mode",
                          onChanged: (value) {
                            //  print(value);
                            setState(() {
                              selectedItem = state.item.firstWhere(
                                  (element) => element.itemId == value);
                            });
                          },
                          selectedItem:
                              selectedItem == null ? '' : selectedItem!.itemId,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 340 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state.item.map((e) => e.itemName.toString()).toList(),
                        showSearchBox: true,
                        label: "Tên sản phẩm",
                        // hint: "country in menu mode",
                        onChanged: (value) {
                          //  print(value);
                          setState(() {
                            selectedItem = state.item.firstWhere(
                                (element) => element.itemName == value);
                          });
                        },
                        selectedItem:
                            selectedItem == null ? '' : selectedItem!.itemName,
                      ),
                    ),
                    CustomizedButton(
                        text: "Truy xuất",
                        onPressed: () {
                          BlocProvider.of<ShelveBloc>(context).add(
                              GetLotByItemIdEvent(DateTime.now(),
                                  selectedItem!.itemId.toString(), state.item));
                          // selectedItem!.itemId));
                        }),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Constants.mainColor,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Danh sách các lô hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 380 * SizeConfig.ratioHeight,
                        child: ListView.builder(
                            itemCount: state.itemLot.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                   child: Container(
                                    height: 110.0 * SizeConfig.ratioHeight,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                child: ListTile(
                                    leading: const Icon(Icons.list),                                 
                                    trailing: Icon(Icons.arrow_drop_down_sharp,
                                        size: 15 * SizeConfig.ratioFont),
                                    title: Text(
                                        "Mã lô : ${state.itemLot[index].lotId}"),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 340 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        // items: state.items.map((e) => e.itemId.toString()).toList(),
                        // showSearchBox: true,
                        label: "Mã sản phẩm",
                        // hint: "country in menu mode",
                        onChanged: (value) {
                          //  print(value);
                          // setState(() {
                          //   selectedItem = state.items.firstWhere(
                          //       (element) => element.itemId == value);
                          // });
                        },
                        selectedItem:
                            selectedItem == null ? '' : selectedItem!.itemId,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 340 * SizeConfig.ratioWidth,
                    height: 60 * SizeConfig.ratioHeight,
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      // items: state.items.map((e) => e.itemName.toString()).toList(),
                      // showSearchBox: true,
                      label: "Tên sản phẩm",
                      // hint: "country in menu mode",
                      onChanged: (value) {
                        //  print(value);
                        // setState(() {
                        //   selectedItem = state.items.firstWhere(
                        //       (element) => element.itemName == value);
                        // });
                      },
                      selectedItem:
                          selectedItem == null ? '' : selectedItem!.itemName,
                    ),
                  ),
                  CustomizedButton(
                      text: "Truy xuất",
                      onPressed: () {
                      //   BlocProvider.of<ShelveBloc>(context).add(
                      //       GetLotByItemIdEvent(DateTime.now(),
                      //           selectedItem!.itemId.toString(), state.items));
                      }),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Constants.mainColor,
                    thickness: 1,
                  ),
                ]);
              }
            }));
  }
}
