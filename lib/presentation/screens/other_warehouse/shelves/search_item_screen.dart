// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import '../../../../constant.dart';
import '../../../../domain/entities/item.dart';
import '../../../bloc/blocs/other/shelve_bloc.dart';
import '../../../bloc/states/other/shelve_states.dart';
import '../../../bloc/events/other/shelve_events.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({super.key});

  @override
  State<SearchItemScreen> createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends State<SearchItemScreen> {
  // List<Item> itemsDropdownData = [];
  Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/shelves_function_screen");
        return false;
      },
      child: Scaffold(
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
          body: Column(
            children: [
              BlocConsumer<ShelveBloc, ShelveState>(listener: (context, state) {
                if (state is GetLotByItemIdLoadingState ||
                    state is GetLotByItemIdLoadingState) {
                  //  LoadingAlertDialog(context).show();
                }
              }, builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 350 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: state.items
                              .map((e) => e.itemId.toString())
                              .toList(),
                          showSearchBox: true,
                          label: "Mã sản phẩm",
                          onChanged: (value) {
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
                      width: 350 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state.items
                            .map((e) => e.itemName.toString())
                            .toList(),
                        showSearchBox: true,
                        label: "Tên sản phẩm",
                        onChanged: (value) {
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
                                  selectedItem!.itemId, state.items));
                        }),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Constants.mainColor,
                      thickness: 1,
                    ),
                    state.itemLot.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                ExceptionErrorState(
                                  icon: Icons.error_outline,
                                  title: "Danh sách rỗng",
                                  message: "",
                                ),
                                CustomizedButton(
                                    text: "Trở về",
                                    onPressed: () {
                                      // reset lại trang tạo phiếu
                                      Navigator.pushNamed(
                                        context,
                                        '/shelves_function_screen',
                                      );
                                    }),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 330 * SizeConfig.ratioHeight,
                                child: ListView.builder(
                                    itemCount: state.itemLot.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              ListTile(
                                              
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 8.0, 0, 8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Mã lô : ${state.itemLot[index].lotId}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16 *
                                                              SizeConfig.ratioFont,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Icon(Icons.edit,
                                                    size: 17 *
                                                        SizeConfig.ratioFont),
                                                    ],
                                                  ),
                                                ),
                                                subtitle: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 150 *
                                                          SizeConfig.ratioWidth,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16 *
                                                                    SizeConfig
                                                                        .ratioFont,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              "Mã hàng: ${state.itemLot[index].item!.itemId}"),
                                                               Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16 *
                                                                    SizeConfig
                                                                        .ratioFont,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              "Tên hàng: ${state.itemLot[index].item!.itemName}"),
                                                          Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16 *
                                                                    SizeConfig
                                                                        .ratioFont,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              "Số lượng: ${state.itemLot[index].quantity}"),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 150 *
                                                          SizeConfig.ratioWidth,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                         
                                                          Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16 *
                                                                    SizeConfig
                                                                        .ratioFont,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              "NSX: ${state.itemLot[index].productionDate == null ? 'Chưa cập nhật' : 
                                                              DateFormat('yyyy-MM-dd').format(state.itemLot[index].productionDate as DateTime)}"),
                                                          Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100,
                                                                fontSize: 16 *
                                                                    SizeConfig
                                                                        .ratioFont,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              "HSD: ${state.itemLot[index].expirationDate == null ? 'Chưa cập nhật' : 
                                                              DateFormat('yyyy-MM-dd').format(state.itemLot[index].expirationDate as DateTime)}"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isThreeLine: true,
                                                onTap: () {},
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: state.itemLot[index]
                                                    .itemLotSubLot.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index1) {
                                                  return ListTile(
                                                    title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 150 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            child: Text(
                                                            "Vị trí: ${state.itemLot[index].itemLotSubLot[index1].locationId}",
                                                             
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 150 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            child: Text(
                                                                "Số lượng: ${state.itemLot[index].itemLotSubLot[index1].quantityPerLocation}"),
                                                          ),
                                                        ]),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              CustomizedButton(
                                  text: "Trở về",
                                  onPressed: () {
                                    // reset lại trang tạo phiếu
                                    Navigator.pushNamed(
                                      context,
                                      '/shelves_function_screen',
                                    );
                                  }),
                            ],
                          ),
                  ],
                );
              }),
            ],
          )),
    );
  }
}
